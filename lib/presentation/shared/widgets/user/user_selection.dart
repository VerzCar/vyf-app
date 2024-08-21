import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/domain/models/models.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({
    super.key,
    required this.selectedUsers,
    this.notSelectableUserIdentIds = const [],
    this.maxSelections,
    required this.onSelect,
    required this.onRemoveFromSelection,
    required this.onChanged,
  });

  final List<SelectedUser> selectedUsers;
  final List<String> notSelectableUserIdentIds;
  final int? maxSelections;
  final void Function(UserPaginated user) onSelect;
  final void Function(UserPaginated user) onRemoveFromSelection;
  final void Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        VyfTextFormField(
          key: const Key('UserSelectionInput_searchInput'),
          onChanged: (name) => onChanged(name),
          hintText: 'Search user',
        ),
        const SizedBox(height: 2),
        _maxSelectedLabel(),
        const SizedBox(height: 5),
        Expanded(
          child: _usersList(context),
        ),
      ],
    );
  }

  Widget _usersList(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        itemCount: selectedUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final su = selectedUsers.elementAt(index);

          final notSelectable = _notSelectable(
            su: su,
            notSelectableUserIdentIds: notSelectableUserIdentIds,
          );

          return BlocSelector<UserSelectCubit, UserSelectState, int>(
            selector: (state) => state.selectedUsers.length,
            builder: (context, selectedUsersLength) {
              return ListTile(
                key: Key(su.user.id.toString()),
                onTap: () => _onTap(
                  selectedUsersLength: selectedUsersLength,
                  su: su,
                  notSelectable: notSelectable,
                ),
                leading: AvatarImage(
                  src: su.user.profile.imageSrc,
                  capitalLetters: usersInitials(su.user.displayName),
                ),
                title: Text(su.user.displayName),
                trailing: _trailing(
                  su: su,
                  notSelectable: notSelectable,
                  selectedUsersLength: selectedUsersLength,
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const ListSeparator());
  }

  bool _notSelectable({
    required SelectedUser su,
    required List<String> notSelectableUserIdentIds,
  }) {
    final notSelectableIndex =
        notSelectableUserIdentIds.indexWhere((id) => id == su.user.identityId);

    if (notSelectableIndex != -1) {
      return true;
    }

    return false;
  }

  bool _maxSelectionReached(int selectedUsersLength) {
    if (maxSelections != null) {
      return selectedUsersLength + notSelectableUserIdentIds.length >=
          maxSelections!;
    }
    return false;
  }

  _onTap({
    required SelectedUser su,
    required bool notSelectable,
    required int selectedUsersLength,
  }) {
    if (notSelectable) {
      return null;
    }

    if (_maxSelectionReached(selectedUsersLength) && !su.selected) {
      return null;
    }

    return su.selected ? onRemoveFromSelection(su.user) : onSelect(su.user);
  }

  Widget _trailing({
    required SelectedUser su,
    required bool notSelectable,
    required int selectedUsersLength,
  }) {
    if (notSelectable) {
      return const Text('already selected');
    }

    bool disabled = false;

    if (_maxSelectionReached(selectedUsersLength) && !su.selected) {
      disabled = true;
    }

    return Checkbox(
      value: su.selected,
      onChanged: disabled
          ? null
          : (value) =>
              su.selected ? onRemoveFromSelection(su.user) : onSelect(su.user),
    );
  }

  Widget _maxSelectedLabel() {
    if (maxSelections != null) {
      return BlocSelector<UserSelectCubit, UserSelectState, int>(
        selector: (state) => state.selectedUsers.length,
        builder: (context, selectedUsersLength) {
          return Text(
              'selections ${selectedUsersLength + notSelectableUserIdentIds.length}/$maxSelections');
        },
      );
    }
    return const SizedBox();
  }
}
