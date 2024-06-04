import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class WhyVoteMeInput extends StatelessWidget {
  const WhyVoteMeInput({super.key, this.initialValue});

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEditProfileCubit, UserEditProfileState>(
      buildWhen: (previous, current) => previous.whyVoteMe != current.whyVoteMe,
      builder: (context, state) {
        return VyfTextFormField(
          key: const Key('WhyVoteMeInput_textFormField'),
          initialValue: initialValue,
          onChanged: (name) =>
              context.read<UserEditProfileCubit>().onWhyVoteMeChanged(name),
          labelText: 'Why vote me?',
          hintText: 'Give an meaningful explanation why anyone should vote you.',
          errorText: 'Invalid text',
          maxLength: 1500,
          maxLines: 3,
          showError: !state.whyVoteMe.isPure && state.whyVoteMe.isNotValid,
        );
      },
    );
  }
}
