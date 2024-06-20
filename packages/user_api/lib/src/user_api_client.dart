import 'dart:convert';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:user_api/user_api.dart';

part 'api_errors.dart';

class UserApiClient implements IUserApiClient {
  UserApiClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final IAuthenticationRepository _authenticationRepository;
  final String _baseApiHost = 'vyf-user-service-4fe07f1427d1.herokuapp.com';
  final String _basePath = 'v1/api/user';

  @override
  Future<User> fetchMe() async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying user server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return User.fromJson(apiResponse.data);
      }

      logger.e('querying user failed: $apiResponse');
      throw QueryUserFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> fetchX(String id) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: id),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying user x server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return User.fromJson(apiResponse.data);
      }

      logger.e('querying user x failed: $apiResponse');
      throw QueryUserFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> fetchUsers() async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'users'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying users server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<List<dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        final users =
            apiResponse.data.map((user) => User.fromJson(user)).toList();
        return users;
      }

      logger.e('querying users failed: $apiResponse');
      throw QueryUserFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> updateUser(UserUpdate user) async {
    var logger = Logger();

    try {
      var jsonBody = jsonEncode(user.toJson());

      final res = await http.put(
        _uri(path: 'update'),
        headers: await _headers,
        body: jsonBody,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('updating user server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return User.fromJson(apiResponse.data);
      }

      logger.e('updating user failed: $apiResponse');
      throw UpdateUserFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  Uri _uri({String? path, Map<String, dynamic>? queryParameters}) {
    final httpsUri = Uri(
      scheme: 'https',
      host: _baseApiHost,
      path: path != null ? '$_basePath/$path' : _basePath,
      queryParameters: queryParameters,
    );

    return httpsUri;
  }

  Future<Map<String, String>> get _headers async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${await _authenticationRepository.jwtToken}',
    };
    return headers;
  }
}
