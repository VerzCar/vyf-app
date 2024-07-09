import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

import 'candidate.dart';

class CircleCandidate extends Equatable {
  final List<Candidate> candidates;
  final Candidate? userCandidate;

  const CircleCandidate({
    required this.candidates,
    this.userCandidate,
  });

  static const empty = CircleCandidate(
    candidates: [],
  );

  CircleCandidate copyWith({
    List<Candidate>? candidates,
    Candidate? Function()? userCandidate,
  }) =>
      CircleCandidate(
        candidates: candidates ?? this.candidates,
        userCandidate:
            userCandidate != null ? userCandidate() : this.userCandidate,
      );

  factory CircleCandidate.fromApiCircleCandidate(
          vote_circle_api.CircleCandidate candidate) =>
      CircleCandidate(
        candidates: candidate.candidates
            .map((apiCandidate) => Candidate.fromApiCandidate(apiCandidate))
            .toList(),
        userCandidate: candidate.userCandidate != null
            ? Candidate.fromApiCandidate(candidate.userCandidate!)
            : null,
      );

  @override
  List<Object?> get props => [
        candidates,
        userCandidate,
      ];
}
