import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

enum RangeSelection { from, until }

class CreateCircleDurationForm extends StatelessWidget {
  const CreateCircleDurationForm({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Give the circle a duration',
            style: themeData.textTheme.titleLarge,
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: _buildDateTimeRow(context),
          ),
          const SizedBox(height: 20.0),
          Text(
            'The circle should have a descriptive naming, to indicate for what the circle stands for. This gives you the ability to give a first hint for what the circle is for.',
            style: themeData.textTheme.bodyMedium,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: themeData.colorScheme.secondary,
                ),
                onPressed: onPrevious,
                child: const Text('Previous'),
              ),
              const SizedBox(width: 10),
              BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: themeData.colorScheme.onSecondary,
                        backgroundColor: themeData.colorScheme.secondary),
                    onPressed: state.description.isValid ? onNext : null,
                    child: const Text('Next'),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDateTimeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDateTimeColumn(
          context,
          'Start',
          _CircleDateFromPicker(),
          _CircleTimeFromPicker(),
          RangeSelection.from,
        ),
        const VerticalDivider(),
        _buildDateTimeColumn(
          context,
          'End',
          _CircleDateUntilPicker(),
          _CircleTimeUntilPicker(),
          RangeSelection.until,
        ),
      ],
    );
  }

  Widget _buildDateTimeColumn(
    BuildContext context,
    String label,
    Widget datePicker,
    Widget timePicker,
    RangeSelection range,
  ) {
    final themeData = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: themeData.textTheme.labelLarge,
          ),
          _CircleDateInput(
            range: range,
            onTap: () => _showCupertinoDialog(context, datePicker),
          ),
          _CircleTimeInput(
            range: range,
            onTap: () => _showCupertinoDialog(context, timePicker),
          ),
        ],
      ),
    );
  }

  void _showCupertinoDialog(
    BuildContext context,
    Widget child,
  ) {
    final circleCrateFormCubit =
        BlocProvider.of<CircleCreateFormCubit>(context);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: BlocProvider.value(
            value: circleCrateFormCubit,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _CircleDateInput extends StatefulWidget {
  const _CircleDateInput({
    super.key,
    required this.range,
    required this.onTap,
  });

  final RangeSelection range;
  final VoidCallback onTap;

  @override
  State<_CircleDateInput> createState() => _CircleDateInputState();
}

class _CircleDateInputState extends State<_CircleDateInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      builder: (context, state) {
        if (widget.range == RangeSelection.from) {
          _controller.text = state.dateFrom.value.isEmpty
              ? DateFormat.yMMMEd().format(CircleDateFromInput.initialValue)
              : DateFormat.yMMMEd()
                  .format(DateTime.parse(state.dateFrom.value));
          return VyfTextFormField(
              key: Key(
                  'CreateCircleDurationForm_Date${widget.range.toString()}Field'),
              controller: _controller,
              onTap: () => widget.onTap(),
              readOnly: true,
              textAlign: TextAlign.center,
              showError: !state.dateFrom.isPure && state.dateFrom.isNotValid);
        }

        _controller.text = state.dateUntil.value.isEmpty
            ? '   infinite   '
            : DateFormat.yMMMEd().format(DateTime.parse(state.dateUntil.value));
        return VyfTextFormField(
            key: Key(
                'CreateCircleDurationForm_Date${widget.range.toString()}Field'),
            controller: _controller,
            onTap: () => widget.onTap(),
            readOnly: true,
            textAlign: TextAlign.center,
            showError: !state.dateUntil.isPure && state.dateUntil.isNotValid);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CircleTimeInput extends StatefulWidget {
  const _CircleTimeInput({
    super.key,
    required this.range,
    required this.onTap,
  });

  final RangeSelection range;
  final VoidCallback onTap;

  @override
  State<_CircleTimeInput> createState() => _CircleTimeInputState();
}

class _CircleTimeInputState extends State<_CircleTimeInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      builder: (context, state) {
        if (widget.range == RangeSelection.from) {
          _controller.text = state.timeFrom.value.isEmpty
              ? DateFormat.Hm().format(CircleTimeFromInput.initialValue)
              : DateFormat.Hm().format(DateTime.parse(state.timeFrom.value));
          return VyfTextFormField(
              key: Key(
                  'CreateCircleDurationForm_Time${widget.range.toString()}Field'),
              controller: _controller,
              onTap: () => widget.onTap(),
              readOnly: true,
              textAlign: TextAlign.center,
              showError: !state.timeFrom.isPure && state.timeFrom.isNotValid);
        }

        _controller.text = state.timeUntil.value.isEmpty
            ? '--:--'
            : DateFormat.Hm().format(DateTime.parse(state.timeUntil.value));
        return VyfTextFormField(
            key: Key(
                'CreateCircleDurationForm_Time${widget.range.toString()}Field'),
            controller: _controller,
            onTap: () => widget.onTap(),
            readOnly: true,
            textAlign: TextAlign.center,
            showError: !state.timeUntil.isPure && state.timeUntil.isNotValid);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CircleDatePicker extends StatelessWidget {
  final DateTime maxDate = DateTime.now().add(const Duration(days: 1825));
  final Function(BuildContext, String) onDateChanged;
  final RangeSelection range;

  _CircleDatePicker({
    required this.onDateChanged,
    required this.range,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
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

  DateTime selectedDate(CircleCreateFormState state) {
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

class _CircleTimePicker extends StatelessWidget {
  final Function(BuildContext, String) onTimeChanged;

  final RangeSelection range;

  const _CircleTimePicker({
    required this.onTimeChanged,
    required this.range,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
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

  DateTime selectedTime(CircleCreateFormState state) {
    final timeString = range == RangeSelection.from
        ? state.timeFrom.value
        : state.timeUntil.value;

    if (timeString.isEmpty) {
      return DateTime.now();
    }

    return DateTime.parse(timeString);
  }
}

class _CircleDateFromPicker extends _CircleDatePicker {
  _CircleDateFromPicker()
      : super(
          onDateChanged: (context, date) {
            context.read<CircleCreateFormCubit>().onDateFromChanged(date);
          },
          range: RangeSelection.from,
        );
}

class _CircleTimeFromPicker extends _CircleTimePicker {
  _CircleTimeFromPicker()
      : super(
          onTimeChanged: (context, time) {
            context.read<CircleCreateFormCubit>().onTimeFromChanged(time);
          },
          range: RangeSelection.from,
        );
}

class _CircleDateUntilPicker extends _CircleDatePicker {
  _CircleDateUntilPicker()
      : super(
          onDateChanged: (context, date) {
            context.read<CircleCreateFormCubit>().onDateUntilChanged(date);
          },
          range: RangeSelection.until,
        );
}

class _CircleTimeUntilPicker extends _CircleTimePicker {
  _CircleTimeUntilPicker()
      : super(
          onTimeChanged: (context, time) {
            context.read<CircleCreateFormCubit>().onTimeUntilChanged(time);
          },
          range: RangeSelection.until,
        );
}
