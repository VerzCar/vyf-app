import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/widgets/user/user_selection.dart';

class UserSelectionSheet extends StatelessWidget {
  const UserSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) => UserSelectCubit(
        userRepository: sl<IUserRepository>(),
      )..initialLoadUsers(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: _buttonActionRow(context),
          ),
          // const SizedBox(height: 5),
          BlocBuilder<UserSelectCubit, UserSelectState>(
            builder: (context, state) {
              return Expanded(
                child: UserSelection(
                  selectedUsers: state.selectedUsers,
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
    );
  }

  Widget _buttonActionRow(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => {},
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {},
          child: const Text('Add'),
          style: TextButton.styleFrom(
            foregroundColor: themeData.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
