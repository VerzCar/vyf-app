import 'package:formz/formz.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

enum CircleTimeUntilInputError {
  dateUntilEmpty,
  timeIsBeforeMinDate,
  timeIsBeforeFromTime,
  timeIsEqual,
}

class CircleTimeUntilInput
    extends FormzInput<String, CircleTimeUntilInputError> {
  const CircleTimeUntilInput.pure({
    this.dateUntil = '',
    this.timeFrom = '',
  }) : super.pure('');

  const CircleTimeUntilInput.dirty({
    required this.dateUntil,
    required this.timeFrom,
    String value = '',
  }) : super.dirty(value);

  final String dateUntil;
  final String timeFrom;

  @override
  CircleTimeUntilInputError? validator(String value) {
    if(value.isEmpty) {
      return null;
    }

    final untilTime = DateTime.parse(value).withoutSeconds;
    final currentDate = DateTime.now();

    if (dateUntil.isEmpty) {
      return CircleTimeUntilInputError.dateUntilEmpty;
    }

    final dateUntilTime = DateTime.parse(dateUntil);

    if (dateUntilTime.isSameDate(currentDate) &&
        untilTime.isBefore(currentDate)) {
      return CircleTimeUntilInputError.timeIsBeforeMinDate;
    }

    if (timeFrom.isNotEmpty) {
      final fromTime = DateTime.parse(timeFrom).withoutSeconds;
      if (untilTime.isBefore(fromTime)) {
        return CircleTimeUntilInputError.timeIsBeforeFromTime;
      }
      if (untilTime.isSameTime(fromTime)) {
        return CircleTimeUntilInputError.timeIsEqual;
      }
    }

    return null;
  }
}
