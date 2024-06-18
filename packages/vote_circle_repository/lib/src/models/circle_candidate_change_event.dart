import 'candidate.dart';
import 'commitment.dart';
import 'event_operation.dart';

class CircleCandidateChangeEvent {
  CircleCandidateChangeEvent({
    required this.operation,
    required this.candidate,
  });

  final Candidate candidate;
  final EventOperation operation;

  factory CircleCandidateChangeEvent.fromEventData(Object? data) {
    final mappedData = data as Map<Object?, Object?>;
    final candidateMap = mappedData['candidate'] as Map<Object?, Object?>;
    
    return CircleCandidateChangeEvent(
      operation: eventOperationFromEvent(mappedData['operation'] as String),
      candidate: Candidate(
        id: candidateMap['id'] as int,
        candidate: candidateMap['candidate'] as String,
        commitment: commitmentFromEvent(candidateMap['commitment'] as String),
        // TODO: convertion of date time has to be fixed
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}
