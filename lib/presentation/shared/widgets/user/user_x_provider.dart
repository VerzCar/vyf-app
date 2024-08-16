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

  // TODO: this is not working very well when the identId is updating from outside
  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, User>(
      selector: (state) => state.user,
      builder: (context, user) {
        return BlocProvider(
          create: (context) =>
              UserXCubit(userRepository: sl<IUserRepository>()),
          child: BlocListener<UserBloc, UserState>(
            listenWhen: (prev, current) => prev.user != current.user,
            listener: (context2, state) {
              context.read<UserXCubit>().currentUserChanged(
                    currentUser: state.user,
                    identityId: identityId,
                  );
            },
            child: BlocBuilder<UserXCubit, UserXState>(
              buildWhen: (prev, current) =>
                  prev.user.id != 0 && prev.user.id != current.user.id,
              builder: (context, state) {
                context.read<UserXCubit>().userXFetched(
                      currentUser: user,
                      identityId: identityId,
                    );

                return child;
              },
            ),
          ),
        );
      },
    );
  }
}
