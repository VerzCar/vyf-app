import 'package:equatable/equatable.dart';
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

  @override
  List<Object> get props => [
    id,
    candidate,
    commitment,
    createdAt,
    updatedAt,
  ];
}
