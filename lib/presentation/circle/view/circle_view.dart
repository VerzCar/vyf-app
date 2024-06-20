import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/bloc/user_bloc.dart';
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
            child: _editActionButton(themeData),
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

  Widget _editActionButton(ThemeData themeData) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.user.identityId,
      builder: (context, identityId) =>
          BlocSelector<CircleBloc, CircleState, int?>(
        selector: (state) =>
            CircleSelector.canEdit(state, identityId) ? state.circle.id : null,
        builder: (context, circleId) {
          return circleId != null
              ? TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: themeData.colorScheme.secondary,
                  ),
                  child: const Text('Edit'),
                  onPressed: () =>
                      context.router.push(CircleEditRoute(circleId: circleId)))
              : const SizedBox(
                  width: 0,
                  height: 0,
                );
        },
      ),
    );
  }
}
