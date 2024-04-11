// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['id'] as int,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      phoneNumberCountry: PhoneNumberCountry.fromJson(
          json['phoneNumberCountry'] as Map<String, dynamic>),
      phoneNumber2: json['phoneNumber2'] as String?,
      phoneNumber2Country: json['phoneNumber2Country'] == null
          ? null
          : PhoneNumberCountry.fromJson(
              json['phoneNumber2Country'] as Map<String, dynamic>),
      web: json['web'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberCountry': instance.phoneNumberCountry,
      'phoneNumber2': instance.phoneNumber2,
      'phoneNumber2Country': instance.phoneNumber2Country,
      'web': instance.web,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
