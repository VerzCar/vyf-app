import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/onboarding/view/onboarding_body.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CircleCreateFormCubit, CircleCreateFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess || state.status.isFailure) {
              context.router.navigate(const HomeRoute());
            }
          },
          child: const OnboardingBody(),
        ),
      ),
    );
  }
}
