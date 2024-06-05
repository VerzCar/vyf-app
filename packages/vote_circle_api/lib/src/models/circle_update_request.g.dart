// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleUpdateRequest _$CircleUpdateRequestFromJson(Map<String, dynamic> json) =>
    CircleUpdateRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      private: json['private'] as bool?,
      validFrom: _$JsonConverterFromJson<String, DateTime>(
          json['validFrom'], const DateTimeConverter().fromJson),
      validUntil: _$JsonConverterFromJson<String, DateTime>(
          json['validUntil'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$CircleUpdateRequestToJson(CircleUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('private', instance.private);
  writeNotNull(
      'validFrom',
      _$JsonConverterToJson<String, DateTime>(
          instance.validFrom, const DateTimeConverter().toJson));
  writeNotNull(
      'validUntil',
      _$JsonConverterToJson<String, DateTime>(
          instance.validUntil, const DateTimeConverter().toJson));
  return val;
}

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
