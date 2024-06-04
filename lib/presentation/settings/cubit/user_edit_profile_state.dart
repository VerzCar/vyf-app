part of 'user_edit_profile_cubit.dart';

final class UserEditProfileState extends Equatable {
  const UserEditProfileState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const FirstNameInput.pure(),
    this.lastName = const LastNameInput.pure(),
    this.bio = const BioInput.pure(),
    this.whyVoteMe = const WhyVoteMeInput.pure(),
    this.updatedUser,
  });

  final FormzSubmissionStatus status;
  final FirstNameInput firstName;
  final LastNameInput lastName;
  final BioInput bio;
  final WhyVoteMeInput whyVoteMe;
  final User? updatedUser;

  UserEditProfileState copyWith({
    FormzSubmissionStatus? status,
    FirstNameInput? firstName,
    LastNameInput? lastName,
    BioInput? bio,
    WhyVoteMeInput? whyVoteMe,
    User? updatedUser,
  }) {
    return UserEditProfileState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      whyVoteMe: whyVoteMe ?? this.whyVoteMe,
      updatedUser: updatedUser ?? this.updatedUser,
    );
  }

  @override
  List<Object?> get props => [
        status,
        firstName,
        lastName,
        bio,
        whyVoteMe,
        updatedUser,
      ];
}
