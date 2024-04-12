import 'models/models.dart';

abstract class IUserApiClient {
  Future<User> fetchMe();

  Future<User> fetchX(String id);

  Future<List<User>> fetchUsers();
}
