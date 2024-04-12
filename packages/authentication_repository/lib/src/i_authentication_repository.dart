import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';

abstract class IAuthenticationRepository {
  Future<bool> signUpWithCredentials(SignUpCredentials credentials);

  Future<void> loginWithCredentials(AuthCredentials credentials);

  Future<void> verifyCode(String verificationCode);

  Future<void> logOut();

  void dispose();

  get accessToken;

  Stream<AuthState> get status;
}
