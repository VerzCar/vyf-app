import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/bloc/circle_ranking_bloc.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/members/selector/members_selector.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/cubit/ranking_cubit.dart';
import 'package:vote_your_face/presentation/ranking/cubit/vote_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class RankedVotingButton extends StatelessWidget {
  const RankedVotingButton({
    super.key,
    required this.ranking,
  });

  final Ranking ranking;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          VoteCubit(voteCircleRepository: sl<IVoteCircleRepository>()),
      child: BlocListener<VoteCubit, VoteState>(
        listenWhen: (previous, current) =>
        previous.status != current.status,
        listener: (context, state) {
          if (state.status.isSuccessful) {
            EventTrigger.success(
              context: context,
              msg: 'You voted for x. Congrats!',
            );
          }
          if (state.status.isFailure) {
            EventTrigger.error(
              context: context,
              msg: 'Sorry this has not worked out. Try again.',
            );
          }
        },
  child: BlocSelector<MembersBloc, MembersState, bool>(
        selector: (state) => MembersSelector.canVote(state, ranking.identityId),
        builder: (context, canVote) {
          return canVote
              ? BlocSelector<CircleRankingBloc, CircleRankingState, int>(
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
                        ? BlocSelector<CircleRankingBloc, CircleRankingState,
                            int>(
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
),
    );
  }
}
