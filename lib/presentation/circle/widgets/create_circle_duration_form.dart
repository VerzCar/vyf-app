import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_your_face/presentation/circle/cubit/circle_create_form_cubit.dart';
import 'package:vote_your_face/presentation/circle/models/models.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Date from:'),
                Expanded(
                  child: BlocProvider.value(
                    value: BlocProvider.of<CircleCreateFormCubit>(context),
                    child: TextButton(
                      onPressed: () =>
                          _showCupertinoDialog(
                            context,
                            _CircleDateFromPicker(),
                          ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: themeData.colorScheme.secondary,
                      ),
                      child: BlocBuilder<CircleCreateFormCubit,
                          CircleCreateFormState>(
                        builder: (context, state) {
                          return Text(
                            state.dateFrom.value.isEmpty
                                ? CircleDateFromInput.initialValue.toString()
                                : state.dateFrom.value,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  void _showCupertinoDialog(BuildContext context,
      Widget child,) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            // Provide a background color for the popup.
            color: CupertinoColors.systemBackground.resolveFrom(context),
            // Use a SafeArea widget to avoid system overlaps.
            child: SafeArea(
              top: false,
              child: BlocProvider.value(
                value: BlocProvider.of<CircleCreateFormCubit>(context),
                child: child,
              ),
            ),
          ),
    );
  }
}

class _CircleDateFromPicker extends StatelessWidget {
  final DateTime date = DateTime.now();
  final DateTime minDate = DateTime.now().add(const Duration(minutes: 1));
  final DateTime maxDate = DateTime.now().add(const Duration(days: 1825));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircleCreateFormCubit, CircleCreateFormState>(
      buildWhen: (previous, current) => previous.dateFrom != current.dateFrom,
      builder: (context, state) {
        return CupertinoDatePicker(
          initialDateTime: date,
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
          showDayOfWeek: true,
          minimumDate: minDate,
          maximumDate: maxDate,
          // This is called when the user changes the date.
          onDateTimeChanged: (DateTime date) {
            context
                .read<CircleCreateFormCubit>()
                .onDateFromChanged(date.toString());
          },
        );
      },
    );
  }
}
