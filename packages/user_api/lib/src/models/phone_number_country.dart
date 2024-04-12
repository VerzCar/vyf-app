import 'package:json_annotation/json_annotation.dart';

part 'phone_number_country.g.dart';

@JsonSerializable()
class PhoneNumberCountry {
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

  factory PhoneNumberCountry.fromJson(Map<String, dynamic> json) => _$PhoneNumberCountryFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberCountryToJson(this);
}
