import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';

part 'circle_member_state.dart';

class CircleMemberCubit extends Cubit<CircleMemberState> {
  CircleMemberCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleMemberState());

  final IVoteCircleRepository _voteCircleRepository;

  void onJoinAsCandidate(int circleId) async {
    emit(state.copyWith(
      status: CircleMemberStateStatus.loadingCandidate,
    ));

    try {
      await _voteCircleRepository.joinCircleAsCandidate(circleId);

      emit(state.copyWith(
        status: CircleMemberStateStatus.successCandidate,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onJoinAsCandidate',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CircleMemberStateStatus.failureCandidate,
      ));
    }
  }

  void onJoinAsVoter(int circleId) async {
    emit(state.copyWith(
      status: CircleMemberStateStatus.loadingVoter,
    ));

    try {
      await _voteCircleRepository.joinCircleAsVoter(circleId);

      emit(state.copyWith(
        status: CircleMemberStateStatus.successVoter,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onJoinAsVoter',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CircleMemberStateStatus.failureVoter,
      ));
    }
  }

  void onLeaveAsCandidate(int circleId) async {
    emit(state.copyWith(
      status: CircleMemberStateStatus.loadingCandidate,
    ));

    try {
      await _voteCircleRepository.leaveCircleAsCandidate(circleId);

      emit(state.copyWith(
        status: CircleMemberStateStatus.successCandidate,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onLeaveAsCandidate',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CircleMemberStateStatus.failureCandidate,
      ));
    }
  }

  void onLeaveAsVoter(int circleId) async {
    emit(state.copyWith(
      status: CircleMemberStateStatus.loadingVoter,
    ));

    try {
      await _voteCircleRepository.leaveCircleAsVoter(circleId);

      emit(state.copyWith(
        status: CircleMemberStateStatus.successVoter,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onLeaveAsVoter',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CircleMemberStateStatus.failureVoter,
      ));
    }
  }
}
