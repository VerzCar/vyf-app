import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Members extends StatelessWidget {
  const Members({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

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
            children: [
              Text(
                'Each Circle contains members',
                style: themeData.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'There are two roles of members',
                style: themeData.textTheme.titleMedium,
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Voter',
                    style: themeData.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Can vote for a candidate. Every vote counts and influences the ranking.',
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Important: Each voter can only cast one vote.',
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Candidate',
                    style: themeData.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Can be voted for by voters.',
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Invited candidates receive a notification and must confirm or decline their participation. Only committed candidates are listed for election and can receive votes.',
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
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
