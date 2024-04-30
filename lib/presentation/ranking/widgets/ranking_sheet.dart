import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_placement_cubit.dart';
import 'package:vote_your_face/presentation/user_avatar/models/models.dart';
import 'package:vote_your_face/presentation/user_avatar/user_avatar.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class RankingSheet extends StatelessWidget {
  const RankingSheet({
    super.key,
    required this.identityId,
    required this.placementNumber,
  });

  final String identityId;
  final int placementNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) => RankingPlacementCubit(
        voteCircleRepository: sl<IVoteCircleRepository>(),
        userRepository: sl<IUserRepository>(),
      )..loadRankingUser(context: context, identityId: identityId),
      child: BlocBuilder<RankingPlacementCubit, RankingPlacementState>(
          builder: (context, state) {
        switch (state.status) {
          case StatusIndicator.initial:
            return const Center(child: Text('initial Loading'));
          case StatusIndicator.loading:
            return const Center(child: CircularProgressIndicator());
          case StatusIndicator.success:
            return _sheetContent(
              context: context,
              user: state.user,
            );
          case StatusIndicator.failure:
            return const Center(child: Text('Error'));
        }
      }),
    );
  }

  Widget _sheetContent({
    required BuildContext context,
    required User user,
  }) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Placement: $placementNumber',
                style: themeData.textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: UserAvatar(
                identityId: identityId,
                option: UserAvatarOption(
                  size: AvatarSize.xl,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Why vote me',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 10.0),
            Text(
              user.profile.whyVoteMe,
              style: themeData.textTheme.bodyMedium,
            ),
            const SizedBox(height: 15.0),
            Text(
              'Bio',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 10.0),
            Text(
              user.profile.bio,
              style: themeData.textTheme.bodyMedium,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
