part of 'user_edit_profile_cubit.dart';

final class UserEditProfileState extends Equatable {
  const UserEditProfileState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const FirstNameInput.pure(),
});

  final FormzSubmissionStatus status;
  final FirstNameInput firstName;

  UserEditProfileState copyWith({
    FormzSubmissionStatus? status,
    FirstNameInput? firstName,
  }) {
    return UserEditProfileState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
    );
  }

  @override
  List<Object?> get props => [
    status,
    firstName,
  ];
}
