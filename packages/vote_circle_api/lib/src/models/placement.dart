import 'package:json_annotation/json_annotation.dart';

enum Placement {
  @JsonValue('NEUTRAL')
  neutral,
  @JsonValue('ASCENDING')
  ascending,
  @JsonValue('DESCENDING')
  descending,
}
