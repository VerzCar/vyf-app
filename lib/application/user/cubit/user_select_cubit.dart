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

      final searchResults = users
          .map((user) => SelectedUser(
                user: user,
                selected: false,
              ))
          .toList();

      emit(
        state.copyWith(
          status: StatusIndicator.success,
          searchResults: searchResults,
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
      final foundUsers = await _userRepository.usersFiltered(name);

      final currentSelectedUsers = state.selectedUsers;

      final resultUsers = foundUsers.map((user) {
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
          searchResults: resultUsers,
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
      final searchResults = List.of(state.searchResults);

      final searchResultIndex =
          searchResults.indexWhere((su) => su.user.id == user.id);

      if (searchResultIndex == -1) {
        return;
      }

      final selectedUser = SelectedUser(
        user: user,
        selected: true,
      );

      searchResults[searchResultIndex] = selectedUser;

      final selectedUsers = List.of(state.selectedUsers);
      selectedUsers.add(selectedUser);

      emit(state.copyWith(
        searchResults: searchResults,
        selectedUsers: selectedUsers,
      ));
    } catch (e) {
      sl<Logger>().t(
        'selectUser',
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
      final searchResults = List.of(state.searchResults);

      final searchResultIndex =
          searchResults.indexWhere((su) => su.user.id == user.id);

      if (searchResultIndex == -1) {
        return;
      }

      final selectedUser = SelectedUser(
        user: user,
        selected: false,
      );

      searchResults[searchResultIndex] = selectedUser;

      final selectedUsers = List.of(state.selectedUsers);

      final selectedUserIndex =
          selectedUsers.indexWhere((su) => su.user.id == user.id);

      if (selectedUserIndex > -1) {
        selectedUsers.removeAt(selectedUserIndex);
      }

      emit(state.copyWith(
        searchResults: searchResults,
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
