abstract class IRankingsRepository {
  /// Adds the circle id to the last viewed rankings.
  void addToViewedRankings(String circleId);

  /// Returns a list of circle ids of
  /// last viewed circle rankings.
  List<String> get viewedRankings;

  Stream<String> get watchAddedCircleToViewedRankings;

  int get maxLengthViewedRankings;

  void dispose();
}
