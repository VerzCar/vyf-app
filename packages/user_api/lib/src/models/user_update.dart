import 'package:json_annotation/json_annotation.dart';
import 'package:user_api/user_api.dart';

part 'user_update.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UserUpdate {
  const UserUpdate({
    this.firstName,
    this.lastName,
    this.profile,
  });

  final String? firstName;
  final String? lastName;
  final ProfileUpdate? profile;

  factory UserUpdate.fromJson(Map<String, dynamic> json) => _$UserUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateToJson(this);
}
