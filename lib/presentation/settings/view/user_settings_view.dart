import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class UserSettingsView extends StatelessWidget {
  UserSettingsView({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _whyVoteMeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child: Text(
                'Save',
                style: TextStyle(color: themeData.colorScheme.successColor),
              ),
              onPressed: () => {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              print(state.user.profile.bio);
              _bioController.text = state.user.profile.bio;
              _whyVoteMeController.text = state.user.profile.whyVoteMe;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: BlocProvider(
                        create: (context) =>
                            UserXCubit(userRepository: sl<IUserRepository>())
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
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Bio',
                      style: themeData.textTheme.labelLarge,
                    ),
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                          hintText:
                              'Give an example for how beautiful and special you are!'),
                      maxLines: 3,
                      maxLength: 1500,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Why Vote Me?',
                      style: themeData.textTheme.labelLarge,
                    ),
                    TextFormField(
                      controller: _whyVoteMeController,
                      decoration: const InputDecoration(
                          hintText:
                              'Give an meaningful explanation why anyone should vote you.'),
                      maxLines: 3,
                      maxLength: 250,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style: themeData.textTheme.labelLarge,
                              ),
                              TextFormField(
                                controller: _nameController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Name',
                                style: themeData.textTheme.labelLarge,
                              ),
                              TextFormField(
                                controller: _nameController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Phone number',
                      style: themeData.textTheme.labelLarge,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
