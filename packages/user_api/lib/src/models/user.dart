import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart';

class User extends Equatable {
  User({
    required this.id,
    required this.identityId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.profile,
    this.locale,
    this.address,
    this.contact,
  });

  final int id;
  final String identityId;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final Profile? profile;
  final Locale? locale;
  final Address? address;
  final Contact? contact;

  factory User.fromQuery(Query$user$user queryUser) {
    final Locale? locale = queryUser.locale != null
        ? Locale(
            id: queryUser.locale!.id,
            lcidString: queryUser.locale!.lcidString,
            languageCode: queryUser.locale!.languageCode,
          )
        : null;

    final Profile? profile = queryUser.profile != null
        ? Profile(
            id: queryUser.profile!.id,
            bio: queryUser.profile!.bio,
            whyVoteMe: queryUser.profile!.whyVoteMe,
            imageSrc: queryUser.profile!.imageSrc,
            imagePlaceholderColors: queryUser.profile!.imagePlaceholderColors,
          )
        : null;

    final Contact? contact = queryUser.contact != null
        ? Contact(
            id: queryUser.contact!.id,
            phoneNumber: queryUser.contact!.phoneNumber,
            phoneNumber2: queryUser.contact!.phoneNumber2,
            web: queryUser.contact!.web,
            email: queryUser.contact!.email,
          )
        : null;

    final Address? address = queryUser.address != null
        ? Address(
            id: queryUser.address!.id,
            address: queryUser.address!.address,
            city: queryUser.address!.city,
            postalCode: queryUser.address!.postalCode,
            country: Country(
              id: queryUser.address!.country.id,
              name: queryUser.address!.country.name,
              alpha2: queryUser.address!.country.alpha2,
            ),
          )
        : null;

    return User(
      id: queryUser.id,
      identityId: queryUser.identityId,
      username: queryUser.username ?? '',
      firstName: queryUser.firstName ?? '',
      lastName: queryUser.lastName ?? '',
      gender: queryUser.gender.toString(),
      profile: profile,
      locale: locale,
      address: address,
      contact: contact,
    );
  }

  @override
  List<Object?> get props => [
        id,
        identityId,
        username,
        firstName,
        lastName,
        gender,
        profile,
        locale,
        address,
        contact,
      ];
}

class UpdateUserInput {
  UpdateUserInput({
    required this.profile,
  });

  final ProfileInput profile;
}
