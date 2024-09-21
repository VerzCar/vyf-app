import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/shared/widgets/field/vyf_text_form_field.dart';

class CreateCircleDescriptionInput extends StatelessWidget {
  const CreateCircleDescriptionInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key(
              'CreateCircleDescriptionForm_CircleDescriptionInput_textFormField'),
          onChanged: (name) =>
              context.read<CircleCreateFormCubit>().onDescriptionChanged(name),
          labelText: 'Circle description',
          errorText: 'Invalid circle description',
          maxLength: 1200,
          maxLines: 5,
          showError: !state.description.isPure && state.description.isNotValid,
        );
      },
    );
  }
}
