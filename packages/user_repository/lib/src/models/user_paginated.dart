import 'package:equatable/equatable.dart';
import './profile_paginated.dart';
import 'package:user_api/user_api.dart' as user_api;

class UserPaginated extends Equatable {
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

  factory UserPaginated.fromApiUserPaginated(user_api.UserPaginated user) =>
      UserPaginated(
        id: user.id,
        identityId: user.identityId,
        username: user.username,
        profile: ProfilePaginated.fromApiProfilePaginated(user.profile),
      );

  @override
  List<Object> get props => [
        id,
        identityId,
        username,
        profile,
      ];
}
