import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/presentation/ranking/widgets/voting_button.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

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
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 3.0,
                        ),
                        title: UserAvatar(
                          key: ValueKey(candidate.candidate),
                          identityId: candidate.candidate,
                          option: UserAvatarOption(
                              withLabel: true,
                              commitment: candidate.commitment),
                        ),
                        trailing:
                            VotingButton(identityId: candidate.candidate)),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            );
          },
        ),
      ],
    );
  }
}
