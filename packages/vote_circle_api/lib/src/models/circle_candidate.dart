import 'package:json_annotation/json_annotation.dart';
import 'candidate.dart';

part 'circle_candidate.g.dart';

@JsonSerializable()
class CircleCandidate {
  final List<Candidate> candidates;
  final Candidate? userCandidate;

  CircleCandidate({
    required this.candidates,
    this.userCandidate,
  });

  factory CircleCandidate.fromJson(Map<String, dynamic> json) => _$CircleCandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CircleCandidateToJson(this);
}
