import 'package:json_annotation/json_annotation.dart';

part 'profile_paginated.g.dart';

@JsonSerializable()
class ProfilePaginated {
  final String imageSrc;

  const ProfilePaginated({
    required this.imageSrc,
  });

  factory ProfilePaginated.fromJson(Map<String, dynamic> json) =>
      _$ProfilePaginatedFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePaginatedToJson(this);
}
