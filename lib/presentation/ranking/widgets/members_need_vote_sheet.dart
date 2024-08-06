import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/ranking/widgets/voting_button.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class MembersNeedVoteSheet extends StatelessWidget {
  const MembersNeedVoteSheet({super.key});

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
            'Candidates',
            style: themeData.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            final candidates = state.circleCandidate.candidates;

            return Expanded(
              child: ListView.separated(
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
                    child: UserXProvider(
                      identityId: candidate.candidate,
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
                        subtitle: candidate.commitment.notCommitted
                            ? const Text('commitment open')
                            : const Text(''),
                        trailing: VotingButton(
                          identityId: candidate.candidate,
                          disabled: candidate.commitment.notCommitted,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 0,
                  thickness: 3,
                  color: themeData.colorScheme.blackColor,
                )
              ),
            );
          },
        ),
      ],
    );
  }
}
