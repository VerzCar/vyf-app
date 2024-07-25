import 'models/models.dart';

abstract class IRankingsRepository {
  Stream<RankingChangeEvent> get watchRankingChangedEvent;

  Future<void> subscribeToRankingChangedEvent(int circleId);

  void dispose();
}
