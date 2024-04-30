import 'package:equatable/equatable.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;
import 'commitment.dart';

class Voter extends Equatable {
  final int id;
  final String voter;
  final Commitment commitment;
  final String? votedFor;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Voter({
    required this.id,
    required this.voter,
    required this.commitment,
    this.votedFor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Voter.fromApiVoter(vote_circle_api.Voter voter) => Voter(
        id: voter.id,
        voter: voter.voter,
        commitment: commitmentFromApiCommitment(voter.commitment),
        votedFor: voter.votedFor,
        createdAt: voter.createdAt,
        updatedAt: voter.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        voter,
        commitment,
        votedFor,
        createdAt,
        updatedAt,
      ];
}
