import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';
import 'package:vote_your_face/presentation/ranking/widgets/members_need_vote_sheet.dart';

class MembersNeedVotePreview extends StatelessWidget {
  const MembersNeedVotePreview({
    super.key,
    required this.circleId,
  });

  final int circleId;

  static const double _spaceBetweenMember = 8.0;
  static const AvatarSize _avatarSize = AvatarSize.sm;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CircleRankingBloc, CircleRankingState, int>(
      selector: (state) => state.circle.id,
      builder: (context, circleId) {
        return BlocProvider.value(
          value: BlocProvider.of<MembersBloc>(context)
            ..add(MembersInitialLoaded(
              circleId: circleId,
              currentCircleId: circleId,
            )),
          child: BlocSelector<MembersBloc, MembersState, List<String>>(
            selector: (state) => state.previewCandidateMemberIds,
            builder: (context, previewCandidateMemberIds) {
              return BlocSelector<MembersBloc, MembersState, int>(
                selector: (state) => state.countOfCandidateMembers,
                builder: (context, countOfCandidateMembers) {
                  return _buildMembersNeedVotePreview(
                    context: context,
                    previewCandidateMemberIds: previewCandidateMemberIds,
                    countOfCandidateMembers: countOfCandidateMembers,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  _buildMembersNeedVotePreview({
    required BuildContext context,
    required List<String> previewCandidateMemberIds,
    required int countOfCandidateMembers,
  }) {
    final themeData = Theme.of(context);

    if (previewCandidateMemberIds.isEmpty) {
      return Text(
        'No candidates',
        style: themeData.textTheme.bodyMedium?.copyWith(
          color: themeData.colorScheme.textLightColor,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showMembersNeedVoteSheet(context),
      child: Row(
        children: [
          ..._buildPreviewAvatars(userIds: previewCandidateMemberIds),
          ...[
            const SizedBox(width: 10.0),
            _countOfMembers(
              themeData,
              countOfCandidateMembers,
            ),
          ]
        ],
      ),
    );
  }

  List<Widget> _buildPreviewAvatars({
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
    int count,
  ) {
    final counterText = count > 0 ? '+ $count' : '';
    return Text(
      counterText,
      style: themeData.textTheme.labelLarge,
    );
  }

  void _showMembersNeedVoteSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context2) {
        return const MembersNeedVoteSheet();
      },
    );
  }
}
