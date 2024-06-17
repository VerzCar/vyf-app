import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';

part 'circle_member_state.dart';

class CircleMemberCubit extends Cubit<CircleMemberState> {
  CircleMemberCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleMemberState());

  final IVoteCircleRepository _voteCircleRepository;

  void onJoinAsCandidate(int circleId) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      await _voteCircleRepository.joinCircleAsCandidate(circleId);

      emit(state.copyWith(
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(
        status: StatusIndicator.failure,
      ));
    }
  }

  void onJoinAsVoter(int circleId) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      await _voteCircleRepository.joinCircleAsVoter(circleId);

      emit(state.copyWith(
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(
        status: StatusIndicator.failure,
      ));
    }
  }

  void onLeaveAsCandidate(int circleId) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      await _voteCircleRepository.leaveCircleAsCandidate(circleId);

      emit(state.copyWith(
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(
        status: StatusIndicator.failure,
      ));
    }
  }

  void onLeaveAsVoter(int circleId) async {
    emit(state.copyWith(
      status: StatusIndicator.loading,
    ));

    try {
      await _voteCircleRepository.leaveCircleAsVoter(circleId);

      emit(state.copyWith(
        status: StatusIndicator.success,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(
        status: StatusIndicator.failure,
      ));
    }
  }
}
