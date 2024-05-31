import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';

part 'circle_create_form_state.dart';

class CircleCreateFormCubit extends Cubit<CircleCreateFormState> {
  CircleCreateFormCubit({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const CircleCreateFormState());

  final IUserRepository _userRepository;

  void onNameChanged(String value) {
    final input = CircleNameInput.dirty(value: value);
    emit(state.copyWith(
      name: input,
    ));
  }

  void onDescriptionChanged(String value) {
    final input = CircleDescriptionInput.dirty(value: value);
    emit(state.copyWith(
      description: input,
    ));
  }

  void onDateFromChanged(String value) {
    final input = CircleDateFromInput.dirty(value: value);
    emit(state.copyWith(
      dateFrom: input,
    ));
  }

  void onTimeFromChanged(String value) {
    final input = CircleTimeFromInput.dirty(value: value);
    emit(state.copyWith(
      timeFrom: input,
    ));
  }

  void onDateUntilChanged(String value) {
    final input = CircleDateUntilInput.dirty(value: value);
    emit(state.copyWith(
      dateUntil: input,
    ));
  }

  void onTimeUntilChanged(String value) {
    final input = CircleTimeUntilInput.dirty(value: value);
    emit(state.copyWith(
      timeUntil: input,
    ));
  }

  void onPrivateChanged(bool value) {
    final input = CirclePrivateInput.dirty(value: value);
    emit(state.copyWith(
      private: input,
    ));
  }

  void onSubmit() {
  }
}
