import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_cubit.dart';
import 'package:vote_your_face/presentation/ranking/cubit/vote_cubit.dart';
import 'package:vote_your_face/presentation/ranking/widgets/members_need_vote_preview.dart';
import 'package:vote_your_face/presentation/ranking/widgets/ranking_sheet.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

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
      child: Column(
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
          BlocSelector<CircleBloc, CircleState, CircleStage>(
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
          BlocSelector<CircleBloc, CircleState, CircleStage>(
            selector: (state) => state.circle.stage,
            builder: (context, stage) {
              return stage == CircleStage.hot
                  ? BlocBuilder<RankingCubit, RankingState>(
                      buildWhen: (prev, current) =>
                          current.topRankings.isNotEmpty,
                      builder: (context, rankingState) {
                        return _buildWinnerPodium(
                          context: context,
                          topRankings: rankingState.topRankings,
                        );
                      })
                  : const SizedBox();
            },
          ),
          BlocSelector<CircleBloc, CircleState, CircleStage>(
            selector: (state) => state.circle.stage,
            builder: (context, stage) {
              return stage == CircleStage.hot
                  ? BlocBuilder<RankingCubit, RankingState>(
                      buildWhen: (prev, current) => current.rankings.isNotEmpty,
                      builder: (context, rankingState) {
                        return _buildRankingListView(
                          context: context,
                          rankings: rankingState.rankings,
                        );
                      })
                  : const SizedBox();
            },
          ),
          BlocSelector<CircleBloc, CircleState, CircleStage>(
            selector: (state) => state.circle.stage,
            builder: (context, stage) {
              return stage != CircleStage.hot
                  ? _buildColdCirclePlaceholder(context)
                  : const SizedBox();
            },
          ),
        ],
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
        child: BlocSelector<UserBloc, UserState, User>(
          selector: (state) => state.user,
          builder: (context, user) {
            return BlocProvider(
              create: (context) =>
                  UserXCubit(userRepository: sl<IUserRepository>())
                    ..userXFetched(
                      currentUser: user,
                      identityId: ranking.identityId,
                    ),
              child: BlocBuilder<UserXCubit, UserXState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      index != 1
                          ? const SizedBox(height: 70)
                          : const SizedBox(),
                      Stack(
                        children: [
                          Container(
                            width: index != 1
                                ? size.width * 0.23
                                : size.width * 0.35,
                            height: index != 1
                                ? size.width * 0.23
                                : size.width * 0.35,
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
                                      image: NetworkImage(
                                          state.user.profile.imageSrc),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
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
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        ranking.number.toString(),
                        style: themeData.textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        state.user.username,
                        style: themeData.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 40,
          crossAxisSpacing: 4,
          children: winnerPodiums),
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

        return Card(
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
              style: themeData.textTheme.bodyLarge,
            ),
            title: UserAvatar(
              key: ValueKey(ranking.identityId),
              identityId: ranking.identityId,
              option: UserAvatarOption(
                withLabel: true,
                labelChild: Text(
                  '${ranking.votes} votes',
                  style: themeData.textTheme.labelMedium,
                ),
              ),
            ),
            trailing: BlocBuilder<MembersBloc, MembersState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return state.status.isSuccessful
                    ? _votingActionButton(
                        themeData: themeData,
                        ranking: ranking,
                      )
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
                    ),
                  );
                },
              );
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 0,
      ),
    );
  }

  _votingActionButton({
    required ThemeData themeData,
    required Ranking ranking,
  }) {
    return BlocProvider(
      create: (context) =>
          VoteCubit(voteCircleRepository: sl<IVoteCircleRepository>()),
      child: BlocSelector<MembersBloc, MembersState, bool>(
        selector: (state) => MembersSelector.canVote(state, ranking.identityId),
        builder: (context, canVote) {
          return canVote
              ? BlocSelector<CircleBloc, CircleState, int>(
                  selector: (state) => state.circle.id,
                  builder: (context, circleId) {
                    return BlocBuilder<VoteCubit, VoteState>(
                      builder: (context, state) {
                        return AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: ElevatedButton(
                            onPressed: () => context.read<VoteCubit>().voted(
                                  circleId: circleId,
                                  candidateId: ranking.identityId,
                                ),
                            style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    themeData.colorScheme.onSecondary,
                                backgroundColor:
                                    themeData.colorScheme.secondary),
                            child: const Text('Vote'),
                          ),
                        );
                      },
                    );
                  },
                )
              : BlocSelector<MembersBloc, MembersState, bool>(
                  selector: (state) =>
                      MembersSelector.canRevokeVote(state, ranking.identityId),
                  builder: (context, canRevokeVote) {
                    return canRevokeVote
                        ? BlocSelector<CircleBloc, CircleState, int>(
                            selector: (state) => state.circle.id,
                            builder: (context, circleId) {
                              return BlocBuilder<RankingCubit, RankingState>(
                                builder: (context, state) {
                                  return BlocBuilder<VoteCubit, VoteState>(
                                    builder: (context, state) {
                                      return AnimatedOpacity(
                                        opacity:
                                            state.status.isLoading ? 0.0 : 1.0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: ElevatedButton(
                                          onPressed: () => context
                                              .read<VoteCubit>()
                                              .revokedVote(
                                                circleId: circleId,
                                              ),
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: themeData
                                                  .colorScheme.onPrimary,
                                              backgroundColor: themeData
                                                  .colorScheme.primary),
                                          child: const Text('Revoke vote'),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          )
                        : const SizedBox();
                  },
                );
        },
      ),
    );
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
            onPressed: () {},
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
              const Text('Time until voting - '),
              BlocBuilder<CircleBloc, CircleState>(
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
}
