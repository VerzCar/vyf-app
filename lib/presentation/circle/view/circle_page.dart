import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/bloc/circle_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/circle/view/circle_view.dart';

@RoutePage()
class CirclePage extends StatelessWidget {
  const CirclePage({super.key, @pathParam required this.circleId});

  final int circleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CircleBloc>(context)
        ..add(CircleSelected(circleId: circleId)),
      child: const CircleView(),
    );
  }
}
