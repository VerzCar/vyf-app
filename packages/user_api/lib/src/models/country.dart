import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
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

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
