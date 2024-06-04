import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_api/user_api.dart' as user_api;
import 'i_user_repository.dart';
import 'models/models.dart';

class UserRepository implements IUserRepository {
  UserRepository({
    required IAuthenticationRepository authenticationRepository,
    user_api.IUserApiClient? userApi,
  }) : _userApi = userApi ??
            user_api.UserApiClient(
                authenticationRepository: authenticationRepository);

  final user_api.IUserApiClient _userApi;

  @override
  Future<User> me() async {
    final res = await _userApi.fetchMe();
    return User.fromApiUser(res);
  }

  @override
  Future<User> x(String id) async {
    final res = await _userApi.fetchX(id);
    return User.fromApiUser(res);
  }

  @override
  Future<List<User>> users() async {
    final res = await _userApi.fetchUsers();
    final users = res.map((user) => User.fromApiUser(user)).toList();
    return users;
  }

  @override
  Future<User> updateUser(UserUpdate user) async {
    final res = await _userApi.updateUser(user.toApiUserUpdate());
    return User.fromApiUser(res);
  }
}
