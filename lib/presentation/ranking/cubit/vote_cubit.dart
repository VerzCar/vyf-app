import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'vote_state.dart';

class VoteCubit extends Cubit<VoteState> {
  VoteCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const VoteState());

  final IVoteCircleRepository _voteCircleRepository;

  void voted({
    required int circleId,
    required String candidateId,
  }) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final req = VoteCreateRequest(candidateId: candidateId);

      await _voteCircleRepository.createVote(circleId, req);

      emit(state.copyWith(status: StatusIndicator.success));
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

      emit(state.copyWith(status: StatusIndicator.success));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
