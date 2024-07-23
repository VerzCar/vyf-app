import 'dart:async';

import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:logger/logger.dart';
import 'package:rankings_repository/rankings_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingsRepository implements IRankingsRepository {
  /// Private constructor
  RankingsRepository._({
    required SharedPreferences sharedPrefs,
    required IAuthenticationRepository authenticationRepository,
    IAblyServiceClient? ablyService,
  }) {
    _sharedPrefs = sharedPrefs;
    _ablyService = ablyService ??
        AblyServiceClient(
          authenticationRepository: authenticationRepository,
        );
  }

  static Future<RankingsRepository> create({
    required IAuthenticationRepository authenticationRepository,
    IAblyServiceClient? ablyService,
  }) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    var repo = RankingsRepository._(
      sharedPrefs: sharedPrefs,
      authenticationRepository: authenticationRepository,
      ablyService: ablyService,
    );

    return repo;
  }

  final _addedCircleToViewedRankingsController =
      StreamController<String>.broadcast();
  final Logger log = Logger();
  late IAblyServiceClient _ablyService;
  late SharedPreferences _sharedPrefs;
  final StreamController<RankingChangeEvent> _rankingChangedEventController =
      StreamController<RankingChangeEvent>.broadcast();
  StreamSubscription<RankingChangeEvent>? _rankingChangedEventSubscription;
  static const String _viewedRankingsKey = 'vyf_viewed_ranked_circles';
  static const int _maxLengthViewedRankings = 15;
  static const Duration _eventingThrottleDuration =
      Duration(milliseconds: 2500);

  @override
  void addToViewedRankings(String circleId) async {
    final viewedRankings = _viewedRankings;

    final existingViewedRankingIndex =
        viewedRankings.indexWhere((id) => id == circleId);

    if (existingViewedRankingIndex != -1) {
      return;
    }

    _addToViewedRankings(circleId: circleId, viewedRankings: viewedRankings);

    await _sharedPrefs.setStringList(_viewedRankingsKey, viewedRankings);

    _addedCircleToViewedRankingsController.add(circleId);
  }

  @override
  void removeAllViewedRankings() async {
    await _sharedPrefs.setStringList(_viewedRankingsKey, const []);
  }

  @override
  Stream<String> get watchAddedCircleToViewedRankings {
    return _addedCircleToViewedRankingsController.stream;
  }

  @override
  Stream<RankingChangeEvent> get watchRankingChangedEvent {
    return _rankingChangedEventController.stream;
  }

  @override
  List<String> get viewedRankings => _viewedRankings;

  @override
  int get maxLengthViewedRankings => _maxLengthViewedRankings;

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

  /// Add the given circle id in the front of the either existing or new list
  /// of viewed rankings. If the length is greater as the maximum length
  /// the last element will be removed from the list.
  void _addToViewedRankings({
    required List<String> viewedRankings,
    required String circleId,
  }) {
    if (viewedRankings.length >= _maxLengthViewedRankings) {
      viewedRankings.removeLast();
    }

    viewedRankings.insert(0, circleId);
  }

  List<String> get _viewedRankings {
    try {
      return _sharedPrefs.getStringList(_viewedRankingsKey) ?? [];
    } catch (e) {
      log.t('_viewedRankings', error: e);
    }
    return [];
  }
}
