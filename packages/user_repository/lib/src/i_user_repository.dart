import 'models/models.dart';

abstract class IUserRepository {
  Future<User> me();

  Future<User> x(String id);

  Future<List<User>> users();

  Future<User> updateUser(UserUpdate user);
}
