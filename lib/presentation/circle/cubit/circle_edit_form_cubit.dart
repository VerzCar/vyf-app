import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/injection.dart';

part 'circle_edit_form_state.dart';

class CircleEditFormCubit extends Cubit<CircleEditFormState> {
  CircleEditFormCubit({
    required IVoteCircleRepository voteCircleRepository,
  })  : _voteCircleRepository = voteCircleRepository,
        super(const CircleEditFormState());

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

  void onSubmit(int circleId) async {
    emit(state.copyWith(
      status: CircleEditSubmissionStatus.loading,
    ));

    try {
      DateTime? validFrom;

      if (state.dateFrom.value.isNotEmpty && state.timeFrom.value.isNotEmpty) {
        final currentDateTime = DateTime.now();
        final dateFrom = state.dateFrom.value.isEmpty
            ? currentDateTime
            : DateTime.parse(state.dateFrom.value);
        final timeFrom = state.timeFrom.value.isEmpty
            ? currentDateTime
            : DateTime.parse(state.timeFrom.value);
        validFrom = DateTime(
          dateFrom.year,
          dateFrom.month,
          dateFrom.day,
          timeFrom.hour,
          timeFrom.minute,
        );
      }

      DateTime? validUntil;

      if (state.dateUntil.value.isNotEmpty &&
          state.timeUntil.value.isNotEmpty) {
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

      final request = CircleUpdateRequest(
        name: state.name.isPure ? null : state.name.value,
        description: state.description.isPure ? null : state.description.value,
        validFrom: validFrom,
        validUntil: validUntil,
      );

      final circle =
          await _voteCircleRepository.updateCircle(circleId, request);

      emit(state.copyWith(
        status: CircleEditSubmissionStatus.success,
        updatedCircle: circle,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onSubmit circle edit form',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CircleEditSubmissionStatus.failure,
      ));
    }
  }

  void onDelete(int circleId) async {
    emit(state.copyWith(
      status: CircleEditSubmissionStatus.loading,
    ));

    try {
      await _voteCircleRepository.deleteCircle(circleId);

      emit(state.copyWith(
        status: CircleEditSubmissionStatus.deleteSuccess,
        deletedCircleId: circleId,
      ));
    } catch (e) {
      sl<Logger>().t(
        'onDelete circle edit form',
        error: e,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: CircleEditSubmissionStatus.failure,
      ));
    }
  }
}
