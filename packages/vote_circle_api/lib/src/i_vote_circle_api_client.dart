import 'models/models.dart';

abstract class IVoteCircleApiClient {
  Future<User> fetchMe();
}
