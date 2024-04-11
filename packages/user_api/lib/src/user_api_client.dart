import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:user_api/user_api.dart';
import 'package:http/http.dart' as http;

part 'api-errors.dart';

class UserApiClient {
  UserApiClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  final String _baseApiHost = 'vyf-user-service-4fe07f1427d1.herokuapp.com';
  final String _basePath = 'v1/api/user';

  Future<User> fetchMe() async {
    var logger = Logger();
    final res = await http.get(_uri(), headers: _headers());

    if(res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
    } else {
      logger.e(res.body);
      throw QueryUserFailure();
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
