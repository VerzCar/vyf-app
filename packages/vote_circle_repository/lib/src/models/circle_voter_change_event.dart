import 'commitment.dart';
import 'event_operation.dart';
import 'voter.dart';

class CircleVoterChangeEvent {
  CircleVoterChangeEvent({
    required this.operation,
    required this.voter,
  });

  final Voter voter;
  final EventOperation operation;

  factory CircleVoterChangeEvent.fromEventData(Object? data) {
    final mappedData = data as Map<Object?, Object?>;
    final voterMap = mappedData['voter'] as Map<Object?, Object?>;

    return CircleVoterChangeEvent(
      operation: eventOperationFromEvent(mappedData['operation'] as String),
      voter: Voter(
        id: voterMap['id'] as int,
        voter: voterMap['voter'] as String,
        commitment: commitmentFromEvent(voterMap['commitment'] as String),
        votedFor: voterMap['votedFor'] as String,
        // TODO: convertion of date time has to be fixed
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
