// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_paginated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPaginated _$UserPaginatedFromJson(Map<String, dynamic> json) =>
    UserPaginated(
      id: json['id'] as int,
      identityId: json['identityId'] as String,
      username: json['username'] as String,
      profile:
          ProfilePaginated.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserPaginatedToJson(UserPaginated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identityId': instance.identityId,
      'username': instance.username,
      'profile': instance.profile,
    };
