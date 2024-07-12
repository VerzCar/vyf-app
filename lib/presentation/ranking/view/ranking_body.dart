import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        BlocSelector<CircleBloc, CircleState, CircleStage>(
            selector: (state) => state.circle.stage,
            builder: (context, stage) {
              if (stage == CircleStage.hot) {
                return BlocBuilder<RankingCubit, RankingState>(
                  builder: (context, rankingState) {
                    if (rankingState.topRankings.isEmpty &&
                        rankingState.rankings.isEmpty) {
                      return _buildEmptyRankingsPlaceholder(context);
                    }

                    final List<Widget> buildRankings = [];

                    if (rankingState.topRankings.isNotEmpty) {
                      buildRankings.add(
                        _buildTopRankingsRow(
                          context: context,
                          rankings: rankingState.topRankings,
                        ),
                      );
                    }

                    if (rankingState.rankings.isNotEmpty) {
                      buildRankings.add(
                        Expanded(
                          child: _buildRankingListView(
                            context: context,
                            rankings: rankingState.rankings,
                          ),
                        ),
                      );
                    }

                    return Expanded(
                        child: Column(children: buildRankings.toList()));
                  },
                );
              }
              return _buildColdCirclePlaceholder(context);
            }),
      ],
    );
  }

  _buildTopRankingsRow({
    required BuildContext context,
    required List<Ranking> rankings,
  }) {
    // move the placement of rankings in order of view
    // first one is 2 placement -> 1 placement -> 3 placement
    if (rankings.length > 1) {
      rankings.move(0, 1);
    }

    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    final topRankings = rankings.map((ranking) {
      return Expanded(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                ranking.votes.toString(),
                style: themeData.textTheme.bodyLarge,
              ),
            ),
            BlocSelector<UserBloc, UserState, User>(
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
                      return Container(
                        width: size.width * 0.20,
                        height: size.width * 0.20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(state.user.profile.imageSrc),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Text(
              ranking.number.toString(),
              style: themeData.textTheme.headlineLarge,
            ),
            ranking.number == 1 ? SizedBox(height: 80) : SizedBox(),
          ],
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: topRankings,
    );
  }

  ListView _buildRankingListView({
    required BuildContext context,
    required List<Ranking> rankings,
  }) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return ListView.separated(
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
