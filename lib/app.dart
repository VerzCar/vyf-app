import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/routes/router.dart' as r;
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/theme.dart';

import 'injection.dart';

class App extends StatelessWidget {
  final _appRouter = r.AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthenticationBloc>()
            ..add(AuthenticationStatusChanged(
              AuthState(
                authFlowStatus: AuthFlowStatus.unknown,
              ),
            )),
        ),
        // BlocProvider<ProfileEditCubit>(
        //   create: (context) => sl<ProfileEditCubit>(),
        // ),
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: 'Vote your face',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
