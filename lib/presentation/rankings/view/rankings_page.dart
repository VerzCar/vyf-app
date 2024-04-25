import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/rankings/bloc/rankings_bloc.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_view.dart';

@RoutePage()
class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key, this.circleId});

  final int? circleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext ctx) =>
            sl<RankingsBloc>()..add(RankingCircleSelected(circleId: circleId)),
        child: const RankingsView());
  }
}
