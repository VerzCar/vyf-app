import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/presentation/home/view/home_view.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

import '../cubit/home_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print(state.status);
        // if (state.status == AuthFlowStatus.unauthenticated) {
        //   context.router.pushAndPopUntil(const LoginRoute(),
        //       predicate: (Route<dynamic> route) => false);
        // }
      },
      child: const HomeView(),
    );
  }
}
