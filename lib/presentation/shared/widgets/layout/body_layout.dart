import 'package:flutter/material.dart';

/// A Page body layout container that wraps the child with basic layout
/// definitions.
class BodyLayout extends StatelessWidget {
  const BodyLayout({
    super.key,
    required this.child,
    this.verticalPadding = 0.0,
  });

  final Widget child;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: verticalPadding,
      ),
      child: child,
    );
  }
}
