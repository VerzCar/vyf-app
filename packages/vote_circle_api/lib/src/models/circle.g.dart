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
      validFrom:
          const DateTimeConverter().fromJson(json['validFrom'] as String),
      validUntil: _$JsonConverterFromJson<String, DateTime>(
          json['validUntil'], const DateTimeConverter().fromJson),
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as String),
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
      'validFrom': const DateTimeConverter().toJson(instance.validFrom),
      'validUntil': _$JsonConverterToJson<String, DateTime>(
          instance.validUntil, const DateTimeConverter().toJson),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };

const _$CircleStageEnumMap = {
  CircleStage.Cold: 'COLD',
  CircleStage.Hot: 'HOT',
  CircleStage.Closed: 'CLOSED',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
