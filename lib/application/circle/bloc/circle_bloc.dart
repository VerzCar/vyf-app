import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'circle_event.dart';

part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  CircleBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleState()) {
    on<CircleSelected>(_onCircleSelected);
    on<CircleUpdated>(_onCircleUpdated);
    on<CircleImageUpdated>(_onCircleImageUpdated);
  }

  final IVoteCircleRepository _voteCircleRepository;

  @override
  Future<void> close() {
    _voteCircleRepository.dispose();
    return super.close();
  }

  void _onCircleSelected(
    CircleSelected event,
    Emitter<CircleState> emit,
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

  void _onCircleUpdated(
    CircleUpdated event,
    Emitter<CircleState> emit,
  ) {
    emit(
      state.copyWith(
        circle: event.circle,
      ),
    );
  }

  void _onCircleImageUpdated(
    CircleImageUpdated event,
    Emitter<CircleState> emit,
  ) {
    emit(
      state.copyWith(
        circle: state.circle.copyWith(
          imageSrc: event.imageSrc,
        ),
      ),
    );
  }
}
