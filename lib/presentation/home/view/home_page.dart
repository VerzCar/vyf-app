import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/rankings/rankings.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/home/view/home_view.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserBloc>()..add(UserInitialLoaded()),
        ),
        BlocProvider(
          create: (context) => sl<CirclesBloc>(),
        ),
        BlocProvider<CircleBloc>(
          create: (context) => sl<CircleBloc>(),
        ),
        BlocProvider<CircleRankingBloc>(
          create: (context) => sl<CircleRankingBloc>(),
        ),
        BlocProvider<MembersBloc>(
          create: (context) => sl<MembersBloc>(),
        ),
        BlocProvider<UserOptionBloc>(
          create: (context) => sl<UserOptionBloc>()..add(UserOptionLoaded()),
        ),
        BlocProvider(
          create: (context) => RankingsCubit(
            voteCircleRepository: sl<IVoteCircleRepository>(),
            rankingsRepository: sl<IRankingsRepository>(),
          ),
        ),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
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
