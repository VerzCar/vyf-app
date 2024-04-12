import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;

class PhoneNumberCountry extends Equatable {
  final int id;
  final String name;
  final String alpha2;
  final String alpha3;
  final String continentCode;
  final String number;
  final String fullName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PhoneNumberCountry({
    required this.id,
    required this.name,
    required this.alpha2,
    required this.alpha3,
    required this.continentCode,
    required this.number,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PhoneNumberCountry.fromApiPhoneNumberCountry(user_api.PhoneNumberCountry ph) =>
      PhoneNumberCountry(
        id: ph.id,
        name: ph.name,
        alpha2: ph.alpha2,
        alpha3: ph.alpha3,
        continentCode: ph.continentCode,
        number: ph.number,
        fullName: ph.fullName,
        createdAt: ph.createdAt,
        updatedAt: ph.updatedAt,
      );

  @override
  List<Object> get props => [
        id,
        name,
        alpha2,
        alpha3,
        continentCode,
        number,
        fullName,
        createdAt,
        updatedAt,
      ];
}
