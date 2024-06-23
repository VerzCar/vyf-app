abstract class IRankingsRepository {
  void addToViewedRankings(String rankingId);

  List<String> get viewedRankings;
}
