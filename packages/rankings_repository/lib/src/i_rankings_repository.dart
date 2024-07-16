import 'models/models.dart';

abstract class IRankingsRepository {
  /// Adds the circle id to the last viewed rankings.
  void addToViewedRankings(String circleId);

  /// Removes all the viewed rankings from user
  void removeAllViewedRankings();

  /// Returns a list of circle ids of
  /// last viewed circle rankings.
  List<String> get viewedRankings;

  Stream<String> get watchAddedCircleToViewedRankings;

  Stream<RankingChangeEvent> get watchRankingChangedEvent;

  int get maxLengthViewedRankings;

  Future<void> subscribeToRankingChangedEvent(int circleId);

  void dispose();
}
