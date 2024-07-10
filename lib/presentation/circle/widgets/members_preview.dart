import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/application/members/bloc/members_bloc.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class MembersPreview extends StatelessWidget {
  const MembersPreview({
    super.key,
    required this.circleId,
  });

  final int circleId;

  static const double _spaceBetweenMember = 8.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleBloc, CircleState>(
      builder: (context, circleState) {
        return BlocProvider.value(
          value: BlocProvider.of<MembersBloc>(context)
            ..add(MembersInitialLoaded(
              circleId: circleId,
              currentCircleId: circleState.circle.id,
            )),
          child: BlocSelector<MembersBloc, MembersState, List<String>>(
            selector: (state) => state.previewMemberIds,
            builder: (context, previewMemberIds) {
              return BlocSelector<MembersBloc, MembersState, int>(
                selector: (state) => state.countOfMembers,
                builder: (context, countOfMembers) {
                  return _buildMembersPreview(
                    context: context,
                    previewMemberIds: previewMemberIds,
                    countOfMembers: countOfMembers,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  _buildMembersPreview({
    required BuildContext context,
    required List<String> previewMemberIds,
    required int countOfMembers,
  }) {
    final themeData = Theme.of(context);

    if (previewMemberIds.isEmpty) {
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
        ..._buildPreviewAvatars(userIds: previewMemberIds),
        ...[
          const SizedBox(width: 10.0),
          _countOfMembers(
            themeData,
            countOfMembers,
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
}
