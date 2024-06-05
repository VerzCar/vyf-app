import 'package:json_annotation/json_annotation.dart';
import 'package:user_api/user_api.dart';

import 'date_time_converter.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
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
    @DateTimeConverter()
    required this.createdAt,
    @DateTimeConverter()
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
}
