import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circles/view/circles_view.dart';

@RoutePage()
class CirclesPage extends StatelessWidget {
  const CirclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<CirclesBloc>(context)
            ..add(CirclesOfUserInitialLoaded())
            ..add(CirclesWithOpenCommitmentsLoaded()),
        ),
        BlocProvider(
          create: (BuildContext ctx) => CirclesOfInterestCubit(
              voteCircleRepository: sl<IVoteCircleRepository>())
            ..loadCircles(),
        ),
      ],
      child: const CirclesView(),
    );
  }
}
