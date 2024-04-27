import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_cubit.dart';
import 'package:vote_your_face/presentation/ranking/view/ranking_body.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
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
              return RankingBody(rankings: state.rankings);
            case StatusIndicator.failure:
              return const Center(child: Text('Error'));
          }
        }),
      ),
    );
  }
}
