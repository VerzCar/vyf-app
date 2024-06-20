import 'package:json_annotation/json_annotation.dart';

enum CircleStage {
  @JsonValue('COLD')
  cold,
  @JsonValue('HOT')
  hot,
  @JsonValue('CLOSED')
  closed,
}

