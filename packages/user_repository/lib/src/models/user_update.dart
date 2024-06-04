import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/profile_update.dart';
import 'package:user_api/user_api.dart' as user_api;

class UserUpdate extends Equatable {
  const UserUpdate({
    this.firstName,
    this.lastName,
    this.profile,
  });

  final String? firstName;
  final String? lastName;
  final ProfileUpdate? profile;

  user_api.UserUpdate toApiUserUpdate() => user_api.UserUpdate(
        firstName: firstName,
        lastName: lastName,
        profile: profile?.toApiProfileUpdate(),
      );

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        profile,
      ];
}
