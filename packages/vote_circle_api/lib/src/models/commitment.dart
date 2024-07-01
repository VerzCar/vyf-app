import 'package:json_annotation/json_annotation.dart';

enum Commitment {
  @JsonValue('OPEN')
  open,
  @JsonValue('COMMITTED')
  committed,
  @JsonValue('REJECTED')
  rejected,
}

// ignore: constant_identifier_names
const Map<String, Commitment> CommitmentEnumMap = {
  'OPEN': Commitment.open,
  'COMMITTED': Commitment.committed,
  'REJECTED': Commitment.rejected,
};
