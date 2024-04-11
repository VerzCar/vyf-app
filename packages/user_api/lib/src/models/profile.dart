import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  final int id;
  final String bio;
  final String whyVoteMe;
  final String imageSrc;
  final String imagePlaceholderColors;
  final DateTime createdAt;
  final DateTime updatedAt;

  Profile({
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

  @override
  List<Object> get props => [
        id,
        bio,
        whyVoteMe,
        imageSrc,
        imagePlaceholderColors,
        createdAt,
        updatedAt,
      ];
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
