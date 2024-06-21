import 'package:authentication_repository/authentication_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/authentication/authentication.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/home/view/home_view.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This is necessary because after logout and login the user wont be redirected
    // to the splash page, therefore the user must be reloaded after login
    final userBloc = context.read<UserBloc>();
    final userState = userBloc.state;
    if (userState.user.identityId.isEmpty) {
      userBloc.add(UserInitialLoaded());
    }

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previousState, state) =>
      state.status != previousState.status,
      listener: (context, state) {
        if (state.status == AuthFlowStatus.unauthenticated) {
          context.read<UserBloc>().add(UserReset());
          context.read<CirclesBloc>().add(CirclesReset());
          context.read<CircleBloc>().add(CircleReset());
          context.read<MembersBloc>().add(CircleMembersReset());
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          // TODO: this is the same logic as in splash view, combine them
          if (state.status.isLoading) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            );
          }

          return const HomeView();
        },
      ),
    );
  }
}
