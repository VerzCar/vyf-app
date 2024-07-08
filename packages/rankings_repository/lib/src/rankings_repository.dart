import 'dart:async';

import 'package:ably_service/ably_service.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:rankings_repository/rankings_repository.dart';
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

  final _addedCircleToViewedRankingsController = StreamController<String>();
  late IAblyServiceClient _ablyService;
  late SharedPreferences _sharedPrefs;
  final StreamController<RankingChangeEvent> _rankingChangedEventController =
      StreamController<RankingChangeEvent>();
  StreamSubscription<RankingChangeEvent>? _rankingChangedEventSubscription;
  static const String _viewedRankingsKey = 'vyf_viewed_ranked_circles';
  static const int _maxLengthViewedRankings = 15;

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

    _addedCircleToViewedRankingsController.sink.add(circleId);
  }

  @override
  Stream<String> get watchAddedCircleToViewedRankings async* {
    yield* _addedCircleToViewedRankingsController.stream;
  }

  @override
  Stream<RankingChangeEvent> get watchRankingChangedEvent async* {
    yield* _rankingChangedEventController.stream;
  }

  @override
  List<String> get viewedRankings => _viewedRankings;

  @override
  int get maxLengthViewedRankings => _maxLengthViewedRankings;

  @override
  void subscribeToRankingChangedEvent(int circleId) {
    try {
      if (_rankingChangedEventSubscription != null) {
        _rankingChangedEventSubscription?.cancel();
      }

      final channel = _ablyService.channel('circle-$circleId:rankings');
      _rankingChangedEventSubscription = channel
          .subscribe(name: 'ranking-changed')
          .map((event) => RankingChangeEvent.fromEventData(event.data))
          .listen((data) => _rankingChangedEventController.add(data));
    } catch (e) {
      print('subscribeToRankingChangedEvent ERROR +++++++++++');
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: delete saved rankings when user changes
    _addedCircleToViewedRankingsController.close();
    _rankingChangedEventController.close();
    _rankingChangedEventSubscription?.cancel();
    _ablyService.dispose();
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
      print(e);
    }
    return [];
  }
}
