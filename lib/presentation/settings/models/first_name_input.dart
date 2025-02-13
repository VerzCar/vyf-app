import 'package:formz/formz.dart';

enum FirstNameInputError { maxLength }

class FirstNameInput extends FormzInput<String, FirstNameInputError> {
  const FirstNameInput.pure() : super.pure('');

  const FirstNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  FirstNameInputError? validator(String value) {
    if (value.length > 40) {
      return FirstNameInputError.maxLength;
    }

    return null;
  }
}
