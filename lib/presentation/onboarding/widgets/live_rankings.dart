import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LiveRankings extends StatelessWidget {
  const LiveRankings({super.key, required this.onNext});

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
                'Live rankings',
                style: themeData.textTheme.headlineLarge,
              ),
              const SizedBox(height: 5),
              Text(
                'As soon as the election has started and voters cast their votes, the ranking list is updated in real time. Follow live how the ranking of your candidates evolves and who wins the election!',
                style: themeData.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: size.width,
          height: size.height * 0.40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/onboarding_ranking_list.png'),
              fit: BoxFit.contain,
            ),
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
