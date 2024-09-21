import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CreateCircleNameDescForm extends StatelessWidget {
  const CreateCircleNameDescForm({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraint) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => context.router.navigate(const HomeRoute()),
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
                      const SizedBox(height: 30),
                      const CreateCircleNameInput(),
                      const SizedBox(height: 5),
                      Text(
                        _helpTextName,
                        style: themeData.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 30),
                      const CreateCircleDescriptionInput(),
                      const SizedBox(height: 5),
                      Text(
                        _helpTextDesc,
                        style: themeData.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Spacer(),
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BlocBuilder<CircleCreateFormCubit,
                            CircleCreateFormState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    themeData.colorScheme.onSecondary,
                                backgroundColor:
                                    themeData.colorScheme.secondary,
                              ),
                              onPressed: state.name.isValid &&
                                      state.description.isValid
                                  ? onNext
                                  : null,
                              child: const Text('Next'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _helpTextName {
    return 'Enter a descriptive name for your voting circle. '
        'This should reflect what the circle stands for. '
        'For example, if your circle is about voting for the best actor in Hollywood, you might name it "Hollywood Best Actor Voting Circle"';
  }

  String get _helpTextDesc {
    return 'Provide a detailed description of your circle. '
        'This should help both candidates and voters, especially voters, understand the purpose of the circle, who should participate, and what the expected outcome is. '
        'For instance, ‘This circle is for voting for the best actor in Hollywood. All movie enthusiasts are welcome to vote and any actor can be a candidate. '
        'The outcome will determine who is considered the best actor in Hollywood by the circle members.';
  }
}
