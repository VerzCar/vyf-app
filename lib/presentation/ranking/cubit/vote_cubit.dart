import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';

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

      await _voteCircleRepository.createVote(circleId, req).whenComplete(
          () => emit(state.copyWith(status: StatusIndicator.success)));
    } catch (e) {
      sl<Logger>().t(
        'voted',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void revokedVote({
    required int circleId,
  }) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      await _voteCircleRepository.revokeVote(circleId).whenComplete(
          () => emit(state.copyWith(status: StatusIndicator.success)));
    } catch (e) {
      sl<Logger>().t(
        'revokedVote',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
