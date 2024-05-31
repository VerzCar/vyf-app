import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CreateCircleNameForm extends StatelessWidget {
  const CreateCircleNameForm({super.key, required this.onNext});

  final VoidCallback onNext;

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
            'Give the circle a name',
            style: themeData.textTheme.titleLarge,
          ),
          const SizedBox(height: 20.0),
          _CircleNameInput(),
          const SizedBox(height: 20.0),
          Text(
            'The circle should have a descriptive naming, to indicate for what the circle stands for. This gives you the ability to give a first hint for what the circle is for.',
            style: themeData.textTheme.bodyMedium,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: themeData.colorScheme.onSecondary,
                        backgroundColor: themeData.colorScheme.secondary
                    ),
                    onPressed: state.name.isValid ? onNext : null,
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

class _CircleNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('CreateCircleNameForm_CircleNameInput_textFormField'),
          onChanged: (name) =>
              context.read<CircleCreateFormCubit>().onNameChanged(name),
          labelText: 'Circle name',
          errorText: 'Invalid circle name',
          maxLength: 40,
          showError: !state.name.isPure && state.name.isNotValid,
        );
      },
    );
  }
}

