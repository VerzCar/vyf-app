import 'dart:typed_data';

import 'models/models.dart';

abstract class IUserApiClient {
  Future<User> fetchMe();

  Future<User> fetchX(String id);

  Future<List<User>> fetchUsers();

  Future<User> updateUser(UserUpdate user);

  Future<String> uploadUserProfileImage(Uint8List imageBytes);

  Future<String> deleteUserProfileImage();
}
