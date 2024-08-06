import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
  Future<List<UserPaginated>> fetchUsers() async {
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
        final users = apiResponse.data
            .map((user) => UserPaginated.fromJson(user))
            .toList();
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
  Future<List<UserPaginated>> fetchUsersFiltered(String username) async {
    var logger = Logger();

    try {
      final res = await http.get(
        _uri(path: 'users/$username'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('querying users filtered server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<List<dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        final users = apiResponse.data
            .map((user) => UserPaginated.fromJson(user))
            .toList();
        return users;
      }

      logger.e('querying users filtered failed: $apiResponse');
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

  @override
  Future<String> uploadUserProfileImage(Uint8List imageBytes) async {
    var logger = Logger();

    try {
      final headers = await _headers;

      final request = http.MultipartRequest(
        'PUT',
        _uri(path: 'upload/profile-img'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers[HttpHeaders.authorizationHeader] =
          headers[HttpHeaders.authorizationHeader]!;

      final httpImage = http.MultipartFile.fromBytes(
        'profileImageFile',
        imageBytes,
        filename: 'image',
        contentType: MediaType('multipart', 'form-data'),
      );
      request.files.add(httpImage);

      final res = await request.send();

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('uploading image to user server error: $res');
        throw ApiError(res);
      }

      final contents = StringBuffer();
      await for (var data in res.stream.transform(utf8.decoder)) {
        contents.write(data);
      }

      final apiResponse =
          ApiResponse<String>.fromJson(jsonDecode(contents.toString()));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('uploading image to user failed: $apiResponse');
      throw UploadUserFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteUserProfileImage() async {
    var logger = Logger();

    try {
      final res = await http.delete(
        _uri(path: 'upload/profile-img'),
        headers: await _headers,
      );

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.e('deleting user profile image server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<String>.fromJson(jsonDecode(res.body));

      if (res.statusCode == HttpStatus.ok) {
        return apiResponse.data;
      }

      logger.e('deleting user profile imagefailed: $apiResponse');
      throw UploadUserFailure(
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
      HttpHeaders.authorizationHeader:
          'Bearer ${await _authenticationRepository.jwtToken}',
    };
    return headers;
  }
}
