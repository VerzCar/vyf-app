import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/settings/view/settings_view.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

