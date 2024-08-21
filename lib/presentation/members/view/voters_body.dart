import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class VotersBody extends StatelessWidget {
  const VotersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyLayout(
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
    return BlocBuilder<MembersBloc, MembersState>(
      builder: (context, state) {
        final voters = state.circleVoter.voters;

        return ListView.separated(
            itemCount: voters.length,
            itemBuilder: (BuildContext context, int index) {
              final voter = voters[index];

              return UserXProvider(
                identityId: voter.voter,
                child: ListTile(
                  key: Key(voter.id.toString()),
                  leading: UserAvatar(
                    key: ValueKey(voter.voter),
                  ),
                  title: BlocBuilder<UserXCubit, UserXState>(
                    builder: (context, state) {
                      return Text(state.user.displayName);
                    },
                  ),
                  trailing: _removeActionButton(
                    context: context,
                    voter: voter,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const ListSeparator());
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

            return ListTile(
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
                'Add voters',
                style: TextStyle(
                  color: themeData.colorScheme.secondary,
                ),
              ),
              onTap: () => _showAddMembersSheet(context),
            );
          },
        );
      },
    );
  }

  Widget _removeActionButton({
    required BuildContext context,
    required Voter voter,
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
                onPressed: () =>
                    context
                        .read<MembersBloc>()
                        .add(MembersRemovedVoterFromCircle(
                      currentCircleId: circleId,
                      voterIdentId: voter.voter,
                    )),
                child: const Icon(Icons.close),
              )
                  : const SizedBox();
            },
          ),
    );
  }

  void _showAddMembersSheet(BuildContext context,) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context2) {
        return BlocSelector<MembersBloc, MembersState, List<String>>(
          selector: (state) =>
              state.circleVoter.voters.map((v) => v.voter).toList(),
          builder: (context, notSelectableUserIdentIds) {
            return BlocSelector<CircleBloc, CircleState, bool>(
              selector: (state) => state.circle.private,
              builder: (context, isPrivateCircle) {
                return BlocSelector<UserOptionBloc, UserOptionState, int>(
                  selector: (state) =>
                  isPrivateCircle
                      ? state.userOption.privateOption.maxVoters
                      : state.userOption.maxVoters,
                  builder: (context, maxMembers) {
                    return UserSelectionSheet(
                        maxSelections: maxMembers,
                        notSelectableUserIdentIds: notSelectableUserIdentIds,
                        onAdd: (users) {
                          final usersIdentIds =
                          users.map((user) => user.identityId).toList();
                          final currentCircleId =
                              context
                                  .read<CircleBloc>()
                                  .state
                                  .circle
                                  .id;
                          context.read<MembersBloc>().add(
                            MembersAddedVotersToCircle(
                              voterIdentIds: usersIdentIds,
                              currentCircleId: currentCircleId,
                            ),
                          );
                          context.router.maybePop();
                        });
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
