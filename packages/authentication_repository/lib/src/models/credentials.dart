import 'package:equatable/equatable.dart';

abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({
    required this.username,
    required this.password,
  });
}

class LoginCredentials extends AuthCredentials with EquatableMixin {
  LoginCredentials({
    required String username,
    required String password,
  }) : super(
          username: username,
          password: password,
        );

  @override
  List<Object?> get props => [username, password];
}

class SignUpCredentials extends AuthCredentials with EquatableMixin {
  SignUpCredentials({
    required String username,
    required String password,
    required this.email,
  }) : super(
          username: username,
          password: password,
        );

  final String email;

  @override
  List<Object?> get props => [username, password, email];
}
