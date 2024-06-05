import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class EditCircleDescriptionInput extends StatelessWidget {
  const EditCircleDescriptionInput({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleEditFormCubit, CircleEditFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('EditCircleDescriptionInput_textFormField'),
          initialValue: initialValue,
          onChanged: (name) =>
              context.read<CircleEditFormCubit>().onNameChanged(name),
          labelText: 'Description',
          errorText: 'Invalid circle description',
          maxLength: 1500,
          maxLines: 5,
          showError: !state.description.isPure && state.description.isNotValid,
        );
      },
    );
  }
}