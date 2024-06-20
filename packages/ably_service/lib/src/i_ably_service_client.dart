import 'package:ably_flutter/ably_flutter.dart' as ably;

abstract class IAblyServiceClient {
  ably.RealtimeChannel channel(String name);

  void dispose();
}
