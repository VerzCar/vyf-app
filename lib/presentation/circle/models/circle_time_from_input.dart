import 'package:formz/formz.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

enum CircleTimeFromInputError {
  timeIsBeforeMinDate,
  timeIsAfterUntilTime,
  timeIsEqual
}

class CircleTimeFromInput extends FormzInput<String, CircleTimeFromInputError> {
  const CircleTimeFromInput.pure({
    this.dateFrom = '',
    this.timeUntil = '',
  }) : super.pure('');

  const CircleTimeFromInput.dirty({
    required this.dateFrom,
    required this.timeUntil,
    String value = '',
  }) : super.dirty(value);

  static DateTime initialValue = DateTime.now();
  final String dateFrom;
  final String timeUntil;

  @override
  CircleTimeFromInputError? validator(String value) {
    final fromTime = DateTime.parse(value);
    final currentDate = DateTime.now();

    if (dateFrom.isNotEmpty) {
      final dateFromTime = DateTime.parse(dateFrom);
      if (dateFromTime.isSameDate(currentDate) &&
          fromTime.isBefore(currentDate)) {
        return CircleTimeFromInputError.timeIsBeforeMinDate;
      }
    }

    if (timeUntil.isNotEmpty) {
      final untilTime = DateTime.parse(timeUntil);
      if (fromTime.isAfter(untilTime)) {
        return CircleTimeFromInputError.timeIsAfterUntilTime;
      }
      if (fromTime.isSameTime(untilTime)) {
        return CircleTimeFromInputError.timeIsEqual;
      }
    }

    return null;
  }
}
