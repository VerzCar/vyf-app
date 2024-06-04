import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class BioInput extends StatelessWidget {
  const BioInput({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEditProfileCubit, UserEditProfileState>(
      buildWhen: (previous, current) => previous.bio != current.bio,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('BioInput_textFormField'),
          initialValue: initialValue,
          onChanged: (name) =>
              context.read<UserEditProfileCubit>().onBioChanged(name),
          labelText: 'Bio',
          errorText: 'Invalid bio',
          hintText: 'Give an example for how beautiful and special you are!',
          maxLength: 1500,
          maxLines: 3,
          showError: !state.bio.isPure && state.bio.isNotValid,
        );
      },
    );
  }
}
