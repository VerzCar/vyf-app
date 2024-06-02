// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ranking _$RankingFromJson(Map<String, dynamic> json) => Ranking(
      id: json['id'] as int,
      candidateId: json['candidateId'] as int,
      identityId: json['identityId'] as String,
      number: json['number'] as int,
      votes: json['votes'] as int,
      indexedOrder: json['indexedOrder'] as int,
      placement: $enumDecode(_$PlacementEnumMap, json['placement']),
      circleId: json['circleId'] as int,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
      'id': instance.id,
      'candidateId': instance.candidateId,
      'identityId': instance.identityId,
      'number': instance.number,
      'votes': instance.votes,
      'indexedOrder': instance.indexedOrder,
      'placement': _$PlacementEnumMap[instance.placement]!,
      'circleId': instance.circleId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

const _$PlacementEnumMap = {
  Placement.neutral: 'NEUTRAL',
  Placement.ascending: 'ASCENDING',
  Placement.descending: 'DESCENDING',
};
