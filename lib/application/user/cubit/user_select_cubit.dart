import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/domain/models/models.dart';
import 'package:vote_your_face/injection.dart';

part 'user_select_state.dart';

class UserSelectCubit extends Cubit<UserSelectState> {
  UserSelectCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserSelectState());

  final IUserRepository _userRepository;

  void initialLoadUsers() async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final users = await _userRepository.users();

      final selectedUsers = users
          .map(
            (user) => SelectedUser(user: user, selected: false),
          )
          .toList();

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          selectedUsers: selectedUsers,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        'initialLoadUsers',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(status: StatusIndicator.failure));
    }
  }

  void loadUsers({required String name}) async {
    emit(state.copyWith(status: StatusIndicator.loading));

    try {
      final currentSelectedUsers = List.of(state.selectedUsers);

      final users = await _userRepository.usersFiltered(name);

      final selectedUsers = users.map((user) {
        final selectedUserIndex =
            currentSelectedUsers.indexWhere((su) => su.user.id == user.id);

        if (selectedUserIndex == -1) {
          return SelectedUser(user: user, selected: false);
        }

        return SelectedUser(
          user: user,
          selected: currentSelectedUsers[selectedUserIndex].selected,
        );
      }).toList();

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          selectedUsers: selectedUsers,
        ),
      );
    } catch (e) {
      sl<Logger>().t(
        'loadUsers',
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
