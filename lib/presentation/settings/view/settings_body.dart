import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

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
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: _borderRadius,
                ),
                leading: UserXProvider(
                  identityId: state.user.identityId,
                  child: UserAvatar(
                    key: ValueKey(state.user.identityId),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                title: Text(
                  state.user.displayName,
                  style: themeData.textTheme.titleMedium,
                ),
                subtitle:
                    Text('${state.user.username} | ${state.user.firstName} ${state.user.lastName}'),
                onTap: () => {context.pushRoute(const UserSettingsRoute())},
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
              'Rules & Regulations',
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
              'FAQ & Help',
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
        const SizedBox(height: 10),
        Center(
          child: FutureBuilder(
            future: _currentAppVersion(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Future<String> _currentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return 'Version: $version | $buildNumber';
  }
}
