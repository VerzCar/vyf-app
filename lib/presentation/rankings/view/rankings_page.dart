import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/rankings/cubit/rankings_cubit.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_view.dart';

@RoutePage()
class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key, @pathParam this.circleId});

  final int? circleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext ctx) =>
            RankingsCubit(voteCircleRepository: sl<IVoteCircleRepository>())
              ..loadRankings(circleId),
        child: const RankingsView());
  }
}
