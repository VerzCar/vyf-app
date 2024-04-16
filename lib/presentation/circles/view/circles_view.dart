import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/circles/widgets/your_circles.dart';

class CirclesView extends StatelessWidget {
  const CirclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Circles'),
        ),
      ),
      body: const SafeArea(
        child: YourCircles(),
      ),
    );
  }
}
