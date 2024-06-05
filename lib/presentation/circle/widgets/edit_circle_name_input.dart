import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class EditCircleNameInput extends StatelessWidget {
  const EditCircleNameInput({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleEditFormCubit, CircleEditFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('EditCircleNameInput_textFormField'),
          initialValue: initialValue,
          onChanged: (value) =>
              context.read<CircleEditFormCubit>().onNameChanged(value),
          labelText: 'Name',
          errorText: 'Invalid name',
          maxLength: 40,
          showError: !state.name.isPure && state.name.isNotValid,
        );
      },
    );
  }
}