import 'package:formz/formz.dart';

enum CircleDateUntilInputError { dateIsBeforeMinDate, dateIsBeforeFromDate }

class CircleDateUntilInput
    extends FormzInput<String, CircleDateUntilInputError> {
  const CircleDateUntilInput.pure({this.dateFrom = ''}) : super.pure('');

  const CircleDateUntilInput.dirty({
    required this.dateFrom,
    String value = '',
  }) : super.dirty(value);

  final String dateFrom;

  @override
  CircleDateUntilInputError? validator(String value) {
    final dateUntilTime = DateTime.parse(value);

    if (dateUntilTime.isBefore(DateTime.now())) {
      return CircleDateUntilInputError.dateIsBeforeMinDate;
    }

    if (dateFrom.isNotEmpty) {
      final dateFromTime = DateTime.parse(dateFrom);
      if (dateUntilTime.isBefore(dateFromTime)) {
        return CircleDateUntilInputError.dateIsBeforeFromDate;
      }
    }

    return null;
  }
}
