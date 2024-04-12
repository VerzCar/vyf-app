import 'package:json_annotation/json_annotation.dart';

enum Commitment {
  @JsonValue('OPEN')
  open,
  @JsonValue('COMMITTED')
  committed,
  @JsonValue('REJECTED')
  rejected,
}
