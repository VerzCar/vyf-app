import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;

class ProfileUpdate extends Equatable {
  final String? bio;
  final String? whyVoteMe;
  final String? imageSrc;

  const ProfileUpdate({
    this.bio,
    this.whyVoteMe,
    this.imageSrc,
  });

  user_api.ProfileUpdate toApiProfileUpdate() => user_api.ProfileUpdate(
        bio: bio,
        whyVoteMe: whyVoteMe,
        imageSrc: imageSrc,
      );

  @override
  List<Object?> get props => [
        bio,
        whyVoteMe,
        imageSrc,
      ];
}
