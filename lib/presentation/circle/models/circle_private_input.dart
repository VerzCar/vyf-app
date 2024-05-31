import 'package:formz/formz.dart';

enum CirclePrivateInputInputError { invalid }

class CirclePrivateInput extends FormzInput<bool, CirclePrivateInputInputError> {
  const CirclePrivateInput.pure() : super.pure(false);

  const CirclePrivateInput.dirty({bool value = false}) : super.dirty(value);

  static DateTime initialValue = DateTime.now();

  @override
  CirclePrivateInputInputError? validator(bool value) {
    return null;
  }
}
