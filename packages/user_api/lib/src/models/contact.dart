import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'phone_number_country.dart';

part 'contact.g.dart';

@JsonSerializable()
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

  Contact({
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

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

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


