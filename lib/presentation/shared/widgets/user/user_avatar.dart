import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/application/shared/shared.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.option});

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
      return option!.labelPosition == LabelPosition.right
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _avatarWithLabel(
                  avatarStack: avatarStack,
                  user: user,
                  themeData: themeData,
                  position: option!.labelPosition),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _avatarWithLabel(
                  avatarStack: avatarStack,
                  user: user,
                  themeData: themeData,
                  position: option!.labelPosition),
            );
    }

    return avatarStack;
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

  List<Widget> _avatarWithLabel({
    required Stack avatarStack,
    required User user,
    required ThemeData themeData,
    required LabelPosition position,
  }) {
    return [
      avatarStack,
      position == LabelPosition.right
          ? const SizedBox(width: 15)
          : const SizedBox(height: 10),
      Text(
        user.username,
        style: themeData.textTheme.labelLarge,
      ),
    ];
  }
}
