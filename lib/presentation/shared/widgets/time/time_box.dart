import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({super.key, required this.from, this.until});

  final DateTime from;
  final DateTime? until;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _timeText(context, DateFormat.yMMMd().add_Hm().format(from)),
        const SizedBox(width: 5),
        const Icon(Icons.arrow_downward_outlined, size: 14),
        const SizedBox(width: 5),
        _untilTime(context),
      ],
    );
  }

  Widget _untilTime(BuildContext context) {
    return until != null
        ? _timeText(context, DateFormat.yMMMd().add_Hm().format(until!))
        : const Icon(Icons.minimize, size: 16);
  }

  Widget _timeText(BuildContext context, String text) {
    final themeData = Theme.of(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: themeData.textTheme.labelMedium?.fontSize,
        fontWeight: themeData.textTheme.labelMedium?.fontWeight,
      ),
    );
  }
}
