import 'models/models.dart';

abstract class IUserRepository {
  Future<User> me();
}
