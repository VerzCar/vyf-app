import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'auth-errors.dart';

enum AuthFlowStatus {
  unknown,
  authenticated,
  unauthenticated,
}

/// AuthState represents the current authentication state
class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({required this.authFlowStatus});
}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository implements IAuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository() {
    this._authHubSubscription =
        Amplify.Hub.listen(HubChannel.Auth, (AuthHubEvent event) async {
      switch (event.type) {
        case AuthHubEventType.signedIn:
          print('User is signed in.');
          await this._checkAuthStatus();
          break;
        case AuthHubEventType.signedOut:
          print('User is signed out.');
          await this._checkAuthStatus();
          break;
        case AuthHubEventType.sessionExpired:
          print('The session has expired.');
          await this._checkAuthStatus();
          break;
        case AuthHubEventType.userDeleted:
          print('The user has been deleted.');
          await this._checkAuthStatus();
          break;
      }
    });

    this._checkAuthStatus();
  }

  final _authStateController = StreamController<AuthState>.broadcast();
  final _accessJwtTokenController = StreamController<String>.broadcast();
  late StreamSubscription<AuthHubEvent> _authHubSubscription;
  late AuthCredentials _credentials =
      LoginCredentials(username: '', password: '');
  String _currentJwtToken = '';

  /// Stream of [AuthState] which will emit the current [AuthFlowStatus] when
  /// the authentication state changes.
  @override
  Stream<AuthState> get status async* {
    await _checkAuthStatus();
    yield* _authStateController.stream;
  }

  @override
  Stream<String> get accessJwtToken async* {
    yield* _accessJwtTokenController.stream;
  }

  @override
  Future<String> get jwtToken async {
    try {
      final authSession = await _fetchAuthSession();

      JsonWebToken accessToken =
          authSession.userPoolTokensResult.value.accessToken;

      if (authSession.isSignedIn) {
        return accessToken.raw;
      }
      return '';
    } catch (e) {
      safePrint('get jwtToken failure $e');
      return '';
    }
  }

  @override
  String get currentJwtToken => _currentJwtToken;

  /// Creates a new user with the provided [credentials].
  /// Returns true if verification is needed, otherwise false.
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<bool> signUpWithCredentials(SignUpCredentials credentials) async {
    try {
      final userAttributes = {
        CognitoUserAttributeKey.email: credentials.email,
        CognitoUserAttributeKey.preferredUsername: credentials.username,
      };

      final result = await Amplify.Auth.signUp(
          username: credentials.email,
          password: credentials.password,
          options: SignUpOptions(userAttributes: userAttributes));

      final loginCredentials = LoginCredentials(
        username: credentials.email,
        password: credentials.password,
      );

      if (result.isSignUpComplete) {
        await loginWithCredentials(loginCredentials);
        return true;
      } else {
        _credentials = loginCredentials;
        _authFlowStatus = AuthFlowStatus.unauthenticated;
        return false;
      }
    } on AuthException catch (authExe) {
      print('Failed to sign up - ${authExe.message}');
      throw SignUpWithEmailAndPasswordFailure.fromCode(authExe.message);
    } catch (err) {
      print('Failed to sign up - ${err}');
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [credentials].
  ///
  /// Throws a [AuthCredentials] if an exception occurs.
  @override
  Future<void> loginWithCredentials(AuthCredentials credentials) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: credentials.username,
        password: credentials.password,
      );

      if (result.isSignedIn) {
        this._checkAuthStatus();
      } else {
        print('User could not be signed in - ${result.toString()}');
        throw const LogInWithEmailAndPasswordFailure();
      }
    } on AuthException catch (authExe) {
      print('Could not login - ${authExe.message}');
      throw LogInWithEmailAndPasswordFailure.fromCode(authExe.message);
    }
  }

  /// Verifies the sign up code.
  ///
  /// Throws a [VerificationFailure] if an exception occurs.
  @override
  Future<void> verifyCode(String verificationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: _credentials.username,
        confirmationCode: verificationCode,
      );

      if (result.isSignUpComplete) {
        final loginCredentials = LoginCredentials(
          username: _credentials.username,
          password: _credentials.password,
        );
        await loginWithCredentials(loginCredentials);
      } else {
        // Follow more steps
        print('Failed to verify - ${result.nextStep.signUpStep}');
        throw const VerificationFailure();
      }
    } on AuthException catch (authExe) {
      print('Could not verify code - ${authExe.message}');
      throw const VerificationFailure();
    } catch (err) {
      print('Failed to verify - ${err}');
      throw const VerificationFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [fetchUser] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    try {
      await Amplify.Auth.signOut();
      _authFlowStatus = AuthFlowStatus.unauthenticated;
    } on AuthException catch (authExe) {
      print('Could not logout - ${authExe.message}');
      throw LogOutFailure();
    } catch (_) {
      throw LogOutFailure();
    }
  }

  // Future<User> user() async {
  //   try {
  //     final authUser = await Amplify.Auth.getCurrentUser();
  //     final user = User(
  //       id: authUser.userId,
  //       username: authUser.username,
  //     );
  //     return user;
  //   } catch (_) {
  //     throw CurrentUserFailure();
  //   }
  // }

  @override
  void dispose() {
    _authStateController.close();
    _accessJwtTokenController.close();
    _authHubSubscription.cancel();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final authSession = await _fetchAuthSession();

      if (authSession.isSignedIn) {
        _authFlowStatus = AuthFlowStatus.authenticated;
        JsonWebToken accessToken =
            authSession.userPoolTokensResult.value.accessToken;

        _accessJwtTokenController.add(accessToken.raw);
        _currentJwtToken = accessToken.raw;
        return;
      }
    } catch (e) {
      safePrint('Check auth state failure $e');
    }
    _authFlowStatus = AuthFlowStatus.unauthenticated;
  }

  set _authFlowStatus(AuthFlowStatus status) {
    final state = AuthState(authFlowStatus: status);
    _authStateController.add(state);
  }

  Future<CognitoAuthSession> _fetchAuthSession() async {
    final cognitoPlugin =
        await Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    return cognitoPlugin.fetchAuthSession();
  }
}
