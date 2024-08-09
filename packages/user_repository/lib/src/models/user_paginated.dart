import 'package:equatable/equatable.dart';
import './profile_paginated.dart';
import 'package:user_api/user_api.dart' as user_api;

class UserPaginated extends Equatable {
  const UserPaginated({
    required this.id,
    required this.identityId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profile,
  });

  final int id;
  final String identityId;
  final String username;
  final String firstName;
  final String lastName;
  final ProfilePaginated profile;

  static const empty = UserPaginated(
    id: 0,
    identityId: '',
    username: '',
    firstName: '',
    lastName: '',
    profile: ProfilePaginated.empty,
  );

  String get displayName {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '$firstName $lastName';
    }

    if (firstName.isNotEmpty) {
      return firstName;
    }

    return username;
  }

  factory UserPaginated.fromApiUserPaginated(user_api.UserPaginated user) =>
      UserPaginated(
        id: user.id,
        identityId: user.identityId,
        username: user.username,
        firstName: user.firstName,
        lastName: user.lastName,
        profile: ProfilePaginated.fromApiProfilePaginated(user.profile),
      );

  @override
  List<Object> get props => [
        id,
        identityId,
        username,
        firstName,
        lastName,
        profile,
      ];
}
