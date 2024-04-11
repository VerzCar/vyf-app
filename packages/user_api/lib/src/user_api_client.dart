import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:user_api/user_api.dart';
import 'package:http/http.dart' as http;

import 'api-errors.dart';

class UserApiClient {
  UserApiClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final GraphQLCache _cache = GraphQLCache();
  final AuthenticationRepository _authenticationRepository;

  // GraphQLClient _client() {
  //   final _httpLink = HttpLink(
  //     'http://127.0.0.1:8080/query',
  //   );
  //
  //   final _authLink = AuthLink(
  //     getToken: () async => 'Bearer ${_authenticationRepository.accessToken}',
  //   );
  //
  //   Link _link = _authLink.concat(_httpLink);
  //
  //   return GraphQLClient(
  //     cache: _cache,
  //     link: _link,
  //   );
  // }

  Future<User> fetchUser() async {
    var logger = Logger();
    final res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    try {
      final client = _client();
      final result = await client.query$user();

      logger.i(result.exception);

      if (result.hasException) {
        logger.i(result.exception?.linkException);
        logger.i(result.exception?.graphqlErrors.first);
        throw QueryUserFailure();
      }

      final queryUser = result.parsedData!.user;
      return User.fromQuery(queryUser);
    } catch (e) {
      logger.e(e);
      throw QueryUserFailure();
    }
  }

  // updates the users profile and returns the updated profile data
  Future<Profile> updateUserProfile(ProfileInput profileInput) async {
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
  }
}
