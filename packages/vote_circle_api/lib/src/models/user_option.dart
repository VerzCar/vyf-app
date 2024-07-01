import 'package:json_annotation/json_annotation.dart';

import 'user_private_option.dart';

part 'user_option.g.dart';

@JsonSerializable()
class UserOption {
  final int maxCircles;
  final int maxVoters;
  final int maxCandidates;
  final UserPrivateOption privateOption;

  UserOption({
    required this.maxCircles,
    required this.maxVoters,
    required this.maxCandidates,
    required this.privateOption,
  });

  factory UserOption.fromJson(Map<String, dynamic> json) =>
      _$UserOptionFromJson(json);

  Map<String, dynamic> toJson() => _$UserOptionToJson(this);
}
