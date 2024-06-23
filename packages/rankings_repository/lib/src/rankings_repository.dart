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

  late SharedPreferences _sharedPrefs;
  static const String _viewedRankingsKey = 'vyf_viewed_ranked_circles';

  @override
  void addToViewedRankings(String circleId) async {
    final viewedRankings = _addToViewedRankings(circleId);
    await _sharedPrefs.setStringList(_viewedRankingsKey, viewedRankings);
  }

  @override
  List<String> get viewedRankings => _viewedRankings;

  List<String> _addToViewedRankings(String circleId) {
    final viewedRankings = _viewedRankings;

    if (viewedRankings.length >= 15) {
      viewedRankings.removeLast();
    }

    viewedRankings.insert(0, circleId);

    return viewedRankings;
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
