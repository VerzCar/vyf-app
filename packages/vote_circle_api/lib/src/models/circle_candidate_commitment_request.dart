import 'package:json_annotation/json_annotation.dart';
import 'package:vote_circle_api/src/models/commitment.dart';

part 'circle_candidate_commitment_request.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CircleCandidateCommitmentRequest {
  final Commitment commitment;

  CircleCandidateCommitmentRequest({
    required this.commitment,
  });

  factory CircleCandidateCommitmentRequest.fromJson(
          Map<String, dynamic> json) =>
      _$CircleCandidateCommitmentRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CircleCandidateCommitmentRequestToJson(this);
}
