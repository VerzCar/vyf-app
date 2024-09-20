import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/onboarding/view/onboarding_view.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingView();
  }
}
