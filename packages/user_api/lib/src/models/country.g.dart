// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as int,
      name: json['name'] as String,
      alpha2: json['alpha2'] as String,
      alpha3: json['alpha3'] as String,
      continentCode: json['continentCode'] as String,
      number: json['number'] as String,
      fullName: json['fullName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alpha2': instance.alpha2,
      'alpha3': instance.alpha3,
      'continentCode': instance.continentCode,
      'number': instance.number,
      'fullName': instance.fullName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
