import 'package:formz/formz.dart';

enum CircleTimeUntilInputError { invalid }

class CircleTimeUntilInput extends FormzInput<String, CircleTimeUntilInputError> {
  const CircleTimeUntilInput.pure() : super.pure('');

  const CircleTimeUntilInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CircleTimeUntilInputError? validator(String value) {
    final dateTime = DateTime.parse(value);

    if (dateTime.isBefore(DateTime.now())) {
      return CircleTimeUntilInputError.invalid;
    }

    return null;
  }
}
