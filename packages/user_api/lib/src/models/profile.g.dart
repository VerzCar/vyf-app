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
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'whyVoteMe': instance.whyVoteMe,
      'imageSrc': instance.imageSrc,
      'imagePlaceholderColors': instance.imagePlaceholderColors,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
