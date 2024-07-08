import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class MembersPreview extends StatelessWidget {
  const MembersPreview({
    super.key,
    required this.circleId,
  });

  final int circleId;

  static const int _previewMemberCount = 3;
  static const double _spaceBetweenMember = 8.0;
  static const AvatarSize _avatarSize = AvatarSize.base;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleBloc, CircleState>(
      builder: (context, circleState) {
        return BlocProvider.value(
          value: BlocProvider.of<MembersBloc>(context)
            ..add(CircleMembersInitialLoaded(
              circleId: circleId,
              currentCircleId: circleState.circle.id,
            )),
          child: BlocBuilder<MembersBloc, MembersState>(
            builder: (context, state) {
              if (!state.status.isSuccessful) {
                return _buildMembersPlaceholder();
              }
              return _buildMembersPreview(
                context: context,
                circleVoter: state.circleVoter,
                circleCandidate: state.circleCandidate,
              );
            },
          ),
        );
      },
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
        style: TextButton.styleFrom(
          foregroundColor: themeData.colorScheme.secondary,
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
          const SizedBox(width: 10.0),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: themeData.colorScheme.secondary,
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
        .map((identityId) => Container(
              margin: const EdgeInsets.only(right: _spaceBetweenMember),
              child: UserAvatar(
                key: ValueKey(identityId),
                identityId: identityId,
              ),
            ))
        .toList();
  }

  Widget _buildMembersPlaceholder() {
    return Row(
      children: List<Container>.generate(
        _previewMemberCount,
        (index) => Container(
          width: _avatarSize.preSize.width,
          height: _avatarSize.preSize.height,
          margin: const EdgeInsets.only(right: _spaceBetweenMember),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.5),
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
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
    ].take(_previewMemberCount).map((member) {
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
            _previewMemberCount;
    return count;
  }
}
