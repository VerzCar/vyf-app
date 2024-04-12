// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voter _$VoterFromJson(Map<String, dynamic> json) => Voter(
      id: json['id'] as int,
      voter: json['voter'] as String,
      commitment: $enumDecode(_$CommitmentEnumMap, json['commitment']),
      votedFor: json['votedFor'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$VoterToJson(Voter instance) => <String, dynamic>{
      'id': instance.id,
      'voter': instance.voter,
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
      'votedFor': instance.votedFor,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$CommitmentEnumMap = {
  Commitment.open: 'OPEN',
  Commitment.committed: 'COMMITTED',
  Commitment.rejected: 'REJECTED',
};
