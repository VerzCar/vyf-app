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

  RankingLastViewed copyWith({
    int? id,
    CirclePaginated? circle,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RankingLastViewed(
      id: id ?? this.id,
      circle: circle ?? this.circle,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

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
