// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_last_viewed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingLastViewed _$RankingLastViewedFromJson(Map<String, dynamic> json) =>
    RankingLastViewed(
      id: json['id'] as int,
      circle: CirclePaginated.fromJson(json['circle'] as Map<String, dynamic>),
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      updatedAt:
          const DateTimeConverter().fromJson(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RankingLastViewedToJson(RankingLastViewed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'circle': instance.circle,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
