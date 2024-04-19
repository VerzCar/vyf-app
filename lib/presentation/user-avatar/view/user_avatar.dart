import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/user-avatar/cubit/user_avatar_cubit.dart';
import 'package:vote_your_face/application/shared/shared.dart';

class UserAvatarPopulated extends StatelessWidget {
  const UserAvatarPopulated({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAvatarCubit, UserAvatarState>(
        builder: (context, state) {
      switch (state.status) {
        case StatusIndicator.initial:
          return const Center(child: Text('initial Loading'));
        case StatusIndicator.loading:
          return const Center(child: CircularProgressIndicator());
        case StatusIndicator.success:
          return AvatarImage(
            src: state.user.profile.imageSrc,
            capitalLetters: usersInitials(state.user.username),
          );
        case StatusIndicator.failure:
          return const Center(child: Text('Error'));
      }
    });
  }
}
