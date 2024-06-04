import 'package:formz/formz.dart';

enum LastNameInputError { maxLength }

class LastNameInput extends FormzInput<String, LastNameInputError> {
  const LastNameInput.pure() : super.pure('');

  const LastNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  LastNameInputError? validator(String value) {
    if (value.length > 40) {
      return LastNameInputError.maxLength;
    }

    return null;
  }
}
