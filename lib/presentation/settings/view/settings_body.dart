import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  static final BorderRadius _borderRadius = BorderRadius.circular(10.0);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView(
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Card.outlined(
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: _borderRadius,
                ),
                leading: UserAvatar(
                  identityId: state.user.identityId,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
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
        Card.outlined(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
            title: Text(
              'Impressum',
              textAlign: TextAlign.center,
              style: themeData.textTheme.titleMedium,
            ),
            onTap: () => {},
          ),
        ),
        Card.outlined(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
            title: Text(
              'Privacy & Terms',
              textAlign: TextAlign.center,
              style: themeData.textTheme.titleMedium,
            ),
            onTap: () => {},
          ),
        ),
        Card.outlined(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
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
