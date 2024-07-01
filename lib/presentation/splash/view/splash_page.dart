import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/splash/view/splash_view.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<UserBloc>(context)..add(UserInitialLoaded()),
        ),
        BlocProvider.value(
          value: BlocProvider.of<UserOptionCubit>(context)..userOptionLoaded(),
        ),
      ],
      child: const SplashView(),
    );
  }
}
