import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/user_avatar/models/models.dart';
import 'package:vote_your_face/presentation/user_avatar/view/user_avatar.dart';
import 'package:vote_your_face/presentation/user_avatar/cubit/user_avatar_cubit.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.identityId = '',
    this.user,
    this.option,
  });

  final String identityId;
  final User? user;
  final UserAvatarOption? option;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) {
        if (user != null) {
          return UserAvatarCubit(userRepository: sl<IUserRepository>())
            ..initWithExistingUser(user: user!);
        }
        return UserAvatarCubit(userRepository: sl<IUserRepository>())
          ..getUser(context: ctx, identityId: identityId);
      },
      child: UserAvatarPopulated(option: option),
    );
  }
}
