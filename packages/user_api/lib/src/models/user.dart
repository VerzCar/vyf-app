import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_api/user_api.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.identityId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.address,
    this.contact,
    required this.profile,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String identityId;
  final String username;
  final String firstName;
  final String lastName;
  final Gender gender;
  final Address? address;
  final Contact? contact;
  final Profile profile;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        identityId,
        username,
        firstName,
        lastName,
        gender,
        profile,
        address,
        contact,
        createdAt,
        updatedAt
      ];
}

class UpdateUserInput {
  UpdateUserInput({
    required this.profile,
  });

  final ProfileInput profile;
}
