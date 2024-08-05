import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

part 'ranking_item_state.dart';

class RankingItemCubit extends Cubit<RankingItemState> {
  RankingItemCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const RankingItemState());

  final IVoteCircleRepository _voteCircleRepository;

  void loadVotedByIds({
    required int circleId,
    required String candidateIdentId,
  }) async {
    try {
      emit(state.copyWith(status: StatusIndicator.loading));

      final request = CandidateRequest(candidate: candidateIdentId);

      final ids = await _voteCircleRepository.circleCandidateVotedBy(
        circleId,
        request,
      );

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          votedByIds: ids,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        'loadVotedByIds',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
