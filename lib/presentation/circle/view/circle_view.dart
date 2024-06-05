import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/circle/view/circle_body.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class CircleView extends StatelessWidget {
  const CircleView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final circleName =
        context.select((CircleBloc cubit) => cubit.state.circle.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(circleName),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<CircleBloc, CircleState>(
              builder: (context, state) {
                return TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: themeData.colorScheme.secondary,
                  ),
                  child: const Text('Edit'),
                  onPressed: () => state.status == StatusIndicator.success
                      ? context.router
                          .push(CircleEditRoute(circleId: state.circle.id))
                      : null,
                );
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CircleBloc, CircleState>(builder: (context, state) {
          switch (state.status) {
            case StatusIndicator.initial:
              return const Center(child: Text('initial Loading'));
            case StatusIndicator.loading:
              return const Center(child: CircularProgressIndicator());
            case StatusIndicator.success:
              return CircleBody(circle: state.circle);
            case StatusIndicator.failure:
              return const Center(child: Text('Error'));
          }
        }),
      ),
    );
  }
}
