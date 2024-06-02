import 'package:json_annotation/json_annotation.dart';
import 'commitment.dart';
import 'date_time_converter.dart';

part 'candidate.g.dart';

@JsonSerializable()
class Candidate {
  final int id;
  final String candidate;
  final Commitment commitment;
  @DateTimeConverter()
  final DateTime createdAt;
  @DateTimeConverter()
  final DateTime updatedAt;

  Candidate({
    required this.id,
    required this.candidate,
    required this.commitment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}
