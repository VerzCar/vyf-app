import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/widgets/members_need_vote_preview.dart';
import 'package:vote_your_face/presentation/ranking/widgets/ranking_sheet.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class RankingBody extends StatelessWidget {
  const RankingBody({
    super.key,
    required this.rankings,
    required this.circleId,
  });

  final List<Ranking> rankings;
  final int circleId;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Need a vote',
                      style: themeData.textTheme.titleMedium,
                    ),
                  ),
                  MembersNeedVotePreview(circleId: circleId),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Valid',
                      style: themeData.textTheme.titleMedium,
                    ),
                  ),
                  BlocBuilder<CircleBloc, CircleState>(
                    builder: (context, state) {
                      return TimeBox(
                        from: state.circle.validFrom,
                        until: state.circle.validUntil,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        rankings.isEmpty
            ? buildEmptyRankingsPlaceholder(context)
            : Expanded(
                child: buildRankingListView(context),
              ),
      ],
    );
  }

  ListView buildRankingListView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return ListView.separated(
      itemCount: rankings.length,
      itemBuilder: (BuildContext contextL, int index) {
        final ranking = rankings[index];
        late UserXCubit userXCubit;

        return Card(
          key: Key(ranking.id.toString()),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          margin: const EdgeInsets.all(0),
          child: BlocProvider(
            create: (context) {
              userXCubit = UserXCubit(userRepository: sl<IUserRepository>())
                ..userXFetched(
                  context: context,
                  identityId: ranking.identityId,
                );
              return userXCubit;
            },
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 3.0,
              ),
              leading: Text(
                ranking.number.toString(),
                style: themeData.textTheme.bodyLarge,
              ),
              title: UserAvatar(
                option: UserAvatarOption(
                  withLabel: true,
                  labelChild: Text(
                    '${ranking.votes} votes',
                    style: themeData.textTheme.labelMedium,
                  ),
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: themeData.colorScheme.onSecondary,
                    backgroundColor: themeData.colorScheme.secondary
                ),
                child: const Text('Vote'),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context2) {
                    return SizedBox(
                      height: size.height * 0.70,
                      child: BlocProvider.value(
                        value: userXCubit,
                        child: RankingSheet(
                          identityId: ranking.identityId,
                          placementNumber: ranking.number,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 0,
      ),
    );
  }

  Widget buildEmptyRankingsPlaceholder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/election-day.svg',
            semanticsLabel: 'Election day',
            width: size.width * 0.28,
            height: size.height * 0.28,
          ),
          const SizedBox(height: 15),
          Text(
            'No one has voted so far',
            style: themeData.textTheme.titleLarge,
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: themeData.colorScheme.secondary,
            ),
            onPressed: () {},
            child: const Text('give a vote!'),
          ),
        ],
      ),
    );
  }
}
