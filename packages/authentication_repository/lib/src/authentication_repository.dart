import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:authentication_repository/authentication_repository.dart';


/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template verification_failure}
/// Thrown during the verification with cognito process failure occurs.
/// {@endtemplate}
class VerificationFailure implements Exception {
  /// {@macro verification_failure}
  const VerificationFailure([
    this.message = 'Verification exception occurred.',
  ]);

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Thrown during the get current user process if a failure occurs.
class CurrentUserFailure implements Exception {}

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

  final _authStateController = StreamController<AuthState>();
  late StreamSubscription<AuthHubEvent> _authHubSubscription;
  late AuthCredentials _credentials =
      LoginCredentials(username: '', password: '');
  late String _accessToken = '';

  /// Stream of [AuthState] which will emit the current [AuthFlowStatus] when
  /// the authentication state changes.
  Stream<AuthState> get status async* {
    await _checkAuthStatus();
    yield* _authStateController.stream;
  }

  /// Creates a new user with the provided [credentials].
  /// Returns true if verification is needed, otherwise false.
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
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

  void dispose() {
    _authStateController.close();
    _authHubSubscription.cancel();
  }

  get accessToken {
    return _accessToken;
  }

  Future<void> _checkAuthStatus() async {
    try {
      final cognitoPlugin =
          await Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();

      JsonWebToken accessToken = result.userPoolTokensResult.value.accessToken;
      _accessToken = accessToken.raw;

      if (result.isSignedIn) {
        _authFlowStatus = AuthFlowStatus.authenticated;
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
}
