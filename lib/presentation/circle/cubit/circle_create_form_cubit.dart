import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';

part 'circle_create_form_state.dart';

class CircleCreateFormCubit extends Cubit<CircleCreateFormState> {
  CircleCreateFormCubit({
    required IUserRepository userRepository,
    required IVoteCircleRepository voteCircleRepository,
  })  : _userRepository = userRepository,
        _voteCircleRepository = voteCircleRepository,
        super(const CircleCreateFormState());

  final IUserRepository _userRepository;
  final IVoteCircleRepository _voteCircleRepository;

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

  void onSubmit() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    try {
      final request = CircleCreateRequest(
        name: state.name.value,
        description: state.description.value,
        candidates: const [],
        voters: const [],
      );

      final circle = await _voteCircleRepository.createCircle(request);

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        createdCircle: circle,
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
