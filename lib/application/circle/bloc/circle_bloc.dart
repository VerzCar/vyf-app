import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'circle_event.dart';
part 'circle_state.dart';

class CircleBloc extends Bloc<CircleEvent, CircleState> {
  CircleBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleState()) {
    on<CircleSelected>(_onCircleSelected);
    on<CircleUpdated>(_onCircleUpdated);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onCircleSelected(
    CircleSelected event,
    Emitter<CircleState> emit,
  ) async {
    if (state.circle.id == event.circleId) return;

    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final circle = await _voteCircleRepository.circle(event.circleId);

      _voteCircleRepository.subscribeToCircleCandidateChangedEvent(circle.id);

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          circle: circle,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onCircleUpdated(
    CircleUpdated event,
    Emitter<CircleState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    emit(
      state.copyWith(
        circle: event.circle,
        status: StatusIndicator.success,
      ),
    );
  }
}
