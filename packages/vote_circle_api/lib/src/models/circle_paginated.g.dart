// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CirclePaginated _$CirclePaginatedFromJson(Map<String, dynamic> json) =>
    CirclePaginated(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageSrc: json['imageSrc'] as String,
      votersCount: json['votersCount'] as int?,
      candidatesCount: json['candidatesCount'] as int?,
      active: json['active'] as bool,
      stage: $enumDecode(_$CircleStageEnumMap, json['stage']),
    );

Map<String, dynamic> _$CirclePaginatedToJson(CirclePaginated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageSrc': instance.imageSrc,
      'votersCount': instance.votersCount,
      'candidatesCount': instance.candidatesCount,
      'active': instance.active,
      'stage': _$CircleStageEnumMap[instance.stage]!,
    };

const _$CircleStageEnumMap = {
  CircleStage.Cold: 'COLD',
  CircleStage.Hot: 'HOT',
  CircleStage.Closed: 'CLOSED',
};
