import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/settings/view/user_settings_body.dart';
import 'package:vote_your_face/presentation/settings/widgets/bio_input.dart';
import 'package:vote_your_face/presentation/settings/widgets/user_first_name_input.dart';
import 'package:vote_your_face/presentation/settings/widgets/user_last_name_input.dart';
import 'package:vote_your_face/presentation/settings/widgets/why_vote_me_input.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class UserSettingsView extends StatelessWidget {
  const UserSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: themeData.colorScheme.secondary,
              ),
              onPressed: () => context.pushRoute(const UserEditSettingsRoute()),
              child: const Text('Edit'),
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: UserSettingsBody(),
      ),
    );
  }
}
