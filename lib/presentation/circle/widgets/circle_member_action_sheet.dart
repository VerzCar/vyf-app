import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_member_cubit.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

enum _MemberSide { candidate, voter }

class CircleMemberActionSheet extends StatelessWidget {
  const CircleMemberActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Text(
            'Member Actions',
            style: themeData.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        BlocProvider(
          create: (context) => CircleMemberCubit(
            voteCircleRepository: sl<IVoteCircleRepository>(),
          ),
          child: BlocListener<CircleMemberCubit, CircleMemberState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isCandidateActionFailure ||
                  state.status.isVoterActionFailure) {
                EventTrigger.error(
                  context: context,
                  msg: 'Sorry this has not worked out. Try again.',
                );
              }
            },
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _listTile(context, _MemberSide.candidate);
                }
                if (index == 1) {
                  return _listTile(context, _MemberSide.voter);
                }
                return null;
              },
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listTile(
    BuildContext context,
    _MemberSide side,
  ) {
    if (side == _MemberSide.candidate) {
      return BlocSelector<UserBloc, UserState, String>(
        selector: (state) => state.user.identityId,
        builder: (context, identityId) {
          return BlocSelector<CircleBloc, CircleState, bool>(
            selector: (state) => state.circle.private,
            builder: (context, isPrivate) {
              return BlocSelector<MembersBloc, MembersState, bool>(
                selector: (state) =>
                    MembersSelector.isUserCandidateMemberOfCircle(
                        state, identityId),
                builder: (context, isUserCandidateMemberOfCircle) {
                  if (!isUserCandidateMemberOfCircle && !isPrivate) {
                    return BlocBuilder<CircleMemberCubit, CircleMemberState>(
                      builder: (context, state) {
                        return ListTile(
                          leading: const Icon(Icons.group_add_outlined),
                          title: const Text('Join as candidate'),
                          trailing: state.status.isCandidateActionLoading
                              ? _trailingLoadingSpinner()
                              : null,
                          onTap: state.status.isCandidateActionLoading
                              ? null
                              : () => context
                                  .read<CircleMemberCubit>()
                                  .onJoinAsCandidate(
                                    context.read<CircleBloc>().state.circle.id,
                                  ),
                        );
                      },
                    );
                  }
                  if (isUserCandidateMemberOfCircle) {
                    return BlocBuilder<CircleMemberCubit, CircleMemberState>(
                      builder: (context, state) {
                        return ListTile(
                          leading: const Icon(Icons.group_remove_outlined),
                          title: const Text('Leave as candidate'),
                          trailing: state.status.isCandidateActionLoading
                              ? _trailingLoadingSpinner()
                              : null,
                          onTap: state.status.isCandidateActionLoading
                              ? null
                              : () => context
                                  .read<CircleMemberCubit>()
                                  .onLeaveAsCandidate(
                                    context.read<CircleBloc>().state.circle.id,
                                  ),
                        );
                      },
                    );
                  }
                  return const SizedBox(width: 0, height: 0);
                },
              );
            },
          );
        },
      );
    }

    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.user.identityId,
      builder: (context, identityId) {
        return BlocSelector<CircleBloc, CircleState, bool>(
          selector: (state) => state.circle.private,
          builder: (context, isPrivate) {
            return BlocSelector<MembersBloc, MembersState, bool>(
              selector: (state) =>
                  MembersSelector.isUserVoterMemberOfCircle(state, identityId),
              builder: (context, isUserVoterMemberOfCircle) {
                if (!isUserVoterMemberOfCircle && !isPrivate) {
                  return BlocBuilder<CircleMemberCubit, CircleMemberState>(
                    builder: (context, state) {
                      return ListTile(
                        leading: const Icon(Icons.add_task_outlined),
                        title: const Text('Join as voter'),
                        trailing: state.status.isVoterActionLoading
                            ? _trailingLoadingSpinner()
                            : null,
                        onTap: state.status.isVoterActionLoading
                            ? null
                            : () => context
                                .read<CircleMemberCubit>()
                                .onJoinAsVoter(
                                  context.read<CircleBloc>().state.circle.id,
                                ),
                      );
                    },
                  );
                }
                if (isUserVoterMemberOfCircle) {
                  return BlocBuilder<CircleMemberCubit, CircleMemberState>(
                    builder: (context, state) {
                      return ListTile(
                        leading: const Icon(Icons.remove_done_outlined),
                        title: const Text('Leave as voter'),
                        trailing: state.status.isVoterActionLoading
                            ? _trailingLoadingSpinner()
                            : null,
                        onTap: state.status.isVoterActionLoading
                            ? null
                            : () => context
                                .read<CircleMemberCubit>()
                                .onLeaveAsVoter(
                                  context.read<CircleBloc>().state.circle.id,
                                ),
                      );
                    },
                  );
                }
                return const SizedBox(width: 0, height: 0);
              },
            );
          },
        );
      },
    );
  }

  Widget _trailingLoadingSpinner() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(strokeWidth: 2.0),
    );
  }
}
