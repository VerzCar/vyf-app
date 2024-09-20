import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key, required this.onNext});

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
        Column(
          children: [
            Text(
              'Welcome to',
              style: themeData.textTheme.displayMedium,
            ),
            Text(
              'Vote your Face',
              style: themeData.textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/onboarding_welcome.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30.0,
                    ),
                    child: const Text(
                        'Your platform for exciting and interactive voting. Create your own circles, invite friends and follow how the rankings change in real time. Are you ready to get started?'),
                  ),
                )
              ],
            ),
          ],
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
                  child: const Text('Go'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
