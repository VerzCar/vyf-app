import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class MembersPreview extends StatelessWidget {
  const MembersPreview({
    super.key,
    required this.circleId,
  });

  final int circleId;
  final int previewUserCount = 3;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembersBloc(
        voteCircleRepository: sl<IVoteCircleRepository>(),
      )..add(MembersInitialLoaded(circleId: circleId)),
      child: BlocBuilder<MembersBloc, MembersState>(
        builder: (context, state) {
          return Row(
            children: [
              ..._buildPreviewAvatars(
                circleVoter: state.circleVoter,
                circleCandidate: state.circleCandidate,
              ),
              ...[
                Text(
                  '+ ${_countOfRemainingMembers(state.circleVoter, state.circleCandidate)}',
                ),
              ]
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildPreviewAvatars({
    required CircleVoter circleVoter,
    required CircleCandidate circleCandidate,
  }) {
    return _firstThreeUserIds(circleVoter, circleCandidate)
        .map((identityId) => BlocProvider(
              create: (context) =>
                  UserXCubit(userRepository: sl<IUserRepository>())
                    ..userXFetched(
                      context: context,
                      identityId: identityId,
                    ),
              child: Container(
                margin: EdgeInsets.only(right: 5.0),
                child: const UserAvatar(),
              ),
            ))
        .toList();
  }

  List<String> _firstThreeUserIds(
    CircleVoter circleVoter,
    CircleCandidate circleCandidate,
  ) {
    return [
      ...circleVoter.voters,
      ...circleCandidate.candidates,
    ].take(previewUserCount).map((member) {
      if (member is Voter) {
        return member.voter;
      }

      if (member is Candidate) {
        return member.candidate;
      }

      throw ArgumentError.value(member);
    }).toList();
  }

  int _countOfRemainingMembers(
    CircleVoter circleVoter,
    CircleCandidate circleCandidate,
  ) {
    final count =
        (circleVoter.voters.length + circleCandidate.candidates.length) -
            previewUserCount;
    return count;
  }
}
