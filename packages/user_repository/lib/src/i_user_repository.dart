import 'dart:typed_data';

import 'models/models.dart';

abstract class IUserRepository {
  Future<User> me();

  Future<User> x(String id);

  Future<List<UserPaginated>> users();

  Future<List<UserPaginated>> usersFiltered(String username);

  Future<User> updateUser(UserUpdate user);

  Future<String> uploadUserProfileImage(Uint8List imageBytes);

  Future<String> deleteUserProfileImage();
}
