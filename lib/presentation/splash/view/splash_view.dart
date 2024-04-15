import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/user/bloc/user_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status.isSuccessful) {
            context.router.replace(const HomeRoute());
          } else if (state.status.isFailure) {
            print('User init loading failure');
          }
        },
        child: Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/brand/logo-colored-64.png'),
                ),
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state.status.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  }

                  return const SizedBox(width: 0, height: 0);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
