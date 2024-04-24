import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar.dart';
import 'package:vote_your_face/presentation/user-avatar/cubit/user_avatar_cubit.dart';

final class UserAvatarOption {
  UserAvatarOption({
    this.border = false,
    this.withLabel = false,
    this.size = AvatarSize.base,
  });

  final bool border;
  final bool withLabel;
  final AvatarSize size;
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.identityId,
    this.option,
  });

  final String identityId;
  final UserAvatarOption? option;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) =>
          UserAvatarCubit(userRepository: sl<IUserRepository>())
            ..getUser(context: ctx, identityId: identityId),
      child: UserAvatarPopulated(option: option),
    );
  }
}
