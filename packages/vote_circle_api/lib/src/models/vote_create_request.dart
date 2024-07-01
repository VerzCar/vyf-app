import 'package:json_annotation/json_annotation.dart';

part 'vote_create_request.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class VoteCreateRequest {
  final String candidateId;

  VoteCreateRequest({
    required this.candidateId,
  });

  factory VoteCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$VoteCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoteCreateRequestToJson(this);
}
