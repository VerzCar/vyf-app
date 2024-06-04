import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/settings/view/user_settings_view.dart';

@RoutePage()
class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserEditProfileCubit(userRepository: sl<IUserRepository>()),
      child: const UserSettingsView(),
    );
  }
}
