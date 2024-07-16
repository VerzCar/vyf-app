import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'circle_ranking_event.dart';

part 'circle_ranking_state.dart';

class CircleRankingBloc extends Bloc<CircleRankingEvent, CircleRankingState> {
  CircleRankingBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleRankingState()) {
    on<CircleRankingReset>(_onCircleRankingReset);
    on<CircleRankingSelected>(_onCircleRankingSelected);
    on<CircleRankingUpdated>(_onCircleRankingUpdated);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onCircleRankingReset(
    CircleRankingReset event,
    Emitter<CircleRankingState> emit,
  ) {
    emit(state.reset());
  }

  void _onCircleRankingSelected(
    CircleRankingSelected event,
    Emitter<CircleRankingState> emit,
  ) async {
    if (state.circle.id == event.circleId) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final circle = await _voteCircleRepository.circle(event.circleId);

      await Future.wait([
        _voteCircleRepository.subscribeToCircleCandidateChangedEvent(circle.id),
        _voteCircleRepository.subscribeToCircleVoterChangedEvent(circle.id),
      ]);

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          circle: circle,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        '_onCircleSelected',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onCircleRankingUpdated(
    CircleRankingUpdated event,
    Emitter<CircleRankingState> emit,
  ) {
    emit(
      state.copyWith(
        circle: event.circle,
      ),
    );
  }
}
