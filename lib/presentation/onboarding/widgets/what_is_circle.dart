import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WhatIsCircle extends StatelessWidget {
  const WhatIsCircle({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () => {},
          label: const Text('Skip'),
          icon: const Icon(Icons.close),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is a circle?',
                style: themeData.textTheme.headlineLarge,
              ),
              const SizedBox(height: 5),
              Text(
                'A Circle is your personal campaign circle. You can customize it by adding a name, a picture and a description. Choose whether your Circle should be public or private.',
                style: themeData.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: AlignedGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Private Circle',
                      style: themeData.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'You decide who participates as a voter or candidate. Only members can see and find the Circle.',
                      style: themeData.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      //width: 100,
                      height: size.height * 0.30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/img/onboarding_pub_circle.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (index == 1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Public Circle',
                      style: themeData.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Anyone can join this Circle as a voter or candidate.',
                      style: themeData.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 50),
                    Container(
                      //width: 100,
                      height: size.height * 0.30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/img/onboarding_private_circle.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return null;
            },
          ),
        ),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: themeData.colorScheme.onSecondary,
                    backgroundColor: themeData.colorScheme.secondary,
                  ),
                  onPressed: onNext,
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
