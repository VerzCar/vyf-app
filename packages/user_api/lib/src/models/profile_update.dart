import 'package:json_annotation/json_annotation.dart';

part 'profile_update.g.dart';

@JsonSerializable()
class ProfileUpdate {
  final String? bio;
  final String? whyVoteMe;
  final String? imageSrc;

  const ProfileUpdate({
    this.bio,
    this.whyVoteMe,
    this.imageSrc,
  });

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUpdateToJson(this);
}
