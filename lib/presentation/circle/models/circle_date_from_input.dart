import 'package:formz/formz.dart';

enum CircleDateFromInputError { invalid }

class CircleDateFromInput extends FormzInput<String, CircleDateFromInputError> {
  const CircleDateFromInput.pure() : super.pure('');

  const CircleDateFromInput.dirty({String value = ''}) : super.dirty(value);

  static DateTime initialValue = DateTime.now();

  @override
  CircleDateFromInputError? validator(String value) {
    final dateTime = DateTime.parse(value);

    if (!dateTime.isAfter(DateTime.now())) {
      return CircleDateFromInputError.invalid;
    }

    return null;
  }
}
