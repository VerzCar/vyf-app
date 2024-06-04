import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/presentation/settings/models/models.dart';

part 'user_edit_profile_state.dart';

class UserEditProfileCubit extends Cubit<UserEditProfileState> {
  UserEditProfileCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserEditProfileState());

  final IUserRepository _userRepository;

  void onFirstNameChanged(String value) {
    final input = FirstNameInput.dirty(value: value);
    emit(state.copyWith(
      firstName: input,
    ));
  }

  void onLastNameChanged(String value) {
    final input = LastNameInput.dirty(value: value);
    emit(state.copyWith(
      lastName: input,
    ));
  }

  void onBioChanged(String value) {
    final input = BioInput.dirty(value: value);
    emit(state.copyWith(
      bio: input,
    ));
  }

  void onWhyVoteMeChanged(String value) {
    final input = WhyVoteMeInput.dirty(value: value);
    emit(state.copyWith(
      whyVoteMe: input,
    ));
  }

  void onSubmit() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    try {
      final request = UserUpdate(
          firstName: state.firstName.isPure ? null : state.firstName.value,
          lastName: state.lastName.isPure ? null : state.lastName.value,
          profile: ProfileUpdate(
            bio: state.bio.isPure ? null : state.bio.value,
            whyVoteMe: state.whyVoteMe.isPure ? null : state.whyVoteMe.value,
          ));

      final user = await _userRepository.updateUser(request);

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        updatedUser: user,
      ));
    } catch (e) {
      print(e);
      if (isClosed) return;
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
