import 'package:json_annotation/json_annotation.dart';
import 'circle_stage.dart';

part 'circle_paginated.g.dart';

@JsonSerializable()
class CirclePaginated {
  final int id;
  final String name;
  final String description;
  final String imageSrc;
  final int? votersCount;
  final int? candidatesCount;
  final bool active;
  final CircleStage stage;

  CirclePaginated({
    required this.id,
    required this.name,
    required this.description,
    required this.imageSrc,
    this.votersCount,
    this.candidatesCount,
    required this.active,
    required this.stage,
  });

  factory CirclePaginated.fromJson(Map<String, dynamic> json) =>
      _$CirclePaginatedFromJson(json);

  Map<String, dynamic> toJson() => _$CirclePaginatedToJson(this);
}
