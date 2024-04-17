import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_cubit.dart';
import 'package:vote_your_face/presentation/circle/view/circle_body.dart';

class CircleView extends StatelessWidget {
  const CircleView({super.key});

  @override
  Widget build(BuildContext context) {
    final circleName =
        context.select((CircleCubit cubit) => cubit.state.circle.name);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(circleName),
      ),
      body: BlocBuilder<CircleCubit, CircleState>(builder: (context, state) {
        switch (state.status) {
          case StatusIndicator.initial:
            return const Text('initial Loading');
          case StatusIndicator.loading:
            return const Center(child: CircularProgressIndicator());
          case StatusIndicator.success:
            return CircleBody(circle: state.circle);
          case StatusIndicator.failure:
            return const Text('Error');
        }
      }),
    );
  }
}
