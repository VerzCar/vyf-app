import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'circles_of_interest_state.dart';

class CirclesOfInterestCubit extends Cubit<CirclesOfInterestState> {
  CirclesOfInterestCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CirclesOfInterestState());

  final IVoteCircleRepository _voteCircleRepository;

  Future<void> loadCircles() async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final circles = await _voteCircleRepository.circlesOfInterest();
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          circlesOfInterest: circles,
        ),
      );
    } catch (e) {
      print(e);
      if(isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
