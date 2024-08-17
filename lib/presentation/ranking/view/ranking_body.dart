import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_cubit.dart';
import 'package:vote_your_face/presentation/ranking/widgets/live_indicator.dart';
import 'package:vote_your_face/presentation/ranking/widgets/members_need_vote_preview.dart';
import 'package:vote_your_face/presentation/ranking/widgets/members_need_vote_sheet.dart';
import 'package:vote_your_face/presentation/ranking/widgets/ranked_voting_button.dart';
import 'package:vote_your_face/presentation/ranking/widgets/ranking_sheet.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class RankingBody extends StatelessWidget {
  const RankingBody({
    super.key,
    required this.circleId,
  });

  final int circleId;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      child: BodyLayout(
        child: Column(
          children: [
            Row(
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
                    BlocBuilder<CircleRankingBloc, CircleRankingState>(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LiveIndicator(),
              ],
            ),
            const SizedBox(height: 30),
            BlocSelector<CircleRankingBloc, CircleRankingState, CircleStage>(
              selector: (state) => state.circle.stage,
              builder: (context, stage) {
                return stage == CircleStage.hot
                    ? BlocBuilder<RankingCubit, RankingState>(
                        buildWhen: (prev, current) =>
                            current.topRankings.isEmpty &&
                            current.rankings.isEmpty,
                        builder: (context, rankingState) {
                          return rankingState.topRankings.isEmpty &&
                                  rankingState.rankings.isEmpty
                              ? _buildEmptyRankingsPlaceholder(context)
                              : const SizedBox();
                        })
                    : const SizedBox();
              },
            ),
            BlocSelector<CircleRankingBloc, CircleRankingState, CircleStage>(
              selector: (state) => state.circle.stage,
              builder: (context, stage) {
                return stage == CircleStage.hot
                    ? BlocBuilder<RankingCubit, RankingState>(
                        builder: (context, rankingState) {
                        return rankingState.topRankings.isNotEmpty
                            ? _buildWinnerPodium(
                                context: context,
                                topRankings: rankingState.topRankings,
                              )
                            : const SizedBox();
                      })
                    : const SizedBox();
              },
            ),
            BlocSelector<CircleRankingBloc, CircleRankingState, CircleStage>(
              selector: (state) => state.circle.stage,
              builder: (context, stage) {
                return stage == CircleStage.hot
                    ? BlocBuilder<RankingCubit, RankingState>(
                        builder: (context, rankingState) {
                        return rankingState.rankings.isNotEmpty
                            ? _buildRankingListView(
                                context: context,
                                rankings: rankingState.rankings,
                              )
                            : const SizedBox();
                      })
                    : const SizedBox();
              },
            ),
            BlocSelector<CircleRankingBloc, CircleRankingState, CircleStage>(
              selector: (state) => state.circle.stage,
              builder: (context, stage) {
                return stage != CircleStage.hot
                    ? _buildColdCirclePlaceholder(context)
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildWinnerPodium({
    required BuildContext context,
    required List<Ranking> topRankings,
  }) {
    final rankings = List<Ranking?>.from(topRankings);

    if (rankings.length < 3) {
      rankings.length = 3;
    }

    // move the placement of rankings in order of view
    // first one is 2 placement -> 1 placement -> 3 placement
    rankings.move(0, 1);

    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    final winnerPodiums = List.generate(3, (index) {
      final ranking = rankings.elementAtOrNull(index);

      if (ranking == null) {
        return const StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: SizedBox(),
        );
      }

      return StaggeredGridTile.count(
        crossAxisCellCount: 1,
        mainAxisCellCount: 2,
        child: UserXProvider(
          identityId: ranking.identityId,
          child: BlocBuilder<UserXCubit, UserXState>(
            builder: (context, state) {
              return Column(
                children: [
                  index != 1
                      ? const Flexible(child: SizedBox(height: 60))
                      : const SizedBox(),
                  Stack(
                    children: [
                      Container(
                        width:
                            index != 1 ? size.width * 0.23 : size.width * 0.35,
                        height:
                            index != 1 ? size.width * 0.23 : size.width * 0.35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          shape: BoxShape.circle,
                          boxShadow: index == 1
                              ? [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 3,
                                      blurRadius: 17,
                                      offset: const Offset(0, 6)),
                                ]
                              : [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 2,
                                      blurRadius: 12,
                                      offset: const Offset(0, 5)),
                                ],
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          child: AnimatedOpacity(
                            opacity: state.status.isLoading ? 0.2 : 1.0,
                            duration: const Duration(milliseconds: 500),
                            child: GestureDetector(
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context2) {
                                  return SizedBox(
                                    height: size.height * 0.70,
                                    child: RankingSheet(
                                      identityId: ranking.identityId,
                                      placementNumber: ranking.number,
                                      upVotes: ranking.votes,
                                      circleId: circleId,
                                    ),
                                  );
                                },
                              ),
                              child: Container(
                                width: index != 1
                                    ? size.width * 0.23
                                    : size.width * 0.25,
                                height: index != 1
                                    ? size.width * 0.23
                                    : size.width * 0.25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: SecureNetImage.image(
                                      imageSrc: state.user.profile.imageSrc,
                                      placeholderPath:
                                          'assets/placeholder/sky.jpg',
                                    ).image,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 5,
                        child: Text(
                          ranking.votes.toString(),
                          style: themeData.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  GradientText(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.pinkAccent,
                        Colors.purple.shade900,
                      ],
                    ),
                    child: Text(
                      ranking.number.toString(),
                      style: themeData.textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    state.user.displayName,
                    style: themeData.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<MembersBloc, MembersState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return state.status.isSuccessful
                          ? RankedVotingButton(ranking: ranking)
                          : const SizedBox();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      );
    });

    return StaggeredGrid.count(
      crossAxisCount: 3,
      children: winnerPodiums,
    );
  }

  _buildRankingListView({
    required BuildContext context,
    required List<Ranking> rankings,
  }) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: rankings.length,
        itemBuilder: (BuildContext contextList, int index) {
          final ranking = rankings[index];

          return Stack(
            children: [
              Card(
                key: Key(ranking.id.toString()),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                margin: const EdgeInsets.all(0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 3.0,
                  ),
                  leading: Text(
                    ranking.number.toString(),
                    style: themeData.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  title: UserXProvider(
                    identityId: ranking.identityId,
                    child: UserAvatar(
                      key: ValueKey(ranking.identityId),
                      option: UserAvatarOption(
                        withLabel: true,
                        labelChild: Text(
                          '${ranking.votes} votes',
                          style: themeData.textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  trailing: BlocBuilder<MembersBloc, MembersState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return state.status.isSuccessful
                          ? RankedVotingButton(ranking: ranking)
                          : const SizedBox();
                    },
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context2) {
                        return SizedBox(
                          height: size.height * 0.70,
                          child: RankingSheet(
                            identityId: ranking.identityId,
                            placementNumber: ranking.number,
                            upVotes: ranking.votes,
                            circleId: circleId,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              BlocSelector<MembersBloc, MembersState, bool>(
                selector: (state) =>
                    MembersSelector.hasVotedFor(state, ranking.identityId),
                builder: (context, hasVotedFor) {
                  if (hasVotedFor) {
                    return Positioned(
                      left: 10,
                      top: -5,
                      child: Text(
                        'You have voted for',
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.labelLarge?.copyWith(
                          color: themeData.colorScheme.secondary,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const ListSeparator());
  }

  Widget _buildEmptyRankingsPlaceholder(BuildContext context) {
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
            onPressed: () => _showMembersNeedVoteSheet(context),
            child: const Text('give a vote!'),
          ),
        ],
      ),
    );
  }

  Widget _buildColdCirclePlaceholder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/election-wait.svg',
            semanticsLabel: 'Election wait',
            width: size.width * 0.28,
            height: size.height * 0.28,
          ),
          const SizedBox(height: 15),
          Text(
            'We are very excited to vote.',
            style: themeData.textTheme.titleLarge,
          ),
          Text(
            'But the voting hasn\'t started yet...',
            style: themeData.textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Voting starts in - '),
              BlocBuilder<CircleRankingBloc, CircleRankingState>(
                builder: (context, state) => TimeUntil(
                  untilTime: state.circle.validFrom,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMembersNeedVoteSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context2) {
        return const MembersNeedVoteSheet();
      },
    );
  }
}
