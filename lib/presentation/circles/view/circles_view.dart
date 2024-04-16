import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/presentation/circles/widgets/widgets.dart';

class CirclesView extends StatelessWidget {
  const CirclesView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Circles'),
        ),
      ),
      body: SafeArea(child:
          BlocBuilder<CirclesBloc, CirclesState>(builder: (context, state) {
        return SizedBox(
          height: size.height * 0.25,
          child: PageView(
            controller: PageController(viewportFraction: 0.60),
            children: [
              for (final circle in state.myCircles)
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: SizedBox(
                    width: 0,
                    child: CircleCard(circle: circle),
                  ),
                ),
            ],
          ),
        );
      })),
    );
  }
}
