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
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as String),
    );

Map<String, dynamic> _$VoterToJson(Voter instance) => <String, dynamic>{
      'id': instance.id,
      'voter': instance.voter,
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
      'votedFor': instance.votedFor,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

const _$CommitmentEnumMap = {
  Commitment.open: 'OPEN',
  Commitment.committed: 'COMMITTED',
  Commitment.rejected: 'REJECTED',
};
