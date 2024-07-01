// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOption _$UserOptionFromJson(Map<String, dynamic> json) => UserOption(
      maxCircles: json['maxCircles'] as int,
      maxVoters: json['maxVoters'] as int,
      maxCandidates: json['maxCandidates'] as int,
      privateOption: UserPrivateOption.fromJson(
          json['privateOption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserOptionToJson(UserOption instance) =>
    <String, dynamic>{
      'maxCircles': instance.maxCircles,
      'maxVoters': instance.maxVoters,
      'maxCandidates': instance.maxCandidates,
      'privateOption': instance.privateOption,
    };
