import 'package:equatable/equatable.dart';
import 'placement.dart';

class Ranking extends Equatable {
  final int id;
  final int candidateId;
  final String identityId;
  final int number;
  final int votes;
  final int indexedOrder;
  final Placement placement;
  final int circleId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Ranking({
    required this.id,
    required this.candidateId,
    required this.identityId,
    required this.number,
    required this.votes,
    required this.indexedOrder,
    required this.placement,
    required this.circleId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        candidateId,
        identityId,
        number,
        votes,
        indexedOrder,
        placement,
        circleId,
        createdAt,
        updatedAt,
      ];
}
