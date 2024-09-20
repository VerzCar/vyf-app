import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CreateCircleNameDescForm extends StatelessWidget {
  const CreateCircleNameDescForm({super.key, required this.onNext});

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
                'Create your first Circle',
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
                'The most important rules',
                style: themeData.textTheme.titleMedium,
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. One voter, one vote',
                    style: themeData.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Each voter can only cast one vote. However, you can revoke your vote at any time and give it to another candidate.',
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. Member management',
                    style: themeData.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Once a vote has been cast, the corresponding voter and candidate cannot be removed from the Circle as long as the vote is active.',
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. Election period',
                    style: themeData.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Each Circle has a start time for the election. You can also set an end time or let the election run indefinitely.',
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
