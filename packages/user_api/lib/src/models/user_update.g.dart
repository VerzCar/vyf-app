// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdate _$UserUpdateFromJson(Map<String, dynamic> json) => UserUpdate(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profile: json['profile'] == null
          ? null
          : ProfileUpdate.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserUpdateToJson(UserUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('profile', instance.profile?.toJson());
  return val;
}
