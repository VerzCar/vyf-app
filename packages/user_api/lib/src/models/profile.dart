import 'package:json_annotation/json_annotation.dart';

import 'date_time_converter.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final int id;
  final String bio;
  final String whyVoteMe;
  final String imageSrc;
  final String imagePlaceholderColors;
  @DateTimeConverter()
  final DateTime createdAt;
  @DateTimeConverter()
  final DateTime updatedAt;

  const Profile({
    required this.id,
    required this.bio,
    required this.whyVoteMe,
    required this.imageSrc,
    required this.imagePlaceholderColors,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

