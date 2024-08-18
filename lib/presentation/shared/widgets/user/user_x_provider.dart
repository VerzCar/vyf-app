import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/application/user/user.dart';
import 'package:vote_your_face/injection.dart';

/// This provider can be used as a wrapper around any child and it
/// provides the UserXCubit State in the subtree. If the parent identityId
/// changes the user will be fetched again for the given identityId.
class UserXProvider extends StatefulWidget {
  const UserXProvider({
    super.key,
    required this.identityId,
    required this.child,
  });

  final String identityId;
  final Widget child;

  @override
  State<UserXProvider> createState() => _UserXProviderState();
}

class _UserXProviderState extends State<UserXProvider> {
  String _currentIdentId = '';
  bool _fetchUser = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIdentId = widget.identityId;
    });
  }

  @override
  void didUpdateWidget(covariant UserXProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isSameIdentId) {
      setState(() {
        _currentIdentId = widget.identityId;
        _fetchUser = true;
      });
      return;
    }

    setState(() {
      _fetchUser = false;
    });
  }

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
            listener: (context, state) {
              context.read<UserXCubit>().currentUserChanged(
                    currentUser: state.user,
                    identityId: widget.identityId,
                  );
            },
            child: _UserX(
              fetchUser: _fetchUser,
              currentUser: user,
              identityId: widget.identityId,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }

  bool get _isSameIdentId {
    return _currentIdentId == widget.identityId;
  }
}

class _UserX extends StatelessWidget {
  const _UserX({
    required this.fetchUser,
    required this.currentUser,
    required this.identityId,
    required this.child,
  });

  final bool fetchUser;
  final User currentUser;
  final String identityId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (fetchUser) {
      context.read<UserXCubit>().userXFetched(
            currentUser: currentUser,
            identityId: identityId,
          );
    }
    return child;
  }
}
