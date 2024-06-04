import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserLastNameInput extends StatelessWidget {
  const UserLastNameInput({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEditProfileCubit, UserEditProfileState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('UserLastNameInput_textFormField'),
          initialValue: initialValue,
          onChanged: (name) =>
              context.read<UserEditProfileCubit>().onLastNameChanged(name),
          labelText: 'Last name',
          errorText: 'Invalid last name',
          maxLength: 50,
          showError: !state.lastName.isPure && state.lastName.isNotValid,
        );
      },
    );
  }
}
