import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_cubit.dart';

import 'circle_view.dart';

@RoutePage()
class CirclePage extends StatelessWidget {
  const CirclePage({super.key, @pathParam required this.circleId});

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) =>
          CircleCubit(voteCircleRepository: sl<IVoteCircleRepository>())
            ..selectCircle(circleId),
      child: const CircleView(),
    );
  }
}
