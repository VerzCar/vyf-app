import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class CandidatesView extends StatelessWidget {
  const CandidatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembersBloc, MembersState>(
      listener: (context, state) {
        // TODO: this will take any failed actions from members bloc
        //  we need more detailed error handling here
        if (state.status.isFailure) {
          EventTrigger.error(
            context: context,
            msg: 'Could not take action. Try again.',
          );
        }
      },
      child: Column(
        children: [
          _addMemberTile(context),
          const SizedBox(height: 5),
          Expanded(
            child: _membersList(context),
          ),
        ],
      ),
    );
  }

  Widget _membersList(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<MembersBloc, MembersState>(
      builder: (context, state) {
        final candidates = state.circleCandidate.candidates;

        return ListView.separated(
            itemCount: candidates.length,
            itemBuilder: (BuildContext context, int index) {
              final candidate = candidates[index];

              return UserXProvider(
                identityId: candidate.candidate,
                child: Card(
                  key: Key(candidate.id.toString()),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  margin: const EdgeInsets.all(0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    leading: UserAvatar(
                      key: ValueKey(candidate.candidate),
                      option: UserAvatarOption(
                        commitment: candidate.commitment,
                      ),
                    ),
                    title: BlocBuilder<UserXCubit, UserXState>(
                      builder: (context, state) {
                        return Text(state.user.displayName);
                      },
                    ),
                    trailing: _removeActionButton(
                      context: context,
                      candidate: candidate,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  height: 3,
                  thickness: 3,
                  color: themeData.colorScheme.blackColor,
                ));
      },
    );
  }

  Widget _addMemberTile(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.user.identityId,
      builder: (context, identityId) {
        return BlocSelector<CircleBloc, CircleState, bool>(
          selector: (state) => CircleSelector.canEdit(state, identityId),
          builder: (context, canEdit) {
            if (!canEdit) {
              return const SizedBox();
            }

            return Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              margin: const EdgeInsets.all(0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                leading: Container(
                  width: AvatarSize.base.preSize.width,
                  height: AvatarSize.base.preSize.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.5),
                    color: themeData.colorScheme.secondary.withAlpha(220),
                  ),
                  child: Icon(
                    Icons.plus_one_outlined,
                    color: themeData.colorScheme.onSecondary,
                  ),
                ),
                title: Text(
                  'Add candidates',
                  style: TextStyle(
                    color: themeData.colorScheme.secondary,
                  ),
                ),
                onTap: () => _showAddMembersSheet(context),
              ),
            );
          },
        );
      },
    );
  }

  Widget _removeActionButton({
    required BuildContext context,
    required Candidate candidate,
  }) {
    final themeData = Theme.of(context);

    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.user.identityId,
      builder: (context, identityId) =>
          BlocSelector<CircleBloc, CircleState, int?>(
        selector: (state) =>
            CircleSelector.canEdit(state, identityId) ? state.circle.id : null,
        builder: (context, circleId) {
          return circleId != null
              ? TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: themeData.colorScheme.error),
                  onPressed: () => context
                      .read<MembersBloc>()
                      .add(MembersRemovedCandidateFromCircle(
                        currentCircleId: circleId,
                        candidateIdentId: candidate.candidate,
                      )),
                  child: const Icon(Icons.close),
                )
              : const SizedBox();
        },
      ),
    );
  }

  void _showAddMembersSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context2) {
        return BlocSelector<MembersBloc, MembersState, List<String>>(
          selector: (state) =>
              state.circleCandidate.candidates.map((c) => c.candidate).toList(),
          builder: (context, notSelectableUserIdentIds) {
            return UserSelectionSheet(
                notSelectableUserIdentIds: notSelectableUserIdentIds,
                onAdd: (users) {
                  final usersIdentIds =
                      users.map((user) => user.identityId).toList();
                  final currentCircleId =
                      context.read<CircleBloc>().state.circle.id;
                  context.read<MembersBloc>().add(
                        MembersAddedCandidatesToCircle(
                          candidateIdentIds: usersIdentIds,
                          currentCircleId: currentCircleId,
                        ),
                      );
                  context.router.maybePop();
                });
          },
        );
      },
    );
  }
}
