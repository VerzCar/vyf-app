import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/settings/view/user_settings_body.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _editActionButton(context),
          ),
        ],
      ),
      body: const SafeArea(
        child: UserSettingsBody(),
      ),
    );
  }

  Widget _editActionButton(BuildContext context) {
    final themeData = Theme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: themeData.colorScheme.secondary,
      ),
      onPressed: () => context.pushRoute(const UserEditSettingsRoute()),
      child: const Text('Edit'),
    );
  }
}
