import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserFirstNameInput extends StatelessWidget {
  const UserFirstNameInput({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEditProfileCubit, UserEditProfileState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('UserFirstNameInput_textFormField'),
          initialValue: initialValue,
          onChanged: (name) =>
              context.read<UserEditProfileCubit>().onFirstNameChanged(name),
          labelText: 'First name',
          errorText: 'Invalid first name',
          maxLength: 50,
          showError: !state.firstName.isPure && state.firstName.isNotValid,
        );
      },
    );
  }
}
