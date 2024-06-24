import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/rankings/cubit/rankings_cubit.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_view.dart';

@RoutePage()
class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            create: (context) => RankingsCubit(
              voteCircleRepository: sl<IVoteCircleRepository>(),
              rankingsRepository: sl<IRankingsRepository>(),
            ),
            child: const RankingsView(),
          );
        }
        return const Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
