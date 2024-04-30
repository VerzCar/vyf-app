import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'commitment.dart';

class Candidate extends Equatable {
  final int id;
  final String candidate;
  final Commitment commitment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Candidate({
    required this.id,
    required this.candidate,
    required this.commitment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Candidate.fromApiCandidate(vote_circle_api.Candidate candidate) =>
      Candidate(
        id: candidate.id,
        candidate: candidate.candidate,
        commitment: commitmentFromApiCommitment(candidate.commitment),
        createdAt: candidate.createdAt,
        updatedAt: candidate.updatedAt,
      );

  @override
  List<Object> get props => [
        id,
        candidate,
        commitment,
        createdAt,
        updatedAt,
      ];
}
