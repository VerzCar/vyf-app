import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;

class ProfilePaginated extends Equatable {
  final String imageSrc;

  const ProfilePaginated({
    required this.imageSrc,
  });

  factory ProfilePaginated.fromApiProfilePaginated(
          user_api.ProfilePaginated profile) =>
      ProfilePaginated(
        imageSrc: profile.imageSrc,
      );

  @override
  List<Object> get props => [
        imageSrc,
      ];
}
