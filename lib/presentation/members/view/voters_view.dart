import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class VotersView extends StatelessWidget {
  const VotersView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<MembersBloc, MembersState>(
      builder: (context, state) {
        final voters = state.circleVoter.voters;

        return ListView.separated(
          itemCount: voters.length,
          itemBuilder: (BuildContext context, int index) {
            final voter = voters[index];

            return Card(
              key: Key(voter.id.toString()),
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
                title: UserAvatar(
                  key: ValueKey(voter.voter),
                  identityId: voter.voter,
                  option: const UserAvatarOption(
                    withLabel: true,
                  ),
                ),
                trailing: _removeActionButton(
                  themeData: themeData,
                  voter: voter,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
        );
      },
    );
  }

  Widget _removeActionButton({
    required ThemeData themeData,
    required Voter voter,
  }) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.user.identityId,
      builder: (context, identityId) =>
          BlocSelector<CircleBloc, CircleState, bool>(
        selector: (state) => CircleSelector.canEdit(state, identityId),
        builder: (context, canEdit) {
          return canEdit
              ? TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: themeData.colorScheme.error),
                  onPressed: () => context
                      .read<MembersBloc>()
                      .add(CircleMembersRemovedVoterFromCircle(
                        context: context,
                        voterIdentId: voter.voter,
                      )),
                  child: const Icon(Icons.close),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
