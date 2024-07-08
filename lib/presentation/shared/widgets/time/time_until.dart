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
  late Timer _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _duration = widget.untilTime.difference(DateTime.now());
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(_duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_duration.inSeconds.remainder(60));

    return _duration.compareTo(const Duration(days: 365)) >= 0
        ? Text('${(_duration.inDays / 365).floor()} years')
        : _duration.compareTo(const Duration(days: 30)) >= 0
            ? Text('${(_duration.inDays / 30).floor()} months')
            : _duration.compareTo(const Duration(days: 1)) >= 0
                ? Text('${_duration.inDays} days')
                : _duration.compareTo(const Duration(hours: 1)) >= 0
                    ? Text(
                        '${_duration.inHours} hours, $twoDigitMinutes minutes')
                    : _duration.compareTo(const Duration(minutes: 1)) >= 0
                        ? Text(
                            '$twoDigitMinutes minutes, $twoDigitSeconds seconds')
                        : _duration == Duration.zero
                            ? const Text('')
                            : Text('$twoDigitSeconds seconds');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = widget.untilTime.difference(DateTime.now());
        if (_duration.isNegative || _duration == Duration.zero) {
          _timer.cancel();
          _duration = Duration.zero;
        }
      });
    });
  }
}
