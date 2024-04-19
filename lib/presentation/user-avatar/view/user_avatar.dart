import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/user-avatar/cubit/user_avatar_cubit.dart';
import 'package:vote_your_face/application/shared/shared.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class UserAvatarPopulated extends StatelessWidget {
  const UserAvatarPopulated({super.key, this.option});

  final UserAvatarOption? option;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAvatarCubit, UserAvatarState>(
        builder: (context, state) {
      switch (state.status) {
        case StatusIndicator.initial:
          return const Center(child: Text('Loading'));
        case StatusIndicator.loading:
          return Container(
            width: AvatarSize.base.preSize.width,
            height: AvatarSize.base.preSize.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.black12,
            ),
          );
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
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(width: 15),
          Text(
            user.username,
            style: TextStyle(
              fontSize: themeData.textTheme.labelLarge?.fontSize,
              fontWeight: themeData.textTheme.labelLarge?.fontWeight,
            ),
          ),
        ],
      );
    }

    return avatar;
  }
}
