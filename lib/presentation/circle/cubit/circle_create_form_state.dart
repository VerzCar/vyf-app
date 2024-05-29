part of 'circle_create_form_cubit.dart';

final class CircleCreateFormState extends Equatable {
  const CircleCreateFormState(
      {this.status = FormzSubmissionStatus.initial,
      this.name = const CircleNameInput.pure(),
      this.description = const CircleDescriptionInput.pure()});

  final FormzSubmissionStatus status;
  final CircleNameInput name;
  final CircleDescriptionInput description;

  CircleCreateFormState copyWith({
    FormzSubmissionStatus? status,
    CircleNameInput? name,
    CircleDescriptionInput? description,
  }) {
    return CircleCreateFormState(
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        description,
      ];
}
