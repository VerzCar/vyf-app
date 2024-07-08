import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/injection.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

part 'circle_create_form_state.dart';

class CircleCreateFormCubit extends Cubit<CircleCreateFormState> {
  CircleCreateFormCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleCreateFormState()) {
    final inputDateFrom = CircleDateFromInput.dirty(
      dateUntil: state.dateUntil.value,
      value: DateTime.now().withoutTime.toString(),
    );

    final inputTimeFrom = CircleTimeFromInput.dirty(
      dateFrom: state.dateFrom.value,
      timeUntil: state.timeUntil.value,
      value: DateTime.now().toString(),
    );

    emit(state.copyWith(dateFrom: inputDateFrom, timeFrom: inputTimeFrom));
  }

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
    final dateFromInput = CircleDateFromInput.dirty(
      dateUntil: state.dateUntil.value,
      value: value,
    );
    final dateUntilInput = CircleDateUntilInput.dirty(
      dateFrom: state.dateFrom.value,
      value: state.dateUntil.value,
    );
    emit(state.copyWith(
      dateFrom: dateFromInput,
      dateUntil: dateUntilInput,
    ));
  }

  void onTimeFromChanged(String value) {
    final timeFromInput = CircleTimeFromInput.dirty(
      dateFrom: state.dateFrom.value,
      timeUntil: state.timeUntil.value,
      value: value,
    );
    final timeUntilInput = CircleTimeUntilInput.dirty(
      dateUntil: state.dateUntil.value,
      timeFrom: state.timeFrom.value,
      value: state.timeUntil.value,
    );
    emit(state.copyWith(
      timeFrom: timeFromInput,
      timeUntil: timeUntilInput,
    ));
  }

  void onDateUntilChanged(String value) {
    final dateUntilInput = CircleDateUntilInput.dirty(
      dateFrom: state.dateFrom.value,
      value: value,
    );
    final dateFromInput = CircleDateFromInput.dirty(
      dateUntil: state.dateUntil.value,
      value: state.dateFrom.value,
    );
    final timeUntilInput = CircleTimeUntilInput.dirty(
      dateUntil: state.dateUntil.value,
      timeFrom: state.timeFrom.value,
      value: state.timeUntil.value,
    );
    emit(state.copyWith(
      dateUntil: dateUntilInput,
      dateFrom: dateFromInput,
      timeUntil: timeUntilInput,
    ));
  }

  void onTimeUntilChanged(String value) {
    final timeUntilInput = CircleTimeUntilInput.dirty(
      dateUntil: state.dateUntil.value,
      timeFrom: state.timeFrom.value,
      value: value,
    );
    final timeFromInput = CircleTimeFromInput.dirty(
      dateFrom: state.dateFrom.value,
      timeUntil: state.timeUntil.value,
      value: state.timeFrom.value,
    );
    emit(state.copyWith(
      timeUntil: timeUntilInput,
      timeFrom: timeFromInput,
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
      final currentDateTime = DateTime.now();

      final dateFrom = state.dateFrom.value.isEmpty
          ? currentDateTime
          : DateTime.parse(state.dateFrom.value);
      final timeFrom = state.timeFrom.value.isEmpty
          ? currentDateTime
          : DateTime.parse(state.timeFrom.value);
      final validFrom = DateTime(
        dateFrom.year,
        dateFrom.month,
        dateFrom.day,
        timeFrom.hour,
        timeFrom.minute,
      );

      DateTime? validUntil;

      if (state.dateUntil.value.isNotEmpty) {
        final dateUntil = DateTime.parse(state.dateUntil.value);
        final timeUntil = DateTime.parse(state.timeUntil.value);
        validUntil = DateTime(
          dateUntil.year,
          dateUntil.month,
          dateUntil.day,
          timeUntil.hour,
          timeUntil.minute,
        );
      }

      final request = CircleCreateRequest(
        name: state.name.value,
        description: state.description.value,
        validFrom: validFrom,
        validUntil: validUntil,
        private: state.private.value,
        candidates: const [],
        voters: const [],
      );

      final circle = await _voteCircleRepository.createCircle(request);

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        createdCircle: circle,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onSubmit circle create form',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
