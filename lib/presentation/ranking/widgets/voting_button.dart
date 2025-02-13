import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/bloc/circle_ranking_bloc.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/members/selector/members_selector.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/ranking/cubit/vote_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class VotingButton extends StatelessWidget {
  const VotingButton({
    super.key,
    required this.identityId,
    this.disabled = false,
  });

  final String identityId;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          VoteCubit(voteCircleRepository: sl<IVoteCircleRepository>()),
      child: BlocListener<VoteCubit, VoteState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == VoteStatus.voteSuccess) {
            EventTrigger.success(
              context: context,
              msg: 'Your vote has been placed. Congratulations!',
            );
          }
          if (state.status == VoteStatus.revokedSuccess) {
            EventTrigger.success(
              context: context,
              msg: 'Your vote has been revoked.',
            );
          }
          if (state.status == VoteStatus.failure) {
            EventTrigger.error(
              context: context,
              msg: 'Sorry this has not worked out. Try again.',
            );
          }
        },
        child: BlocSelector<MembersBloc, MembersState, bool>(
          selector: (state) => MembersSelector.canVote(state, identityId),
          builder: (context, canVote) {
            return canVote
                ? BlocSelector<CircleRankingBloc, CircleRankingState, int>(
                    selector: (state) => state.circle.id,
                    builder: (context, circleId) {
                      return BlocBuilder<VoteCubit, VoteState>(
                        builder: (context, state) {
                          return AnimatedOpacity(
                            opacity:
                                state.status == VoteStatus.loading ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 500),
                            child: ElevatedButton(
                              onPressed: disabled
                                  ? null
                                  : () => context.read<VoteCubit>().voted(
                                        circleId: circleId,
                                        candidateId: identityId,
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
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
