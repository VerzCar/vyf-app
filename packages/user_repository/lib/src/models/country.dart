import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;

class Country extends Equatable {
  final int id;
  final String name;
  final String alpha2;
  final String alpha3;
  final String continentCode;
  final String number;
  final String fullName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Country({
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

  factory Country.fromApiCountry(user_api.Country country) => Country(
        id: country.id,
        name: country.name,
        alpha2: country.alpha2,
        alpha3: country.alpha3,
        continentCode: country.continentCode,
        number: country.number,
        fullName: country.fullName,
        createdAt: country.createdAt,
        updatedAt: country.updatedAt,
      );

  user_api.Country toApiCountry() => user_api.Country(
        id: id,
        name: name,
        alpha2: alpha2,
        alpha3: alpha3,
        continentCode: continentCode,
        number: number,
        fullName: fullName,
        createdAt: createdAt,
        updatedAt: updatedAt,
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
