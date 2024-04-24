import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circles/circles.dart';
import 'package:vote_your_face/presentation/circles/widgets/mini_circle_card.dart';

class CirclesOfInterest extends StatelessWidget {
  const CirclesOfInterest({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    final num crossAxisCount = (size.width ~/ 200).clamp(2, size.width);

    return BlocBuilder<CirclesOfInterestCubit, CirclesOfInterestState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Circles',
              style: TextStyle(
                fontSize: themeData.textTheme.titleLarge?.fontSize,
                fontWeight: themeData.textTheme.titleLarge?.fontWeight,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              itemCount: state.circlesOfInterest.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount.toInt(),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 200,
                  height: 200,
                  child: MiniCircleCard(circle: state.circlesOfInterest[index]),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
