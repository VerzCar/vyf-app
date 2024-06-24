import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'ranking_state.dart';

class RankingCubit extends Cubit<RankingState> {
  RankingCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const RankingState());

  final IVoteCircleRepository _voteCircleRepository;

  void loadRankings(int circleId) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final rankings = await _voteCircleRepository.rankings(circleId);
      emit(
        state.copyWith(
          status: StatusIndicator.success,
          rankings: rankings,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
