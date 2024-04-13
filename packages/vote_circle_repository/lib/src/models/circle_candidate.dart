import 'package:equatable/equatable.dart';
import 'candidate.dart';

class CircleCandidate extends Equatable {
  final List<Candidate> candidates;
  final Candidate? userCandidate;

  const CircleCandidate({
    required this.candidates,
    this.userCandidate,
  });

  @override
  List<Object?> get props => [
        candidates,
        userCandidate,
      ];
}
