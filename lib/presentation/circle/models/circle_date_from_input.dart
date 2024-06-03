import 'package:formz/formz.dart';

enum CircleDateFromInputError { dateIsBeforeMinDate, dateIsAfterUntilDate }

class CircleDateFromInput extends FormzInput<String, CircleDateFromInputError> {
  const CircleDateFromInput.pure({this.dateUntil = ''}) : super.pure('');

  const CircleDateFromInput.dirty({
    required this.dateUntil,
    String value = '',
  }) : super.dirty(value);

  final String dateUntil;

  static DateTime initialValue = DateTime.now();

  @override
  CircleDateFromInputError? validator(String value) {
    final dateFromTime = DateTime.parse(value);

    if (!dateFromTime.isAfter(DateTime.now())) {
      return CircleDateFromInputError.dateIsBeforeMinDate;
    }

    if (dateUntil.isNotEmpty) {
      final dateUntilTime = DateTime.parse(dateUntil);
      if (dateUntilTime.isBefore(dateFromTime)) {
        return CircleDateFromInputError.dateIsAfterUntilDate;
      }
    }

    return null;
  }
}
