import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.option,
  });

  final UserAvatarOption? option;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserXCubit, UserXState>(builder: (context, state) {
      switch (state.status) {
        case StatusIndicator.initial:
          return const Center(child: Text('Loading'));
        case StatusIndicator.loading:
          return _placeholder();
        case StatusIndicator.success:
          return _buildByOption(context, state.user);
        case StatusIndicator.failure:
          return const Center(child: Text('Error'));
      }
    });
  }

  Widget _placeholder() {
    var size = AvatarSize.base.preSize;
    if (option != null) {
      size = option!.size.preSize;
    }

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.5),
        color: Colors.black12,
      ),
    );
  }

  Widget _buildByOption(BuildContext context, User user) {
    final avatarSize = option?.size ?? AvatarSize.base;

    final List<Widget> avatarStackChildren = [
      AvatarImage(
        src: user.profile.imageSrc,
        capitalLetters: usersInitials(user.username),
        size: avatarSize,
      ),
    ];

    final avatarStack = Stack(
      alignment: Alignment.bottomRight,
      children: avatarStackChildren,
    );

    if (option == null) {
      return avatarStack;
    }

    if (option!.commitment != null) {
      avatarStackChildren.add(
        CommitmentIcon(
          commitment: option!.commitment!,
          size: avatarSize.preSize.width / 4,
        ),
      );
    }

    if (option!.withLabel) {
      final themeData = Theme.of(context);
      return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FixedColumnWidth(avatarSize.preSize.width),
          1: const FlexColumnWidth(),
        },
        children: _avatarWithLabel(
          avatarStack: avatarStack,
          user: user,
          themeData: themeData,
          option: option!,
        ),
      );
    }

    return avatarStack;
  }

  List<TableRow> _avatarWithLabel({
    required Stack avatarStack,
    required User user,
    required ThemeData themeData,
    required UserAvatarOption option,
  }) {
    final List<Widget> labelChildren = [
      Text(
        user.username,
        style: themeData.textTheme.labelLarge,
      ),
    ];

    if (option.labelChild != null) {
      labelChildren.add(option.labelChild!);
    }

    if (option.labelPosition == LabelPosition.bottom) {
      return [
        TableRow(
          children: [
            Column(
              children: [
                avatarStack,
                const SizedBox(height: 10),
                ...labelChildren,
              ],
            ),
          ],
        ),
      ];
    }

    return [
      TableRow(
        children: [
          avatarStack,
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.fill,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: labelChildren,
              ),
            ),
          ),
        ],
      ),
    ];
  }
}
