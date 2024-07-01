import 'package:json_annotation/json_annotation.dart';

part 'user_private_option.g.dart';

@JsonSerializable()
class UserPrivateOption {
  final int maxVoters;
  final int maxCandidates;

  UserPrivateOption({
    required this.maxVoters,
    required this.maxCandidates,
  });

  factory UserPrivateOption.fromJson(Map<String, dynamic> json) =>
      _$UserPrivateOptionFromJson(json);

  Map<String, dynamic> toJson() => _$UserPrivateOptionToJson(this);
}
