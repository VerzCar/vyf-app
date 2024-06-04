import 'package:json_annotation/json_annotation.dart';
import 'country.dart';
import 'date_time_converter.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  final String address;
  final String city;
  final String postalCode;
  final Country country;
  @DateTimeConverter()
  final DateTime createdAt;
  @DateTimeConverter()
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

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

}
