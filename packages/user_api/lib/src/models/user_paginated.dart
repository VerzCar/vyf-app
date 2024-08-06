import 'package:json_annotation/json_annotation.dart';
import '../models/profile_paginated.dart';

part 'user_paginated.g.dart';

@JsonSerializable()
class UserPaginated {
  const UserPaginated({
    required this.id,
    required this.identityId,
    required this.username,
    required this.profile,
  });

  final int id;
  final String identityId;
  final String username;
  final ProfilePaginated profile;

  factory UserPaginated.fromJson(Map<String, dynamic> json) =>
      _$UserPaginatedFromJson(json);

  Map<String, dynamic> toJson() => _$UserPaginatedToJson(this);
}
