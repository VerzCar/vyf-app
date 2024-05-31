import 'package:formz/formz.dart';

enum CircleDateUntilInputError { invalid }

class CircleDateUntilInput extends FormzInput<String, CircleDateUntilInputError> {
  const CircleDateUntilInput.pure() : super.pure('');

  const CircleDateUntilInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CircleDateUntilInputError? validator(String value) {
    final dateTime = DateTime.parse(value);

    if (dateTime.isBefore(DateTime.now())) {
      return CircleDateUntilInputError.invalid;
    }

    return null;
  }
}
