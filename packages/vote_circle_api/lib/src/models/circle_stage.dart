import 'package:json_annotation/json_annotation.dart';

enum CircleStage {
  @JsonValue('COLD')
  Cold,
  @JsonValue('HOT')
  Hot,
  @JsonValue('CLOSED')
  Closed,
}

