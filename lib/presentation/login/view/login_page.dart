import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/login/login.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/routes/router.dart';
import 'package:auto_route/auto_route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
          minimum: const EdgeInsets.all(12),
          child: Stack(children: [
            BlocProvider<LoginBloc>(
              create: (context) => sl<LoginBloc>(),
              child: const LoginForm(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  context.router.replace(const SignUpRoute());
                },
                child: const Text('Don\'t have an account? Sign up.'),
              ),
            )
          ])),
    );
  }
}
