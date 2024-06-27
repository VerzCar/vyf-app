import 'dart:async';

import 'package:flutter/material.dart';

class TimeUntil extends StatefulWidget {
  const TimeUntil({
    super.key,
    required this.untilTime,
  });

  final DateTime untilTime;

  @override
  State<TimeUntil> createState() => _TimeUntilState();
}

class _TimeUntilState extends State<TimeUntil> {
  _TimeUntilState() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) => _onTimeTick(timer),
    );
  }

  late Timer _timer;
  DateTime _date = DateTime.now();
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _duration = widget.until.difference(DateTime.now());
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('check'),
        _days > 0
            ? _buildTimeOutput(
                context: context,
                dt: _days,
                label: 'days',
              )
            : const SizedBox(),
        _hours > 0
            ? _buildTimeOutput(
                context: context,
                dt: _hours,
                label: 'hours',
              )
            : const SizedBox(),
        _minutes > 0
            ? _buildTimeOutput(
                context: context,
                dt: _days,
                label: 'minutes',
              )
            : const SizedBox(),
        _seconds > 0
            ? _buildTimeOutput(
                context: context,
                dt: _seconds,
                label: 'seconds',
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Duration get _difference => _date.difference(widget.untilTime);

  Text _buildTimeOutput({
    required BuildContext context,
    required int dt,
    required String label,
  }) {
    final themeData = Theme.of(context);

    return Text.rich(
      TextSpan(
        style: themeData.textTheme.labelLarge,
        children: [
          TextSpan(
            text: dt.toString(),
          ),
          TextSpan(
            text: label,
          ),
        ],
      ),
    );
  }

  void _onTimeTick(Timer timer) {
    //print('+++++++++++++TICK+++++++++++');
    final diff = _difference;
    //print('+++++++++++++inSeconds ${diff.inSeconds.abs()}+++++++++++');
    if (diff.inSeconds >= 0) {
      setState(() {
        timer.cancel();
      });
      return;
    }

    setState(() {
      _date = _date.subtract(const Duration(seconds: 1));
      _days = diff.inDays.abs();
      _hours = diff.inHours.abs();
      _minutes = diff.inMinutes.abs();
      _seconds = diff.inSeconds.abs();
    });
  }
}
