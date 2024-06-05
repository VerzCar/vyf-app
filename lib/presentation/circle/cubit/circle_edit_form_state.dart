part of 'circle_edit_form_cubit.dart';

final class CircleEditFormState extends Equatable {
  const CircleEditFormState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const CircleNameInput.pure(),
    this.description = const CircleDescriptionInput.pure(),
    this.dateFrom = const CircleDateFromInput.pure(),
    this.timeFrom = const CircleTimeFromInput.pure(),
    this.dateUntil = const CircleDateUntilInput.pure(),
    this.timeUntil = const CircleTimeUntilInput.pure(),
    this.private = const CirclePrivateInput.pure(),
    this.updatedCircle,
  });

  final FormzSubmissionStatus status;
  final CircleNameInput name;
  final CircleDescriptionInput description;
  final CircleDateFromInput dateFrom;
  final CircleTimeFromInput timeFrom;
  final CircleDateUntilInput dateUntil;
  final CircleTimeUntilInput timeUntil;
  final CirclePrivateInput private;
  final Circle? updatedCircle;

  CircleEditFormState copyWith(
      {FormzSubmissionStatus? status,
      CircleNameInput? name,
      CircleDescriptionInput? description,
      CircleDateFromInput? dateFrom,
      CircleTimeFromInput? timeFrom,
      CircleDateUntilInput? dateUntil,
      CircleTimeUntilInput? timeUntil,
      CirclePrivateInput? private,
      Circle? updatedCircle}) {
    return CircleEditFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      dateFrom: dateFrom ?? this.dateFrom,
      timeFrom: timeFrom ?? this.timeFrom,
      dateUntil: dateUntil ?? this.dateUntil,
      timeUntil: timeUntil ?? this.timeUntil,
      private: private ?? this.private,
      updatedCircle: updatedCircle ?? this.updatedCircle,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        description,
        dateFrom,
        timeFrom,
        dateUntil,
        timeUntil,
        private,
        updatedCircle,
      ];
}
