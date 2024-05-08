import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/application/members/members.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';
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
    return BlocProvider.value(
      value: BlocProvider.of<MembersBloc>(context)
        ..add(RankingMembersInitialLoaded(
          circleId: circleId,
          context: context,
        )),
      child: BlocBuilder<MembersBloc, MembersState>(
        builder: (context, state) {
          if (!MembersStateStatus(state.status).isSuccessful) {
            return SizedBox(
              width: _avatarSize.preSize.width,
              height: _avatarSize.preSize.height,
            );
          }

          return _buildMembersNeedVotePreview(
            context: context,
            circleCandidate: state.rankingCandidate,
          );
        },
      ),
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
        .map((identityId) => BlocProvider(
              create: (context) =>
                  UserXCubit(userRepository: sl<IUserRepository>())
                    ..userXFetched(
                      context: context,
                      identityId: identityId,
                    ),
              child: Container(
                margin: const EdgeInsets.only(right: _spaceBetweenMember),
                child: const UserAvatar(
                  option: UserAvatarOption(
                    size: _avatarSize,
                  ),
                ),
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
