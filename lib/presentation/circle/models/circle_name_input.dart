import 'package:formz/formz.dart';

enum CircleNameInputError { empty, maxLength }

class CircleNameInput extends FormzInput<String, CircleNameInputError> {
  const CircleNameInput.pure() : super.pure('');

  const CircleNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CircleNameInputError? validator(String value) {
    if (value.isEmpty) {
      return CircleNameInputError.empty;
    }

    if (value.length > 50) {
      return CircleNameInputError.maxLength;
    }

    return null;
  }
}
