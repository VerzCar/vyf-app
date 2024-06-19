import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';

class AblyServiceClient implements IAblyServiceClient {
  AblyServiceClient({required authenticationRepository})
      : _authenticationRepository = authenticationRepository {
    _realtime = ably.Realtime(options: _clientOptions);
  }

  final IAuthenticationRepository _authenticationRepository;
  late final ably.Realtime _realtime;
  static const String _ablyTokenUrl =
      'https://vyf-vote-circle-309d72dfd728.herokuapp.com/v1/api/vote-circle/token/ably';

  @override
  ably.RealtimeChannel channel(String name) {
    _realtime.auth.authorize();
    return _realtime.channels.get(name);
  }

  ably.ClientOptions get _clientOptions {
    return ably.ClientOptions(
      authMethod: 'GET',
      authUrl: _ablyTokenUrl,
      authCallback: ,
      authHeaders: {
        'Authorization': 'Bearer ${_authenticationRepository.accessToken}'
      },
    );
  }
}
