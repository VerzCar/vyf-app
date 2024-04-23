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
    on<CirclesOfInterestInitialLoaded>(_onCirclesOfInterestInitialLoaded);
  }

  final IVoteCircleRepository _voteCircleRepository;

  void _onCirclesOfUserInitialLoaded(
    CirclesOfUserInitialLoaded event,
    Emitter<CirclesState> emit,
  ) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final circles = await _voteCircleRepository.circles();
      emit(state.copyWith(myCircles: circles, status: StatusIndicator.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void _onCirclesOfInterestInitialLoaded(
    CirclesOfInterestInitialLoaded event,
    Emitter<CirclesState> emit,
  ) async {
    try {
      final circles = await _voteCircleRepository.circlesOfInterest();
      emit(state.copyWith(
          circlesOfInterest: circles, status: StatusIndicator.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
