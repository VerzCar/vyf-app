import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_cubit.dart';
import 'package:vote_your_face/presentation/ranking/view/ranking_body.dart';

class RankingView extends StatelessWidget {
  const RankingView({
    super.key,
    required this.circleId,
  });

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CircleBloc, CircleState>(
          builder: (context, state) {
            return Text('Ranking ${state.circle.name}');
          },
        ),
      ),
      body: SafeArea(
        child:
            BlocBuilder<RankingCubit, RankingState>(builder: (context, state) {
          switch (state.status) {
            case StatusIndicator.initial:
              return const Center(child: Text('initial Loading'));
            case StatusIndicator.loading:
              return const Center(child: CircularProgressIndicator());
            case StatusIndicator.success:
              return RankingBody(
                rankings: state.rankings,
                circleId: circleId,
              );
            case StatusIndicator.failure:
              return const Center(child: Text('Error'));
          }
        }),
      ),
    );
  }
}
