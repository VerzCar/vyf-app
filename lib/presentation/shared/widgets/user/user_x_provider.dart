import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';

class UserXProvider extends StatelessWidget {
  const UserXProvider({
    super.key,
    required this.child,
    required this.identityId,
  });

  final Widget child;
  final String identityId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, User>(
      selector: (state) => state.user,
      builder: (context, user) {
        return BlocProvider(
          create: (context) => UserXCubit(userRepository: sl<IUserRepository>())
            ..userXFetched(
              currentUser: user,
              identityId: identityId,
            ),
          child: child,
        );
      },
    );
  }
}
