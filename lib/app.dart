import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/circles/bloc/circles_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/routes/router.dart';
import 'package:vote_your_face/theme.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthenticationBloc>()
            ..add(AuthenticationStatusChanged(
              AuthState(authFlowStatus: AuthFlowStatus.unknown),
            )),
        ),
        BlocProvider(
          create: (context) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CirclesBloc>(),
        ),
        BlocProvider<CircleBloc>(
          create: (context) => sl<CircleBloc>(),
        ),
        BlocProvider<MembersBloc>(
          create: (context) => sl<MembersBloc>(),
        ),
        BlocProvider<UserOptionBloc>(
          create: (context) => sl<UserOptionBloc>(),
        ),
      ],
      child: Authenticator(
        child: MaterialApp.router(
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          debugShowCheckedModeBanner: false,
          title: 'Vote your face',
          theme: AppTheme.lightTheme(MediaQuery.platformBrightnessOf(context)),
          darkTheme:
              AppTheme.darkTheme(MediaQuery.platformBrightnessOf(context)),
          themeMode: ThemeMode.light,
          builder: Authenticator.builder(),
        ),
      ),
    );
  }
}
