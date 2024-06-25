import 'dart:async';

import 'package:rankings_repository/rankings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingsRepository implements IRankingsRepository {
  /// Private constructor
  RankingsRepository._({
    required SharedPreferences sharedPrefs,
  }) {
    _sharedPrefs = sharedPrefs;
  }

  static Future<RankingsRepository> create() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    var repo = RankingsRepository._(
      sharedPrefs: sharedPrefs,
    );

    return repo;
  }

  final _addedCircleToViewedRankingsController = StreamController<String>();
  late SharedPreferences _sharedPrefs;
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

    _addedCircleToViewedRankingsController.add(circleId);
  }

  @override
  Stream<String> get watchAddedCircleToViewedRankings async* {
    yield* _addedCircleToViewedRankingsController.stream;
  }

  @override
  List<String> get viewedRankings => _viewedRankings;

  @override
  int get maxLengthViewedRankings => _maxLengthViewedRankings;

  @override
  void dispose() {
    _addedCircleToViewedRankingsController.close();
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
