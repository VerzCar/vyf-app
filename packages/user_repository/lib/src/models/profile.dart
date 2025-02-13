import 'package:const_date_time/const_date_time.dart';
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

  static const empty = Profile(
    id: 0,
    bio: '',
    whyVoteMe: '',
    imageSrc: '',
    imagePlaceholderColors: '',
    createdAt: ConstDateTime(2024),
    updatedAt: ConstDateTime(2024),
  );

  bool get isEmpty => this == Profile.empty;

  Profile copyWith({
    int? id,
    String? bio,
    String? whyVoteMe,
    String? imageSrc,
    String? imagePlaceholderColors,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      bio: bio ?? this.bio,
      whyVoteMe: whyVoteMe ?? this.whyVoteMe,
      imageSrc: imageSrc ?? this.imageSrc,
      imagePlaceholderColors:
          imagePlaceholderColors ?? this.imagePlaceholderColors,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

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
