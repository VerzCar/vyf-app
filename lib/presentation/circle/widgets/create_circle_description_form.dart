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
            'The circle should have a descriptive naming, to indicate for what the circle stands for. This gives you the ability to give a first hint for what the circle is for.',
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
