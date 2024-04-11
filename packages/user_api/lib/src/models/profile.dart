import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  Profile({
    required this.id,
    required this.bio,
    required this.whyVoteMe,
    required this.imageSrc,
    required this.imagePlaceholderColors,
  });

  final int id;
  final String bio;
  final String whyVoteMe;
  final String imageSrc;
  final String imagePlaceholderColors;

  @override
  List<Object> get props => [
        id,
        bio,
        whyVoteMe,
        imageSrc,
        imagePlaceholderColors,
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
