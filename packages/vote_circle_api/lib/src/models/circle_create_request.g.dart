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
      validFrom: json['validFrom'] == null
          ? null
          : DateTime.parse(json['validFrom'] as String),
      validUntil: json['validUntil'] == null
          ? null
          : DateTime.parse(json['validUntil'] as String),
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
  writeNotNull('validFrom', instance.validFrom?.toIso8601String());
  writeNotNull('validUntil', instance.validUntil?.toIso8601String());
  return val;
}
