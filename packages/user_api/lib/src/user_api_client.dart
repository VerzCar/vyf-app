import 'dart:convert';
import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:user_api/user_api.dart';
import 'package:http/http.dart' as http;
import 'i_user_api_client.dart';

part 'api-errors.dart';

class UserApiClient implements IUserApiClient {
  UserApiClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  final String _baseApiHost = 'vyf-user-service-4fe07f1427d1.herokuapp.com';
  final String _basePath = 'v1/api/user';

  @override
  Future<User> fetchMe() async {
    var logger = Logger();

    try {
      final res = await http.get(_uri(), headers: _headers());

      if (res.statusCode >= HttpStatus.internalServerError) {
        logger.w('querying user server error: $res');
        throw ApiError(res);
      }

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>);

      if (res.statusCode == HttpStatus.ok) {
        return User.fromJson(apiResponse.data);
      }

      logger.w('querying user failed: $apiResponse');
      throw QueryUserFailure(
        statusCode: res.statusCode,
        msg: apiResponse.msg,
        status: apiResponse.status,
      );
    } catch (e) {
      rethrow;
    }
  }

  // updates the users profile and returns the updated profile data
/*  Future<Profile> updateUserProfile(ProfileInput profileInput) async {
    var logger = Logger();

    try {
      final client = _client();
      final result = await client.mutate$updateUserProfile(
        Options$Mutation$updateUserProfile(
          variables: Variables$Mutation$updateUserProfile(
            userInput: Input$UserUpdateInput(
              profile: Input$ProfileInput(
                bio: profileInput.bio,
                whyVoteMe: profileInput.whyVoteMe,
                imageSrc: profileInput.imageSrc,
              ),
            ),
          ),
        ),
      );

      if (result.hasException) {
        logger.i(result.exception?.linkException);
        logger.i(result.exception?.graphqlErrors.first);
        throw MutationUpdateUserProfileFailure();
      }

      final profile = result.parsedData!.updateUser.profile!;
      logger.i(profile.whyVoteMe);
      return Profile(
        id: profile.id,
        bio: profile.bio,
        whyVoteMe: profile.whyVoteMe,
        imageSrc: profile.imageSrc,
        imagePlaceholderColors: profile.imagePlaceholderColors,
      );
    } catch (e) {
      logger.e(e);
      throw MutationUpdateUserProfileFailure();
    }
  }*/

  Uri _uri({String? path, Map<String, dynamic>? queryParameters}) {
    final httpsUri = Uri(
      scheme: 'https',
      host: _baseApiHost,
      path: path != null ? '$_basePath/$path' : _basePath,
      queryParameters: queryParameters,
    );

    return httpsUri;
  }

  Map<String, String> _headers() {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${_authenticationRepository.accessToken}',
    };
    return headers;
  }
}
