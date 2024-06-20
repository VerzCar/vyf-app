import 'package:equatable/equatable.dart';
import 'package:const_date_time/const_date_time.dart';
import 'address.dart';
import 'contact.dart';
import 'gender.dart';
import 'profile.dart';
import 'package:user_api/user_api.dart' as user_api;

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

  static const empty = User(
    id: 0,
    identityId: '',
    username: '',
    firstName: '',
    lastName: '',
    gender: Gender.x,
    profile: Profile.empty,
    createdAt: ConstDateTime(2024),
    updatedAt: ConstDateTime(2024),
  );

  bool get isEmpty => this == User.empty;

  factory User.fromApiUser(user_api.User user) => User(
        id: user.id,
        identityId: user.identityId,
        username: user.username,
        firstName: user.firstName,
        lastName: user.lastName,
        gender: genderFromApiGender(user.gender),
        address:
            user.address != null ? Address.fromApiAddress(user.address!) : null,
        contact:
            user.contact != null ? Contact.fromApiContact(user.contact!) : null,
        profile: Profile.fromApiProfile(user.profile),
        createdAt: user.createdAt,
        updatedAt: user.updatedAt,
      );

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
