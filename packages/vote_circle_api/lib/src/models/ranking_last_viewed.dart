import 'package:json_annotation/json_annotation.dart';
import 'package:vote_circle_api/src/models/circle_paginated.dart';
import 'date_time_converter.dart';

part 'ranking_last_viewed.g.dart';

@JsonSerializable()
class RankingLastViewed {
  final int id;
  final CirclePaginated circle;
  @DateTimeConverter()
  final DateTime createdAt;
  @DateTimeConverter()
  final DateTime updatedAt;

  RankingLastViewed({
    required this.id,
    required this.circle,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RankingLastViewed.fromJson(Map<String, dynamic> json) =>
      _$RankingLastViewedFromJson(json);

  Map<String, dynamic> toJson() => _$RankingLastViewedToJson(this);
}
