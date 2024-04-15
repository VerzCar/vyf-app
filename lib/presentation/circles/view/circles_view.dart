import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circles/circles.dart';

class CirclesView extends StatelessWidget {
  const CirclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circles'),
      ),
      body: SafeArea(child:
          BlocBuilder<CirclesBloc, CirclesState>(builder: (context, state) {
        return CupertinoScrollbar(
            child: ListView(
          children: [
            for (final circle in state.myCircles)
              Text('Circle name ${circle.name}'),
          ],
        ));
      })),
    );
  }
}
