import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

import 'voter.dart';

class CircleVoter extends Equatable {
  final List<Voter> voters;
  final Voter? userVoter;

  const CircleVoter({
    required this.voters,
    this.userVoter,
  });

  static const empty = CircleVoter(
    voters: [],
  );

  CircleVoter copyWith({
    List<Voter>? voters,
    Voter? Function()? userVoter,
  }) =>
      CircleVoter(
        voters: voters ?? this.voters,
        userVoter: userVoter != null ? userVoter() : this.userVoter,
      );

  factory CircleVoter.fromApiCircleVoter(vote_circle_api.CircleVoter voter) =>
      CircleVoter(
        voters: voter.voters
            .map((apiCandidate) => Voter.fromApiVoter(apiCandidate))
            .toList(),
        userVoter: voter.userVoter != null
            ? Voter.fromApiVoter(voter.userVoter!)
            : null,
      );

  @override
  List<Object?> get props => [
        voters,
        userVoter,
      ];
}
