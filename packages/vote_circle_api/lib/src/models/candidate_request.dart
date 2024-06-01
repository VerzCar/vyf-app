import 'package:json_annotation/json_annotation.dart';

part 'candidate_request.g.dart';

@JsonSerializable()
class CandidateRequest {
  final String candidate;

  CandidateRequest({
    required this.candidate,
  });

  factory CandidateRequest.fromJson(Map<String, dynamic> json) =>
      _$CandidateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateRequestToJson(this);
}
