// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      id: json['id'] as int,
      candidate: json['candidate'] as String,
      commitment: $enumDecode(_$CommitmentEnumMap, json['commitment']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'id': instance.id,
      'candidate': instance.candidate,
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$CommitmentEnumMap = {
  Commitment.open: 'OPEN',
  Commitment.committed: 'COMMITTED',
  Commitment.rejected: 'REJECTED',
};
