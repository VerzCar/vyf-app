// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileUpdate _$ProfileUpdateFromJson(Map<String, dynamic> json) =>
    ProfileUpdate(
      bio: json['bio'] as String?,
      whyVoteMe: json['whyVoteMe'] as String?,
      imageSrc: json['imageSrc'] as String?,
    );

Map<String, dynamic> _$ProfileUpdateToJson(ProfileUpdate instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'whyVoteMe': instance.whyVoteMe,
      'imageSrc': instance.imageSrc,
    };
