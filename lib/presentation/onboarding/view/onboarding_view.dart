import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/create_circle_members_form.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/create_circle_name_desc_form.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/live_rankings.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/members.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/rules.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/welcome.dart';
import 'package:vote_your_face/presentation/onboarding/widgets/what_is_circle.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<UserBloc>()..add(UserInitialLoaded()),
            ),
            BlocProvider<UserOptionBloc>(
              create: (context) =>
                  sl<UserOptionBloc>()..add(UserOptionLoaded()),
            ),
            BlocProvider(
              create: (context) => CircleCreateFormCubit(
                voteCircleRepository: sl<IVoteCircleRepository>(),
              ),
            ),
          ],
          child: PageView(
            controller: _pageController,
            children: [
              Welcome(
                onNext: _onNext,
              ),
              WhatIsCircle(
                onNext: _onNext,
              ),
              Members(
                onNext: _onNext,
              ),
              LiveRankings(
                onNext: _onNext,
              ),
              Rules(
                onNext: _onNext,
              ),
              CreateCircleNameDescForm(
                onNext: _onNext,
              ),
              CreateCircleMembersForm(
                onNext: _onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linearToEaseOut,
      );
    }
  }
}
