import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vote_your_face/presentation/shared.dart';
import 'package:vote_your_face/presentation/routes/router.dart';
import 'package:vote_your_face/presentation/login/login.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.router.replace(const SplashRoute());
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _FormTitle(),
            const Padding(padding: EdgeInsets.all(20)),
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Melde dich mit deinem Account an');
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return VecTextFormField(
          key: const Key('loginForm_usernameInput_textFormField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          labelText: 'username',
          errorText: 'invalid username',
          showError: state.username.invalid,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return VecTextFormField(
          key: const Key('loginForm_passwordInput_textFormField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          labelText: 'password',
          errorText: 'invalid password',
          showError: state.password.invalid,
          obscureText: true,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SubmitButton(
          key: const Key('loginForm_submitButton'),
          submitText: 'Login',
          onPressed: () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
          isDisabled: !state.status.isValidated,
          isLoading: state.status.isSubmissionInProgress,
        );
      },
    );
  }
}
