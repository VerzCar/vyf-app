import 'package:equatable/equatable.dart';
import 'package:vote_circle_repository/src/models/circle_paginated.dart';
import 'package:vote_circle_api/vote_circle_api.dart' as vote_circle_api;

class RankingLastViewed extends Equatable {
  final int id;
  final CirclePaginated circle;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RankingLastViewed({
    required this.id,
    required this.circle,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RankingLastViewed.fromApiRankingLastViewed(
    vote_circle_api.RankingLastViewed ranking,
  ) =>
      RankingLastViewed(
        id: ranking.id,
        circle: CirclePaginated.fromApiCirclePaginated(ranking.circle),
        createdAt: ranking.createdAt,
        updatedAt: ranking.updatedAt,
      );

  @override
  List<Object> get props => [
        id,
        circle,
        createdAt,
        updatedAt,
      ];
}
