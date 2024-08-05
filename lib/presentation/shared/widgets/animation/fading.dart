import 'package:flutter/material.dart';

class Fading extends StatefulWidget {
  const Fading({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.repeat = false,
    this.reverse = false,
  });

  final Widget child;
  final Duration duration;
  final bool repeat;
  final bool reverse;

  @override
  State<Fading> createState() => _FadingState();
}

class _FadingState extends State<Fading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.repeat) {
      _controller.repeat(reverse: widget.repeat);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
