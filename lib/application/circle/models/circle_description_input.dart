import 'package:formz/formz.dart';

enum CircleDescriptionInputError { empty, maxLength }

class CircleDescriptionInput extends FormzInput<String, CircleDescriptionInputError> {
  const CircleDescriptionInput.pure() : super.pure('');

  const CircleDescriptionInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CircleDescriptionInputError? validator(String value) {
    if (value.isEmpty) {
      return CircleDescriptionInputError.empty;
    }

    if (value.length > 1500) {
      return CircleDescriptionInputError.maxLength;
    }

    return null;
  }
}
