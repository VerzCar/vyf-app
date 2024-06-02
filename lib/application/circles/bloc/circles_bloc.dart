import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'circles_event.dart';

part 'circles_state.dart';

class CirclesBloc extends Bloc<CirclesEvent, CirclesState> {
  CirclesBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CirclesState()) {
    on<CirclesOfUserInitialLoaded>(_onCirclesOfUserInitialLoaded);
    on<CircleCreated>(_onCircleCreated);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onCirclesOfUserInitialLoaded(
    CirclesOfUserInitialLoaded event,
    Emitter<CirclesState> emit,
  ) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final circles = await _voteCircleRepository.circles();
      emit(
        state.copyWith(
          myCircles: circles,
          status: StatusIndicator.success,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onCircleCreated(
    CircleCreated event,
    Emitter<CirclesState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    final myCircles = state.myCircles;
    myCircles.insert(0, event.circle);

    emit(
      state.copyWith(
        myCircles: myCircles,
        status: StatusIndicator.success,
      ),
    );
  }
}
