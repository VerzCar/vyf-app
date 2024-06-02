// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CircleCreateRequest _$CircleCreateRequestFromJson(Map<String, dynamic> json) =>
    CircleCreateRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      imageSrc: json['imageSrc'] as String?,
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => CandidateRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      voters: (json['voters'] as List<dynamic>)
          .map((e) => VoterRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      private: json['private'] as bool?,
      validFrom: _$JsonConverterFromJson<String, DateTime>(
          json['validFrom'], const DateTimeConverter().fromJson),
      validUntil: _$JsonConverterFromJson<String, DateTime>(
          json['validUntil'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$CircleCreateRequestToJson(CircleCreateRequest instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('imageSrc', instance.imageSrc);
  val['candidates'] = instance.candidates.map((e) => e.toJson()).toList();
  val['voters'] = instance.voters.map((e) => e.toJson()).toList();
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
