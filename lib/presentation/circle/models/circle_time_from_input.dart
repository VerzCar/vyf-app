import 'package:formz/formz.dart';

enum CircleTimeFromInputError { invalid }

class CircleTimeFromInput extends FormzInput<String, CircleTimeFromInputError> {
  const CircleTimeFromInput.pure() : super.pure('');

  const CircleTimeFromInput.dirty({String value = ''}) : super.dirty(value);

  static DateTime initialValue = DateTime.now();

  @override
  CircleTimeFromInputError? validator(String value) {
    final dateTime = DateTime.parse(value);

    if (!dateTime.isAfter(DateTime.now())) {
      return CircleTimeFromInputError.invalid;
    }

    return null;
  }
}
