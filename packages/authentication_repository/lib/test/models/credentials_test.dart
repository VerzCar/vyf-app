import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Credentials - LoginCredentials', () {
    const username = 'mock-username';
    const password = 't0ps3cret42';

    test('uses value equality', () {
      expect(
        LoginCredentials(
          username: username,
          password: password,
        ),
        equals(LoginCredentials(
          username: username,
          password: password,
        )),
      );
    });
  });

  group('Credentials - SignUpCredentials', () {
    const username = 'mock-username';
    const password = 't0ps3cret42';
    const email = 'test@gmail.com';

    test('uses value equality', () {
      expect(
        SignUpCredentials(
          username: username,
          password: password,
          email: email,
        ),
        equals(SignUpCredentials(
          username: username,
          password: password,
          email: email,
        )),
      );
    });
  });
}
