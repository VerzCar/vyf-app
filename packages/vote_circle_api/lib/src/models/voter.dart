import 'package:json_annotation/json_annotation.dart';
import 'commitment.dart';
import 'date_time_converter.dart';

part 'voter.g.dart';

@JsonSerializable()
class Voter {
  final int id;
  final String voter;
  final Commitment commitment;
  final String? votedFor;
  @DateTimeConverter()
  final DateTime createdAt;
  @DateTimeConverter()
  final DateTime updatedAt;

  Voter({
    required this.id,
    required this.voter,
    required this.commitment,
    this.votedFor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Voter.fromJson(Map<String, dynamic> json) => _$VoterFromJson(json);

  Map<String, dynamic> toJson() => _$VoterToJson(this);
}
