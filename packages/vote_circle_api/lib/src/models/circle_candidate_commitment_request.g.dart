// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_candidate_commitment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleCandidateCommitmentRequest _$CircleCandidateCommitmentRequestFromJson(
        Map<String, dynamic> json) =>
    CircleCandidateCommitmentRequest(
      commitment: $enumDecode(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$CircleCandidateCommitmentRequestToJson(
        CircleCandidateCommitmentRequest instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
    };

const _$CommitmentEnumMap = {
  Commitment.open: 'OPEN',
  Commitment.committed: 'COMMITTED',
  Commitment.rejected: 'REJECTED',
};
