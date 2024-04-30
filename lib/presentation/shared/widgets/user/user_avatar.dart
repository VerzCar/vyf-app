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
    final avatar = AvatarImage(
      src: user.profile.imageSrc,
      capitalLetters: usersInitials(user.username),
      size: option?.size ?? AvatarSize.base,
    );

    if (option == null) {
      return avatar;
    }

    if (option!.withLabel) {
      final themeData = Theme.of(context);
      return option!.labelPosition == LabelPosition.right
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _avatarWithLabel(
                  avatar: avatar,
                  user: user,
                  themeData: themeData,
                  position: option!.labelPosition),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _avatarWithLabel(
                  avatar: avatar,
                  user: user,
                  themeData: themeData,
                  position: option!.labelPosition),
            );
    }

    return avatar;
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
    required AvatarImage avatar,
    required User user,
    required ThemeData themeData,
    required LabelPosition position,
  }) {
    return [
      avatar,
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
