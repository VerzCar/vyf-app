import 'package:formz/formz.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

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
    if(value.isEmpty) {
      return null;
    }

    final dateFromTime = DateTime.parse(value);
    final currentDate = DateTime.now().withoutTime;

    if (dateFromTime.isBefore(currentDate)) {
      return CircleDateFromInputError.dateIsBeforeMinDate;
    }

    // if (dateUntil.isNotEmpty) {
    //   final dateUntilTime = DateTime.parse(dateUntil);
    //   if (dateUntilTime.isBefore(dateFromTime)) {
    //     return CircleDateFromInputError.dateIsAfterUntilDate;
    //   }
    // }

    return null;
  }
}
