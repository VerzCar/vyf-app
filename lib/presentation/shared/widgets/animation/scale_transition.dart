import 'package:flutter/material.dart';

class AnimatedScaleNotification extends StatefulWidget {
  const AnimatedScaleNotification({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AnimatedScaleNotification> createState() =>
      _AnimatedScaleNotificationState();
}

class _AnimatedScaleNotificationState extends State<AnimatedScaleNotification>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )
    ..repeat(reverse: true)
    ..addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        _controller.stop();
        return;
      }
    });
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
