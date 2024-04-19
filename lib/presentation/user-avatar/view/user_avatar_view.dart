import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar.dart';
import 'package:vote_your_face/presentation/user-avatar/cubit/user_avatar_cubit.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.identityId});

  final String identityId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext ctx) =>
          UserAvatarCubit(userRepository: sl<IUserRepository>())
            ..getUser(identityId),
      child: const UserAvatarPopulated(),
    );
  }
}
