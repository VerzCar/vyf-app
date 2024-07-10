import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/core/core.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'circles_event.dart';
part 'circles_state.dart';

class CirclesBloc extends Bloc<CirclesEvent, CirclesState> {
  CirclesBloc({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CirclesState()) {
    on<CirclesReset>(_onCirclesReset);
    on<CirclesOfUserInitialLoaded>(_onCirclesOfUserInitialLoaded);
    on<CircleCreated>(_onCircleCreated);
    on<CircleUpdated>(_onCircleUpdated);
    on<CircleDeleted>(_onCircleDeleted);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onCirclesReset(
    CirclesReset event,
    Emitter<CirclesState> emit,
  ) {
    emit(state.reset());
  }

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
      sl<Logger>().t(
        '_onCirclesOfUserInitialLoaded',
        error: e,
      );
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

  void _onCircleUpdated(
    CircleUpdated event,
    Emitter<CirclesState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    final myCircles = state.myCircles;
    final myCircleIndex =
        myCircles.indexWhere((circle) => circle.id == event.circle.id);

    if (myCircleIndex == -1) {
      return emit(state.copyWith(
        status: StatusIndicator.success,
      ));
    }

    myCircles[myCircleIndex] = event.circle;

    emit(
      state.copyWith(
        myCircles: myCircles,
        status: StatusIndicator.success,
      ),
    );
  }

  void _onCircleDeleted(
    CircleDeleted event,
    Emitter<CirclesState> emit,
  ) {
    emit(state.copyWith(status: StatusIndicator.loading));

    final myCircles = state.myCircles;
    final myCircleIndex =
        myCircles.indexWhere((circle) => circle.id == event.circleId);

    if (myCircleIndex == -1) {
      return emit(state.copyWith(
        status: StatusIndicator.success,
      ));
    }

    myCircles.removeAt(myCircleIndex);

    emit(
      state.copyWith(
        myCircles: myCircles,
        status: StatusIndicator.success,
      ),
    );
  }
}
