import 'package:equatable/equatable.dart';
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
