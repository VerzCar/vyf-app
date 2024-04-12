import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;
import 'phone_number_country.dart';

class Contact extends Equatable {
  final int id;
  final String email;
  final String phoneNumber;
  final PhoneNumberCountry phoneNumberCountry;
  final String? phoneNumber2;
  final PhoneNumberCountry? phoneNumber2Country;
  final String web;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Contact({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.phoneNumberCountry,
    this.phoneNumber2,
    this.phoneNumber2Country,
    required this.web,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Contact.fromApiContact(user_api.Contact contact) => Contact(
        id: contact.id,
        email: contact.email,
        phoneNumber: contact.phoneNumber,
        phoneNumberCountry: PhoneNumberCountry.fromApiPhoneNumberCountry(
            contact.phoneNumberCountry),
        web: contact.web,
        createdAt: contact.createdAt,
        updatedAt: contact.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        phoneNumberCountry,
        phoneNumber2,
        phoneNumber2Country,
        web,
        createdAt,
        updatedAt,
      ];
}
