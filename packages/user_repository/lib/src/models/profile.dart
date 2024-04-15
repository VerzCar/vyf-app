import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart' as user_api;

class Profile extends Equatable {
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

  static final empty = Profile(
    id: 0,
    bio: '',
    whyVoteMe: '',
    imageSrc: '',
    imagePlaceholderColors: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  bool get isEmpty => this == Profile.empty;

  factory Profile.fromApiProfile(user_api.Profile profile) => Profile(
        id: profile.id,
        bio: profile.bio,
        whyVoteMe: profile.whyVoteMe,
        imageSrc: profile.imageSrc,
        imagePlaceholderColors: profile.imagePlaceholderColors,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
      );

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
