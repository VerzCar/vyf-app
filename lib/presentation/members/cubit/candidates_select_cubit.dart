import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/members/models/models.dart';

part 'candidates_select_state.dart';

class CandidatesSelectCubit extends Cubit<CandidatesSelectState> {
  CandidatesSelectCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CandidatesSelectState());

  final IVoteCircleRepository _voteCircleRepository;

  void addToSelection({
    required UserPaginated user,
  }) {
    try {
      final selectedUsers = List.of(state.selectedUsers);

      final selectedUser = SelectedUser(
        user: user,
        selected: true,
      );
      selectedUsers.add(selectedUser);

      emit(state.copyWith(
        selectedUsers: selectedUsers,
      ));
    } catch (e) {
      sl<Logger>().t(
        'addToSelection',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void selectUser({
    required UserPaginated user,
  }) {
    try {
      final selectedUsers = List.of(state.selectedUsers);

      final selectedUserIndex =
      selectedUsers.indexWhere((su) => su.user.id == user.id);

      if (selectedUserIndex == -1) {
        return;
      }

      final selectedUser = SelectedUser(
        user: user,
        selected: true,
      );

      selectedUsers[selectedUserIndex] = selectedUser;

      emit(state.copyWith(
        selectedUsers: selectedUsers,
      ));
    } catch (e) {
      sl<Logger>().t(
        'addToSelection',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void removeFromSelection({
    required UserPaginated user,
  }) {
    try {
      final selectedUsers = List.of(state.selectedUsers);

      final selectedUserIndex =
          selectedUsers.indexWhere((su) => su.user.id == user.id);

      if (selectedUserIndex == -1) {
        return;
      }

      final selectedUser = SelectedUser(
        user: user,
        selected: false,
      );

      selectedUsers[selectedUserIndex] = selectedUser;

      emit(state.copyWith(
        selectedUsers: selectedUsers,
      ));
    } catch (e) {
      sl<Logger>().t(
        'removeFromSelection',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }
}
