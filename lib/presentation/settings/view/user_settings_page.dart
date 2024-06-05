import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/settings/view/user_settings_view.dart';

@RoutePage()
class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const UserSettingsView();
  }
}
