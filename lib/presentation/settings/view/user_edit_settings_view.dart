import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/settings/cubit/user_edit_profile_cubit.dart';
import 'package:vote_your_face/presentation/settings/widgets/bio_input.dart';
import 'package:vote_your_face/presentation/settings/widgets/user_first_name_input.dart';
import 'package:vote_your_face/presentation/settings/widgets/user_last_name_input.dart';
import 'package:vote_your_face/presentation/settings/widgets/why_vote_me_input.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class UserEditSettingsView extends StatelessWidget {
  const UserEditSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _submitActionButton(themeData),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocProvider(
                            create: (context) => UserXCubit(
                                userRepository: sl<IUserRepository>())
                              ..userXFetched(
                                context: context,
                                identityId: state.user.identityId,
                              ),
                            child: const UserAvatar(
                              option: UserAvatarOption(
                                size: AvatarSize.lg,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            state.user.username,
                            style: themeData.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    BioInput(
                      initialValue: state.user.profile.bio,
                    ),
                    const SizedBox(height: 12.0),
                    WhyVoteMeInput(
                      initialValue: state.user.profile.whyVoteMe,
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: UserFirstNameInput(
                              initialValue: state.user.firstName),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: UserLastNameInput(
                            initialValue: state.user.lastName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _submitActionButton(ThemeData themeData) {
    return BlocConsumer<UserEditProfileCubit, UserEditProfileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          BlocProvider.of<UserBloc>(context).add(UserUpdated(
            user: state.updatedUser!,
          ));

          showSuccessSnackbar(
            context,
            'Saved successfully',
          );
        }

        if (state.status.isFailure) {
          showErrorSnackbar(
            context,
            'Could not save. Try again.',
          );
        }
      },
      builder: (context, state) {
        return SubmitButton(
          disabled: Formz.isPure([
                state.firstName,
                state.lastName,
                state.bio,
                state.whyVoteMe,
              ]) ||
              state.status.isInProgress,
          isLoading: state.status.isInProgress,
          foregroundColor: themeData.colorScheme.successColor,
          onPressed: () => context.read<UserEditProfileCubit>().onSubmit(),
        );
      },
    );
  }
}
