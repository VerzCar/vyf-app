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

  void onNameChanged(String name) {
    final input = CircleNameInput.dirty(value: name);
    emit(state.copyWith(
      name: input,
    ));
  }

  void onDescriptionChanged(String name) {
    final input = CircleDescriptionInput.dirty(value: name);
    emit(state.copyWith(
      description: input,
    ));
  }
}
