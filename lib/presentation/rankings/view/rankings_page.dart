import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/rankings/bloc/rankings_bloc.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_view.dart';

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key, this.circleId});

  final int? circleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext ctx) => RankingsBloc(
              voteCircleRepository: sl<IVoteCircleRepository>(),
              userRepository: sl<IUserRepository>(),
            )..add(RankingCircleSelected(circleId: circleId ?? 0)),
        child: const RankingsView());
  }
}
