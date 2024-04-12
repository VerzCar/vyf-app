import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;
import 'package:user_repository/src/models/models.dart';
import 'country.dart';

class Address extends Equatable {
  final int id;
  final String address;
  final String city;
  final String postalCode;
  final Country country;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Address({
    required this.id,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromApiAddress(user_api.Address address) => Address(
        id: address.id,
        address: address.address,
        city: address.city,
        postalCode: address.postalCode,
        country: Country.fromApiCountry(address.country),
        createdAt: address.createdAt,
        updatedAt: address.updatedAt,
      );

  @override
  List<Object> get props => [
        id,
        address,
        city,
        postalCode,
        country,
        createdAt,
        updatedAt,
      ];
}
