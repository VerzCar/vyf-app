import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
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
          if (!MembersStateStatus(state.status).isSuccessful) {
            return const SizedBox();
          }
          return _buildMembersPreview(
            context: context,
            circleVoter: state.circleVoter,
            circleCandidate: state.circleCandidate,
          );
        },
      ),
    );
  }

  _buildMembersPreview({
    required BuildContext context,
    required CircleVoter circleVoter,
    required CircleCandidate circleCandidate,
  }) {
    final themeData = Theme.of(context);
    final userIds = _firstThreeUserIds(circleVoter, circleCandidate);

    if (userIds.isEmpty) {
      return TextButton(
        style: themeData.textButtonTheme.style?.copyWith(
          foregroundColor:
              MaterialStatePropertyAll(themeData.colorScheme.secondary),
        ),
        onPressed: () {
          context.router.push(MembersRoute(circleId: circleId));
        },
        child: const Text('There are no members - invite some'),
      );
    }

    return Row(
      children: [
        ..._buildPreviewAvatars(themeData: themeData, userIds: userIds),
        ...[
          const SizedBox(width: 10.0),
          _countOfMembers(
            themeData,
            circleVoter,
            circleCandidate,
          ),
          const SizedBox(width: 20.0),
          TextButton(
            style: themeData.textButtonTheme.style?.copyWith(
              foregroundColor:
                  MaterialStatePropertyAll(themeData.colorScheme.secondary),
            ),
            onPressed: () {
              context.router.push(MembersRoute(circleId: circleId));
            },
            child: const Text('View Members'),
          ),
        ]
      ],
    );
  }

  List<Widget> _buildPreviewAvatars({
    required ThemeData themeData,
    required List<String> userIds,
  }) {
    return userIds
        .map((identityId) => BlocProvider(
              create: (context) =>
                  UserXCubit(userRepository: sl<IUserRepository>())
                    ..userXFetched(
                      context: context,
                      identityId: identityId,
                    ),
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: const UserAvatar(),
              ),
            ))
        .toList();
  }

  Text _countOfMembers(
    ThemeData themeData,
    CircleVoter circleVoter,
    CircleCandidate circleCandidate,
  ) {
    final count = _countOfRemainingMembers(circleVoter, circleCandidate);
    final counterText = count > 0 ? '+ $count' : '';
    return Text(
      counterText,
      style: themeData.textTheme.labelLarge,
    );
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
