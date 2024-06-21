import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserSettingsBody extends StatelessWidget {
  const UserSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 170,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topRight,
              colors: [Colors.blue.shade600, Colors.blue.shade100],
              stops: const [0.16, 0.85],
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(200),
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserAvatar(
                            key: ValueKey(state.user.identityId),
                            identityId: state.user.identityId,
                            option: const UserAvatarOption(
                              size: AvatarSize.xl,
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            state.user.username,
                            style: themeData.textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.user.profile.whyVoteMe,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20.0),
                  const _UserInfoSection(),
                  const SizedBox(height: 20.0),
                  const _ProfileSection(),
                  const SizedBox(height: 20.0),
                  const _AddressSection(),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

class _UserInfoSection extends StatelessWidget {
  const _UserInfoSection();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First name',
                  style: themeData.textTheme.labelSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  state.user.firstName,
                  style: themeData.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last name',
                  style: themeData.textTheme.labelSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  state.user.lastName,
                  style: themeData.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: themeData.textTheme.labelSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  state.user.gender.toString(),
                  style: themeData.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bio',
                  style: themeData.textTheme.labelSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  state.user.profile.bio,
                  style: themeData.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AddressSection extends StatelessWidget {
  const _AddressSection();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: themeData.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.user.address?.address ?? '',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City',
                      style: themeData.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.user.address?.city ?? '',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Postal Code',
                      style: themeData.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.user.address?.postalCode ?? '',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City',
                      style: themeData.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.user.address?.city ?? '',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Country',
                      style: themeData.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      state.user.address?.country.fullName ?? '',
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
