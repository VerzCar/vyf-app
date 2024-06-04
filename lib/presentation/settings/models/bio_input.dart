import 'package:formz/formz.dart';

enum BioInputError { maxLength }

class BioInput extends FormzInput<String, BioInputError> {
  const BioInput.pure() : super.pure('');

  const BioInput.dirty({String value = ''}) : super.dirty(value);

  @override
  BioInputError? validator(String value) {
    if (value.length > 1500) {
      return BioInputError.maxLength;
    }

    return null;
  }
}
