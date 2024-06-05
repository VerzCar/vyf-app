import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';

class CircleTimePicker extends StatelessWidget {
  const CircleTimePicker({
    super.key,
    required this.onTimeChanged,
    required this.range,
  });

  final Function(BuildContext, String) onTimeChanged;
  final RangeSelection range;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleEditFormCubit, CircleEditFormState>(
      buildWhen: (previous, current) => range == RangeSelection.from
          ? previous.timeFrom != current.timeFrom
          : previous.timeUntil != current.timeUntil,
      builder: (context, state) {
        return CupertinoDatePicker(
          initialDateTime: selectedTime(state),
          mode: CupertinoDatePickerMode.time,
          use24hFormat: true,
          // This is called when the user changes the date.
          onDateTimeChanged: (DateTime date) {
            onTimeChanged(context, date.toString());
          },
        );
      },
    );
  }

  DateTime selectedTime(CircleEditFormState state) {
    final timeString = range == RangeSelection.from
        ? state.timeFrom.value
        : state.timeUntil.value;

    if (timeString.isEmpty) {
      return DateTime.now();
    }

    return DateTime.parse(timeString);
  }
}
