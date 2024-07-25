import 'dart:async';

import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:rxdart/rxdart.dart';

class RankingsRepository implements IRankingsRepository {
  RankingsRepository({
    required IAuthenticationRepository authenticationRepository,
    IAblyServiceClient? ablyService,
  }) :
    _ablyService = ablyService ??
        AblyServiceClient(
          authenticationRepository: authenticationRepository,
        );

  final Logger log = Logger();
  final IAblyServiceClient _ablyService;
  final StreamController<RankingChangeEvent> _rankingChangedEventController =
      StreamController<RankingChangeEvent>.broadcast();
  StreamSubscription<RankingChangeEvent>? _rankingChangedEventSubscription;
  static const Duration _eventingThrottleDuration =
      Duration(milliseconds: 2500);

  @override
  Stream<RankingChangeEvent> get watchRankingChangedEvent {
    return _rankingChangedEventController.stream;
  }

  @override
  Future<void> subscribeToRankingChangedEvent(int circleId) async {
    try {
      if (_rankingChangedEventSubscription != null) {
        await _rankingChangedEventSubscription?.cancel();
      }

      final channel = _ablyService.channel('circle-$circleId:rankings');
      _rankingChangedEventSubscription = channel
          .subscribe(name: 'ranking-changed')
          .map((event) => RankingChangeEvent.fromEventData(event.data))
          .bufferTime(_eventingThrottleDuration)
          .flatMap((events) => Stream.fromIterable(events))
          .listen((data) => _rankingChangedEventController.add(data));
    } catch (e) {
      log.t('subscribeToRankingChangedEvent', error: e);
    }
  }

  @override
  void dispose() {
    // TODO: delete saved rankings when user changes
    _rankingChangedEventSubscription?.cancel();
  }
}
