import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/members/cubit/candidates_select_cubit.dart';
import 'package:vote_your_face/presentation/members/widgets/candidate_search.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class CandidatesView extends StatelessWidget {
  const CandidatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        const CandidateSearch(),
        const SizedBox(height: 10),
        _selectionsList(context),
        Expanded(
          child: _membersList(context),
        ),
        _selectionButton(context),
      ],
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

  Widget _selectionsList(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<CandidatesSelectCubit, CandidatesSelectState>(
      builder: (context, state) {
        final selectedUsers = state.selectedUsers;

        if(selectedUsers.isEmpty) {
          return const SizedBox();
        }

        return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selected candidates'),
            const SizedBox(height: 5),
            ListView.separated(
                shrinkWrap: true,
                itemCount: selectedUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  final su = selectedUsers[index];

                  return UserXProvider(
                    identityId: su.user.identityId,
                    child: Card(
                      key: Key(su.user.id.toString()),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: const EdgeInsets.all(0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        leading: AvatarImage(
                          src: su.user.profile.imageSrc,
                          capitalLetters: usersInitials(su.user.username),
                        ),
                        title: Text(su.user.username),
                        onTap: () => su.selected
                            ? context
                                .read<CandidatesSelectCubit>()
                                .removeFromSelection(user: su.user)
                            : context
                                .read<CandidatesSelectCubit>()
                                .selectUser(user: su.user),
                        trailing: Checkbox(
                          value: su.selected,
                          onChanged: (value) => su.selected
                              ? context
                                  .read<CandidatesSelectCubit>()
                                  .removeFromSelection(user: su.user)
                              : context
                                  .read<CandidatesSelectCubit>()
                                  .selectUser(user: su.user),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      height: 3,
                      thickness: 3,
                      color: themeData.colorScheme.blackColor,
                    ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _selectionButton(BuildContext context) {
    final themeData = Theme.of(context);

    return ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
          foregroundColor: themeData.colorScheme.onPrimary,
          backgroundColor: themeData.colorScheme.primary),
      child: const Text('Add Candidates'),
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
}
