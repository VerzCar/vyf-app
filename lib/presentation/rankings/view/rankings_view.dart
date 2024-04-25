import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/rankings/cubit/rankings_cubit.dart';
import 'package:vote_your_face/presentation/rankings/view/rankings_body.dart';

class RankingsView extends StatelessWidget {
  const RankingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: SafeArea(
        child:
            BlocBuilder<RankingsCubit, RankingsState>(builder: (context, state) {
          switch (state.status) {
            case StatusIndicator.initial:
              return const Center(child: Text('initial Loading'));
            case StatusIndicator.loading:
              return const Center(child: CircularProgressIndicator());
            case StatusIndicator.success:
              return RankingsBody(rankings: state.rankings);
            case StatusIndicator.failure:
              return const Center(child: Text('Error'));
          }
        }),
      ),
    );
  }
}
