import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class CandidatesView extends StatelessWidget {
  const CandidatesView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<MembersBloc, MembersState>(
      builder: (context, state) {
        final candidates = state.circleCandidate.candidates;

        return ListView.separated(
          itemCount: candidates.length,
          itemBuilder: (BuildContext context, int index) {
            final candidate = candidates[index];

            return Card(
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
                title: UserXProvider(
                  identityId: candidate.candidate,
                  child: UserAvatar(
                    key: ValueKey(candidate.candidate),
                    option: UserAvatarOption(
                        withLabel: true, commitment: candidate.commitment),
                  ),
                ),
                trailing: _removeActionButton(
                  themeData: themeData,
                  candidate: candidate,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 0,
            thickness: 3,
            color: themeData.colorScheme.blackColor,
          )
        );
      },
    );
  }

  Widget _removeActionButton({
    required ThemeData themeData,
    required Candidate candidate,
  }) {
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
}
