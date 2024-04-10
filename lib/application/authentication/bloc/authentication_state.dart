part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthFlowStatus.unknown,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated()
      : this._(status: AuthFlowStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthFlowStatus.unauthenticated);

  final AuthFlowStatus status;

  @override
  List<Object> get props => [status];
}
