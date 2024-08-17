import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_item_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class RankingSheet extends StatelessWidget {
  const RankingSheet({
    super.key,
    required this.identityId,
    required this.placementNumber,
    required this.upVotes,
    required this.circleId,
  });

  final String identityId;
  final int placementNumber;
  final int upVotes;
  final int circleId;

  @override
  Widget build(BuildContext context) {
    return UserXProvider(
      identityId: identityId,
      child: BlocProvider(
        create: (context) => RankingItemCubit(
          voteCircleRepository: sl<IVoteCircleRepository>(),
        )..loadVotedByIds(circleId: circleId, candidateIdentId: identityId),
        child: BlocBuilder<UserXCubit, UserXState>(builder: (context, state) {
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
      ),
    );
  }

  Widget _sheetContent({
    required BuildContext context,
    required User user,
  }) {
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      child: BodyLayout(
        verticalPadding: 20.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up_outlined),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$upVotes',
                            style: themeData.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text('up votes',
                              style: themeData.textTheme.labelSmall),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Placement Nr. $placementNumber',
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      UserAvatar(
                        key: ValueKey(identityId),
                        option: const UserAvatarOption(
                          size: AvatarSize.xxl,
                          withLabel: true,
                          labelPosition: LabelPosition.bottom,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  //width: 100,
                  child: Row(
                    children: [
                      const Icon(Icons.trending_down_outlined),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: themeData.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text('down votes',
                              style: themeData.textTheme.labelSmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
            const Divider(),
            Text(
              'Voted by',
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 10.0),
            _votedByList(context),
          ],
        ),
      ),
    );
  }

  Widget _votedByList(BuildContext context) {
    return BlocBuilder<RankingItemCubit, RankingItemState>(
      builder: (context, state) {
        final ids = state.votedByIds;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ids.length,
          itemBuilder: (BuildContext context, int index) {
            final identityId = ids[index];

            return Card(
              key: Key(identityId),
              elevation: 0,
              color: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              margin: const EdgeInsets.all(0),
              child: UserXProvider(
                identityId: identityId,
                child: ListTile(
                  leading: UserAvatar(
                    key: ValueKey(identityId),
                  ),
                  title: BlocBuilder<UserXCubit, UserXState>(
                    builder: (context, state) {
                      return Text(state.user.displayName);
                    },
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const ListSeparator(),
        );
      },
    );
  }
}
