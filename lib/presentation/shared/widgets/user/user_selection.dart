import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/domain/models/models.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserSelection extends StatelessWidget {
  const UserSelection({
    super.key,
    required this.selectedUsers,
    this.notSelectableUserIdentIds = const [],
    required this.onSelect,
    required this.onRemoveFromSelection,
    required this.onChanged,
  });

  final List<SelectedUser> selectedUsers;
  final List<String> notSelectableUserIdentIds;
  final void Function(UserPaginated user) onSelect;
  final void Function(UserPaginated user) onRemoveFromSelection;
  final void Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VyfTextFormField(
          key: const Key('UserSelectionInput_searchInput'),
          onChanged: (name) => onChanged(name),
          hintText: 'Search user',
        ),
        const SizedBox(height: 5),
        Expanded(
          child: _usersList(context),
        ),
      ],
    );
  }

  Widget _usersList(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        itemCount: selectedUsers.length,
        itemBuilder: (BuildContext context, int index) {
          final su = selectedUsers.elementAt(index);

          final notSelectable = _notSelectable(
            su: su,
            notSelectableUserIdentIds: notSelectableUserIdentIds,
          );

          return ListTile(
            key: Key(su.user.id.toString()),
            onTap: notSelectable
                ? null
                : () => su.selected
                    ? onRemoveFromSelection(su.user)
                    : onSelect(su.user),
            leading: AvatarImage(
              src: su.user.profile.imageSrc,
              capitalLetters: usersInitials(su.user.displayName),
            ),
            title: Text(su.user.displayName),
            trailing: _trailing(su: su, notSelectable: notSelectable),
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

  Widget _trailing({
    required SelectedUser su,
    required bool notSelectable,
  }) {
    if (notSelectable) {
      return const Text('already selected');
    }

    return Checkbox(
      value: su.selected,
      onChanged: (value) =>
          su.selected ? onRemoveFromSelection(su.user) : onSelect(su.user),
    );
  }
}
