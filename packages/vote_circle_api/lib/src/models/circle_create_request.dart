import 'package:json_annotation/json_annotation.dart';
import 'voter_request.dart';
import 'candidate_request.dart';

part 'circle_create_request.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CircleCreateRequest {
  final String name;
  final String? description;
  final String? imageSrc;
  final List<CandidateRequest> candidates;
  final List<VoterRequest> voters;
  final bool? private;
  final DateTime? validFrom;
  final DateTime? validUntil;

  CircleCreateRequest({
    required this.name,
    this.description,
    this.imageSrc,
    required this.candidates,
    required this.voters,
    this.private,
    this.validFrom,
    this.validUntil,
  });

  factory CircleCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CircleCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CircleCreateRequestToJson(this);
}
