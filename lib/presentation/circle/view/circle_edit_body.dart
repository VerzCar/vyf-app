import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/application/circle/circle.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_edit_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/widgets/circle_date_input.dart';
import 'package:vote_your_face/presentation/circle/widgets/circle_date_picker.dart';
import 'package:vote_your_face/presentation/circle/widgets/circle_time_input.dart';
import 'package:vote_your_face/presentation/circle/widgets/circle_time_picker.dart';
import 'package:vote_your_face/presentation/circle/widgets/edit_circle_delete_button.dart';
import 'package:vote_your_face/presentation/circle/widgets/edit_circle_description_input.dart';
import 'package:vote_your_face/presentation/circle/widgets/edit_circle_name_input.dart';

class CircleEditBody extends StatelessWidget {
  const CircleEditBody({super.key, required this.circle});

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      children: [
        EditCircleNameInput(initialValue: circle.name),
        const SizedBox(height: 10),
        EditCircleDescriptionInput(initialValue: circle.description),
        const SizedBox(height: 10),
        _buildDateTimeRangeRow(context),
        const SizedBox(height: 80),
        EditCircleDeleteButton(circleId: circle.id),
      ],
    );
  }

  Widget _buildDateTimeRangeRow(BuildContext context) {
    return Row(
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
          CircleDateInput(
            range: range,
            onTap: () => _showCupertinoDialog(context, datePicker),
            initialValue: range == RangeSelection.from
                ? circle.validFrom
                : circle.validUntil,
          ),
          const SizedBox(height: 10),
          CircleTimeInput(
            range: range,
            onTap: () => _showCupertinoDialog(context, timePicker),
            initialValue: range == RangeSelection.from
                ? circle.validFrom
                : circle.validUntil,
          ),
        ],
      ),
    );
  }

  void _showCupertinoDialog(
    BuildContext context,
    Widget child,
  ) {
    final circleCrateFormCubit = BlocProvider.of<CircleEditFormCubit>(context);

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

class _CircleDateFromPicker extends CircleDatePicker {
  _CircleDateFromPicker()
      : super(
          onDateChanged: (context, date) {
            context.read<CircleEditFormCubit>().onDateFromChanged(date);
          },
          range: RangeSelection.from,
        );
}

class _CircleTimeFromPicker extends CircleTimePicker {
  _CircleTimeFromPicker()
      : super(
          onTimeChanged: (context, time) {
            context.read<CircleEditFormCubit>().onTimeFromChanged(time);
          },
          range: RangeSelection.from,
        );
}

class _CircleDateUntilPicker extends CircleDatePicker {
  _CircleDateUntilPicker()
      : super(
          onDateChanged: (context, date) {
            context.read<CircleEditFormCubit>().onDateUntilChanged(date);
          },
          range: RangeSelection.until,
        );
}

class _CircleTimeUntilPicker extends CircleTimePicker {
  _CircleTimeUntilPicker()
      : super(
          onTimeChanged: (context, time) {
            context.read<CircleEditFormCubit>().onTimeUntilChanged(time);
          },
          range: RangeSelection.until,
        );
}
