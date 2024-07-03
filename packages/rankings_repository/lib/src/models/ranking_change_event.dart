import 'event_operation.dart';
import 'placement.dart';
import 'ranking.dart';

class RankingChangeEvent {
  RankingChangeEvent({
    required this.operation,
    required this.ranking,
  });

  final Ranking ranking;
  final EventOperation operation;

  factory RankingChangeEvent.fromEventData(Object? data) {
    final mappedData = data as Map<Object?, Object?>;
    final rankingMap = mappedData['ranking'] as Map<Object?, Object?>;

    return RankingChangeEvent(
      operation: eventOperationFromEvent(mappedData['operation'] as String),
      ranking: Ranking(
        id: rankingMap['id'] as int,
        candidateId: rankingMap['candidateId'] as int,
        identityId: rankingMap['identityId'] as String,
        number: rankingMap['number'] as int,
        votes: rankingMap['votes'] as int,
        indexedOrder: rankingMap['indexedOrder'] as int,
        placement: placementFromEvent(rankingMap['placement'] as String),
        circleId: rankingMap['circleId'] as int,
        // TODO: convertion of date time has to be fixed
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
