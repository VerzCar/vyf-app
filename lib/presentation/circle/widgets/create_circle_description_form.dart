import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CreateCircleDescriptionForm extends StatelessWidget {
  const CreateCircleDescriptionForm({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Describe the circle',
            style: themeData.textTheme.titleLarge,
          ),
          const SizedBox(height: 20.0),
          _CircleDescriptionInput(),
          const SizedBox(height: 20.0),
          Text(
            helpText,
            style: themeData.textTheme.bodyMedium,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: themeData.colorScheme.secondary,
                ),
                onPressed: onPrevious,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 10),
              BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: themeData.colorScheme.onSecondary,
                        backgroundColor: themeData.colorScheme.secondary),
                    onPressed: state.description.isValid ? onNext : null,
                    child: const Text('Next'),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  String get helpText {
    return 'Provide a detailed description of your circle. '
        'This should help both candidates and voters, especially voters, understand the purpose of the circle, who should participate, and what the expected outcome is. '
        'For instance, ‘This circle is for voting for the best actor in Hollywood. All movie enthusiasts are welcome to vote and any actor can be a candidate. '
        'The outcome will determine who is considered the best actor in Hollywood by the circle members.';
  }
}

class _CircleDescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      buildWhen: (previous, current) => previous.description != current.description,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key(
              'CreateCircleDescriptionForm_CircleDescriptionInput_textFormField'),
          onChanged: (name) =>
              context.read<CircleCreateFormCubit>().onDescriptionChanged(name),
          labelText: 'Circle description',
          errorText: 'Invalid circle description',
          maxLength: 1500,
          maxLines: 5,
          showError: !state.description.isPure && state.description.isNotValid,
        );
      },
    );
  }
}
