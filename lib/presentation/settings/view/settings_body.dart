import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView(
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: ListTile(
                leading: UserAvatar(
                  identityId: state.user.identityId,
                ),
                title: Text(
                  state.user.username,
                  style: themeData.textTheme.titleMedium,
                ),
                subtitle:
                    Text('${state.user.firstName} ${state.user.lastName}'),
                onTap: () => {},
              ),
            );
          },
        ),
        const Divider(),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            title: Text(
              'Impressum',
              textAlign: TextAlign.center,
              style: themeData.textTheme.titleMedium,
            ),
            onTap: () => {},
          ),
        ),
        const Divider(),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            title: Text(
              'Privacy',
              textAlign: TextAlign.center,
              style: themeData.textTheme.titleMedium,
            ),
            onTap: () => {},
          ),
        ),
        const Divider(),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            title: Text(
              'Sign out',
              textAlign: TextAlign.center,
              style:
                  themeData.textTheme.titleMedium?.copyWith(color: Colors.red),
            ),
            onTap: () => {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested())
            },
          ),
        ),
      ],
    );
  }
}
