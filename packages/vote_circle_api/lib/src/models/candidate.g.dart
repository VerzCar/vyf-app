// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      id: json['id'] as int,
      candidate: json['candidate'] as String,
      commitment: $enumDecode(_$CommitmentEnumMap, json['commitment']),
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'id': instance.id,
      'candidate': instance.candidate,
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

const _$CommitmentEnumMap = {
  Commitment.open: 'OPEN',
  Commitment.committed: 'COMMITTED',
  Commitment.rejected: 'REJECTED',
};
