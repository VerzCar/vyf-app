import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';

class CircleDatePicker extends StatelessWidget {
  const CircleDatePicker({
    super.key,
    required this.onDateChanged,
    required this.range,
  });

  static final DateTime maxDate =
      DateTime.now().add(const Duration(days: 1825));
  final Function(BuildContext, String) onDateChanged;
  final RangeSelection range;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleEditFormCubit, CircleEditFormState>(
      buildWhen: (previous, current) => range == RangeSelection.from
          ? previous.dateFrom != current.dateFrom
          : previous.dateUntil != current.dateUntil,
      builder: (context, state) {
        return CupertinoDatePicker(
          initialDateTime: selectedDate(state),
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
          showDayOfWeek: true,
          minimumDate: minDate,
          maximumDate: maxDate,
          // This is called when the user changes the date.
          onDateTimeChanged: (DateTime date) {
            onDateChanged(context, date.toString());
          },
        );
      },
    );
  }

  DateTime selectedDate(CircleEditFormState state) {
    final dateString = range == RangeSelection.from
        ? state.dateFrom.value
        : state.dateUntil.value;

    if (dateString.isEmpty) {
      return DateTime.now();
    }

    return DateTime.parse(dateString);
  }

  DateTime get minDate {
    final currentDate = DateTime.now();
    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
  }
}
