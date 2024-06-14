import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class CircleNotEligibleView extends StatelessWidget {
  const CircleNotEligibleView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
                'This Circle is private! You are not eligible to see that circle.'),
            const Text('Ask the owner, if you can join.'),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: themeData.colorScheme.secondary,
              ),
              onPressed: () {
                context.router.push(const CirclesRoute());
              },
              child: const Text('Go back to circles'),
            ),
          ],
        ),
      ),
    );
  }
}
