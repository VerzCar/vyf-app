import 'dart:async';

import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';

class AblyServiceClient implements IAblyServiceClient {
  AblyServiceClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository {
    final options = _defaultAblyOptions;

    options.authHeaders =
        _authorizationHeader(_authenticationRepository.currentJwtToken);

    _realtime = ably.Realtime(options: options);

    _accessJwtTokenSubscription = _authenticationRepository.accessJwtToken
        .distinct((previous, current) => previous == current)
        .listen(
          (jwtToken) async => await _authorize(),
        );
  }

  final IAuthenticationRepository _authenticationRepository;
  late StreamSubscription<String> _accessJwtTokenSubscription;
  late final ably.Realtime _realtime;
  static const String _ablyTokenUrl =
      'https://vyf-vote-circle-309d72dfd728.herokuapp.com/v1/api/vote-circle/token/ably';
  final _defaultAblyOptions = ably.ClientOptions(
    authMethod: 'GET',
    authUrl: _ablyTokenUrl,
  );

  @override
  ably.RealtimeChannel channel(String name) {
    return _realtime.channels.get(name);
  }

  @override
  void dispose() {
    _accessJwtTokenSubscription.cancel();
    _realtime.close();
  }

  Future<void> _authorize() async {
    final authOptions = ably.AuthOptions(
      authMethod: _defaultAblyOptions.authMethod,
      authUrl: _defaultAblyOptions.authUrl,
      authHeaders:
          _authorizationHeader(await _authenticationRepository.jwtToken),
    );
    await _realtime.auth.authorize(authOptions: authOptions);
  }

  Map<String, String> _authorizationHeader(String jwtToken) {
    return {'Authorization': 'Bearer $jwtToken'};
  }
}
