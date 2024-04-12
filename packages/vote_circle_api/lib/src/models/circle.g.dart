// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Circle _$CircleFromJson(Map<String, dynamic> json) => Circle(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageSrc: json['imageSrc'] as String,
      private: json['private'] as bool,
      active: json['active'] as bool,
      stage: $enumDecode(_$CircleStageEnumMap, json['stage']),
      createdFrom: json['createdFrom'] as String,
      validFrom: DateTime.parse(json['validFrom'] as String),
      validUntil: json['validUntil'] == null
          ? null
          : DateTime.parse(json['validUntil'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CircleToJson(Circle instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageSrc': instance.imageSrc,
      'private': instance.private,
      'active': instance.active,
      'stage': _$CircleStageEnumMap[instance.stage]!,
      'createdFrom': instance.createdFrom,
      'validFrom': instance.validFrom.toIso8601String(),
      'validUntil': instance.validUntil?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$CircleStageEnumMap = {
  CircleStage.Cold: 'COLD',
  CircleStage.Hot: 'HOT',
  CircleStage.Closed: 'CLOSED',
};
