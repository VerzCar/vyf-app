import 'package:json_annotation/json_annotation.dart';
import 'circle_stage.dart';

part 'circle.g.dart';

@JsonSerializable()
class Circle {
  final int id;
  final String name;
  final String description;
  final String imageSrc;
  final bool private;
  final bool active;
  final CircleStage stage;
  final String createdFrom;
  final DateTime validFrom;
  final DateTime? validUntil;
  final DateTime createdAt;
  final DateTime updatedAt;

  Circle({
    required this.id,
    required this.name,
    required this.description,
    required this.imageSrc,
    required this.private,
    required this.active,
    required this.stage,
    required this.createdFrom,
    required this.validFrom,
    this.validUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Circle.fromJson(Map<String, dynamic> json) => _$CircleFromJson(json);

  Map<String, dynamic> toJson() => _$CircleToJson(this);
}
