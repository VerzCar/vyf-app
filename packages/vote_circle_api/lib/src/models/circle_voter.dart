import 'package:json_annotation/json_annotation.dart';
import 'voter.dart';

part 'circle_voter.g.dart';

@JsonSerializable()
class CircleVoter {
  final List<Voter> voters;
  final Voter? userVoter;

  CircleVoter({
    required this.voters,
    this.userVoter,
  });

  factory CircleVoter.fromJson(Map<String, dynamic> json) => _$CircleVoterFromJson(json);

  Map<String, dynamic> toJson() => _$CircleVoterToJson(this);
}
