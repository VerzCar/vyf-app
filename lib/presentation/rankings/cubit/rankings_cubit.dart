import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'rankings_state.dart';

class RankingsCubit extends Cubit<RankingsState> {
  RankingsCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const RankingsState());

  final IVoteCircleRepository _voteCircleRepository;

  Future<void> loadRankings(int? circleId) async {
    print(circleId);
    if (circleId == null) {
      return emit(
          state.copyWith(status: StatusIndicator.initial, rankings: const []));
    }

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
