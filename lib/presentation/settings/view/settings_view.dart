import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/settings/view/settings_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const SettingsBody(),
        ),
      ),
    );
  }
}
