import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class MembersNeedVotePreview extends StatelessWidget {
  const MembersNeedVotePreview({
    super.key,
    required this.circleId,
  });

  final int circleId;

  static const int _previewMemberCount = 3;
  static const double _spaceBetweenMember = 8.0;
  static const AvatarSize _avatarSize = AvatarSize.sm;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CircleBloc, CircleState, int>(
      selector: (state) => state.circle.id,
      builder: (context, circleId) {
        return BlocProvider.value(
          value: BlocProvider.of<MembersBloc>(context)
            ..add(CircleMembersInitialLoaded(
              circleId: circleId,
              currentCircleId: circleId,
            )),
          child: BlocBuilder<MembersBloc, MembersState>(
            builder: (context, state) {
              if (state.status.isNotSuccessful || state.status.isLoading) {
                return SizedBox(
                  width: _avatarSize.preSize.width,
                  height: _avatarSize.preSize.height,
                );
              }

              return _buildMembersNeedVotePreview(
                context: context,
                circleCandidate: state.circleCandidate,
              );
            },
          ),
        );
      },
    );
  }

  _buildMembersNeedVotePreview({
    required BuildContext context,
    required CircleCandidate circleCandidate,
  }) {
    final themeData = Theme.of(context);
    final userIds = _firstThreeUserIds(circleCandidate);

    if (userIds.isEmpty) {
      return Text(
        'No candidates',
        style: themeData.textTheme.bodyMedium?.copyWith(
          color: themeData.colorScheme.textLightColor,
        ),
      );
    }

    return Row(
      children: [
        ..._buildPreviewAvatars(themeData: themeData, userIds: userIds),
        ...[
          const SizedBox(width: 10.0),
          _countOfMembers(
            themeData,
            circleCandidate,
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
                option: const UserAvatarOption(
                  size: _avatarSize,
                ),
              ),
            ))
        .toList();
  }

  Text _countOfMembers(
    ThemeData themeData,
    CircleCandidate circleCandidate,
  ) {
    final count = _countOfRemainingMembers(circleCandidate);
    final counterText = count > 0 ? '+ $count' : '';
    return Text(
      counterText,
      style: themeData.textTheme.labelLarge,
    );
  }

  List<String> _firstThreeUserIds(
    CircleCandidate circleCandidate,
  ) {
    return circleCandidate.candidates
        .take(_previewMemberCount)
        .map((member) => member.candidate)
        .toList();
  }

  int _countOfRemainingMembers(
    CircleCandidate circleCandidate,
  ) {
    return circleCandidate.candidates.length - _previewMemberCount;
  }
}
