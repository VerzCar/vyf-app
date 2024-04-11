import 'package:equatable/equatable.dart';

class Address extends Equatable {
  Address({
    required this.id,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
  });

  final int id;
  final String address;
  final String city;
  final String postalCode;
  final Country country;

  @override
  List<Object> get props => [
        id,
        address,
        city,
        postalCode,
        country,
      ];
}

class Country extends Equatable {
  Country({
    required this.id,
    required this.name,
    required this.alpha2,
  });

  final int id;
  final String name;
  final String alpha2;

  @override
  List<Object> get props => [
        id,
        name,
        alpha2,
      ];
}
