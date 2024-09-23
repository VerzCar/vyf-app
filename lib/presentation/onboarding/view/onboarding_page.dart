import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_settings_repository/shared_settings_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/onboarding/view/onboarding_view.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    _resetInitialUseOfApp();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserBloc>()..add(UserInitialLoaded()),
        ),
        BlocProvider<UserOptionBloc>(
          create: (context) => sl<UserOptionBloc>()..add(UserOptionLoaded()),
        ),
        BlocProvider(
          create: (context) => CircleCreateFormCubit(
            voteCircleRepository: sl<IVoteCircleRepository>(),
          ),
        ),
      ],
      child: const OnboardingView(),
    );
  }

  void _resetInitialUseOfApp() {
    sl<ISharedSettingsRepository>().savePreferences(
      const SharedSetting(initialUseOfApp: false),
    );
  }
}
