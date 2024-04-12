import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final int id;
  final String bio;
  final String whyVoteMe;
  final String imageSrc;
  final String imagePlaceholderColors;
  final DateTime createdAt;
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

class ProfileInput {
  ProfileInput({
    this.bio,
    this.whyVoteMe,
    this.imageSrc,
  });

  final String? bio;
  final String? whyVoteMe;
  final String? imageSrc;
}
