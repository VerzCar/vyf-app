import 'models/models.dart';

abstract class IUserApiClient {
  Future<User> fetchMe();
}
