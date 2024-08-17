import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserSelectionSheet extends StatelessWidget {
  const UserSelectionSheet({
    super.key,
    this.notSelectableUserIdentIds = const [],
    this.onAdd,
  });

  final List<String> notSelectableUserIdentIds;
  final void Function(List<UserPaginated> users)? onAdd;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) => UserSelectCubit(
        userRepository: sl<IUserRepository>(),
      )..initialLoadUsers(),
      child: BodyLayout(
        verticalPadding: 10.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserSelectCubit, UserSelectState>(
              builder: (context, state) {
                return _buttonActionRow(context);
              },
            ),
            const SizedBox(height: 5.0),
            BlocBuilder<UserSelectCubit, UserSelectState>(
              builder: (context, state) {
                return Expanded(
                  child: UserSelection(
                    selectedUsers: state.searchResults,
                    notSelectableUserIdentIds: notSelectableUserIdentIds,
                    onSelect: (user) =>
                        context.read<UserSelectCubit>().selectUser(user: user),
                    onRemoveFromSelection: (user) => context
                        .read<UserSelectCubit>()
                        .removeFromSelection(user: user),
                    onChanged: (text) =>
                        context.read<UserSelectCubit>().loadUsers(name: text),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonActionRow(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => context.router.maybePop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (onAdd != null) {
              final selectedUsers =
                  context.read<UserSelectCubit>().state.selectedUsers;

              final usersWithSelection =
                  selectedUsers.where((su) => su.selected);

              onAdd!(usersWithSelection.map((su) => su.user).toList());
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: themeData.colorScheme.secondary,
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
