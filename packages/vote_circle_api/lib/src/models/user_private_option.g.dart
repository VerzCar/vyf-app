// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_private_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPrivateOption _$UserPrivateOptionFromJson(Map<String, dynamic> json) =>
    UserPrivateOption(
      maxVoters: json['maxVoters'] as int,
      maxCandidates: json['maxCandidates'] as int,
    );

Map<String, dynamic> _$UserPrivateOptionToJson(UserPrivateOption instance) =>
    <String, dynamic>{
      'maxVoters': instance.maxVoters,
      'maxCandidates': instance.maxCandidates,
    };
