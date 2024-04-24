import 'package:equatable/equatable.dart';
import 'placement.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

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

  factory Ranking.fromApiRanking(vote_circle_api.Ranking ranking) => Ranking(
        id: ranking.id,
        candidateId: ranking.candidateId,
        identityId: ranking.identityId,
        number: ranking.number,
        votes: ranking.votes,
        indexedOrder: ranking.indexedOrder,
        placement: placementFromApiPlacement(ranking.placement),
        circleId: ranking.circleId,
        createdAt: ranking.createdAt,
        updatedAt: ranking.updatedAt,
      );

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
