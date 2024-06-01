import 'package:json_annotation/json_annotation.dart';

part 'voter_request.g.dart';

@JsonSerializable()
class VoterRequest {
  final String voter;

  VoterRequest({
    required this.voter,
  });

  factory VoterRequest.fromJson(Map<String, dynamic> json) =>
      _$VoterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoterRequestToJson(this);
}
