import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';

part 'commitment_state.dart';

class CommitmentCubit extends Cubit<CommitmentState> {
  CommitmentCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CommitmentState());

  final IVoteCircleRepository _voteCircleRepository;

  void committed({
    required int circleId,
  }) async {
    emit(state.copyWith(status: CommitmentStatus.committedLoading));

    try {
      const req =
          CircleCandidateCommitmentRequest(commitment: Commitment.committed);

      await _voteCircleRepository.updateCommitment(circleId, req);

      emit(state.copyWith(status: CommitmentStatus.committedSuccess));
    } catch (e) {
      sl<Logger>().t(
        'committed',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: CommitmentStatus.failure));
    }
  }

  void rejected({
    required int circleId,
  }) async {
    emit(state.copyWith(status: CommitmentStatus.rejectedLoading));

    try {
      const req =
          CircleCandidateCommitmentRequest(commitment: Commitment.rejected);

      await _voteCircleRepository.updateCommitment(circleId, req);

      emit(state.copyWith(status: CommitmentStatus.rejectedSuccess));
    } catch (e) {
      sl<Logger>().t(
        'committed',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: CommitmentStatus.failure));
    }
  }
}
