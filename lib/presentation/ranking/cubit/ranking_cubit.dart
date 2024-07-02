import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'ranking_state.dart';

class RankingCubit extends Cubit<RankingState> {
  RankingCubit({
    required IVoteCircleRepository voteCircleRepository,
    required IRankingsRepository rankingsRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        _rankingsRepository = rankingsRepository,
        super(const RankingState());

  final IVoteCircleRepository _voteCircleRepository;
  final IRankingsRepository _rankingsRepository;

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

  void addToViewedRankings(int circleId) {
    try {
      _rankingsRepository.addToViewedRankings(circleId.toString());
    } catch (e) {
      print(e);
    }
  }

  void voted({
    required int circleId,
    required String candidateId,
  }) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final req = VoteCreateRequest(candidateId: candidateId);

      await _voteCircleRepository.createVote(circleId, req);

      emit(
        state.copyWith(
          status: StatusIndicator.success,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void revokedVote({
    required int circleId,
  }) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      await _voteCircleRepository.revokeVote(circleId);

      emit(
        state.copyWith(
          status: StatusIndicator.success,
        ),
      );
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
