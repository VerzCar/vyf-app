import 'package:flutter/material.dart';

class OverlayScaled extends StatefulWidget {
  const OverlayScaled({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<OverlayScaled> createState() => _OverlayScaledState();
}

class _OverlayScaledState extends State<OverlayScaled> {
  OverlayEntry? _overlayEntry;
  bool _isOverlayVisible = false;

  @override
  void initState() {
    super.initState();

  }

  void _showOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOverlayVisible = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      _hideOverlay();
    });
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => AnimatedOpacity(
        opacity: _isOverlayVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        child: AnimatedScale(
          scale: _isOverlayVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          child: widget.child,
        ),
      ),
    );
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    setState(() {
      _isOverlayVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      _showOverlay(context);
    });

    return const SizedBox();
  }
}
