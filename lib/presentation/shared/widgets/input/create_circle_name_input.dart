import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/shared/widgets/field/vyf_text_form_field.dart';

class CreateCircleNameInput extends StatelessWidget {
  const CreateCircleNameInput({super.key});

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
