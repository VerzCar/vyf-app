import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    this.label = 'Save',
    this.disabled = false,
    this.isLoading = false,
    required this.onPressed,
    this.foregroundColor = Colors.green,
    this.backgroundColor,
    this.buttonType = ButtonType.text,
  });

  final String label;
  final bool disabled;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color foregroundColor;
  final Color? backgroundColor;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.text:
        {
          return TextButton.icon(
            onPressed: _onPressed(),
            style: _style(),
            label: _label(),
            icon: _icon(),
          );
        }
      case ButtonType.elevated:
        {
          return ElevatedButton.icon(
            onPressed: _onPressed(),
            style: _style(),
            label: _label(),
            icon: _icon(),
          );
        }
      case ButtonType.outlined:
        {
          return OutlinedButton.icon(
            onPressed: _onPressed(),
            style: _style(),
            label: _label(),
            icon: _icon(),
          );
        }
    }
  }

  ButtonStyle? _style() {
    switch (buttonType) {
      case ButtonType.text:
        {
          return TextButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          );
        }
      case ButtonType.elevated:
        {
          return ElevatedButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          );
        }
      case ButtonType.outlined:
        {
          return OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
          );
        }
    }
  }

  VoidCallback? _onPressed() {
    return disabled ? null : () => onPressed();
  }

  Text _label() {
    return Text(label);
  }

  Widget? _icon() {
    return isLoading
        ? Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(2.0),
            child: CircularProgressIndicator(
              color: foregroundColor,
              strokeWidth: 3,
              strokeAlign: CircularProgressIndicator.strokeAlignInside,
            ),
          )
        : null;
  }
}
