import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_cubit.dart';
import 'package:vote_your_face/presentation/ranking/view/ranking_view.dart';

@RoutePage()
class RankingPage extends StatelessWidget {
  const RankingPage({super.key, @pathParam required this.circleId});

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext ctx) =>
                RankingCubit(voteCircleRepository: sl<IVoteCircleRepository>())
                  ..loadRankings(circleId)),
        BlocProvider.value(
          value: BlocProvider.of<CirclesBloc>(context),
        )
      ],
      child: const RankingView(),
    );
  }
}
