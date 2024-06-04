import 'package:formz/formz.dart';

enum WhyVoteMeInputError { maxLength }

class WhyVoteMeInput extends FormzInput<String, WhyVoteMeInputError> {
  const WhyVoteMeInput.pure() : super.pure('');

  const WhyVoteMeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  WhyVoteMeInputError? validator(String value) {
    if (value.length > 250) {
      return WhyVoteMeInputError.maxLength;
    }

    return null;
  }
}
