part of 'circle_create_form_cubit.dart';

final class CircleCreateFormState extends Equatable {
  const CircleCreateFormState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const CircleNameInput.pure(),
    this.description = const CircleDescriptionInput.pure(),
    this.dateFrom = const CircleDateFromInput.pure(),
    this.timeFrom = const CircleTimeFromInput.pure(),
    this.dateUntil = const CircleDateUntilInput.pure(),
    this.timeUntil = const CircleTimeUntilInput.pure(),
  });

  final FormzSubmissionStatus status;
  final CircleNameInput name;
  final CircleDescriptionInput description;
  final CircleDateFromInput dateFrom;
  final CircleTimeFromInput timeFrom;
  final CircleDateUntilInput dateUntil;
  final CircleTimeUntilInput timeUntil;

  CircleCreateFormState copyWith(
      {FormzSubmissionStatus? status,
      CircleNameInput? name,
      CircleDescriptionInput? description,
      CircleDateFromInput? dateFrom,
      CircleTimeFromInput? timeFrom,
      CircleDateUntilInput? dateUntil,
      CircleTimeUntilInput? timeUntil}) {
    return CircleCreateFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      dateFrom: dateFrom ?? this.dateFrom,
      timeFrom: timeFrom ?? this.timeFrom,
      dateUntil: dateUntil ?? this.dateUntil,
      timeUntil: timeUntil ?? this.timeUntil,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        description,
        dateFrom,
        timeFrom,
        dateUntil,
        timeUntil,
      ];
}
