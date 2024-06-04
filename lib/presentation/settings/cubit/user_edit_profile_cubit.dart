import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/presentation/settings/models/models.dart';

part 'user_edit_profile_state.dart';

class UserEditProfileCubit extends Cubit<UserEditProfileState> {
  UserEditProfileCubit({
    required IUserRepository userRepository,
}) : _userRepository = userRepository,
        super(const UserEditProfileState());

  final IUserRepository _userRepository;

  void onFirstNameChanged(String value) {
    final input = FirstNameInput.dirty(value: value);
    emit(state.copyWith(
      firstName: input,
    ));
  }

  void onSubmit() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    try {
      final currentDateTime = DateTime.now();

      final request = CircleCreateRequest(
        firstName: state.firstName.value,
      );

      final circle = await _userRepository.update(request);

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
