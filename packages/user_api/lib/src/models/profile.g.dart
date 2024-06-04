// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int,
      bio: json['bio'] as String,
      whyVoteMe: json['whyVoteMe'] as String,
      imageSrc: json['imageSrc'] as String,
      imagePlaceholderColors: json['imagePlaceholderColors'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'whyVoteMe': instance.whyVoteMe,
      'imageSrc': instance.imageSrc,
      'imagePlaceholderColors': instance.imagePlaceholderColors,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
