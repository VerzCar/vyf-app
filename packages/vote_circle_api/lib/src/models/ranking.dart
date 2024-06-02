import 'package:json_annotation/json_annotation.dart';
import 'date_time_converter.dart';
import 'placement.dart';

part 'ranking.g.dart';

@JsonSerializable()
class Ranking {
  final int id;
  final int candidateId;
  final String identityId;
  final int number;
  final int votes;
  final int indexedOrder;
  final Placement placement;
  final int circleId;
  @DateTimeConverter()
  final DateTime createdAt;
  @DateTimeConverter()
  final DateTime updatedAt;

  Ranking({
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

  factory Ranking.fromJson(Map<String, dynamic> json) => _$RankingFromJson(json);

  Map<String, dynamic> toJson() => _$RankingToJson(this);
}
