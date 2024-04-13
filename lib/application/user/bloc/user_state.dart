part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState._({
    this.status = AuthFlowStatus.unknown,
  });

  const UserState.unknown() : this._();

  const UserState.authenticated()
      : this._(status: AuthFlowStatus.authenticated);

  const UserState.unauthenticated()
      : this._(status: AuthFlowStatus.unauthenticated);

  final AuthFlowStatus status;

  @override
  List<Object> get props => [status];
}

sealed class UserEvent {}

final class UserInitialLoaded extends UserEvent {}

class UserBloc extends Bloc<UserEvent, int> {
  UserBloc() : super(0);
}