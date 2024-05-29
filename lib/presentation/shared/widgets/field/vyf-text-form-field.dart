import 'package:flutter/material.dart';

class VyfTextFormField extends StatelessWidget {
  const VyfTextFormField({
    super.key,
    required this.onChanged,
    this.labelText = '',
    this.errorText = '',
    this.showError = false,
    this.keyboardType = TextInputType.text,
    this.initialValue = '',
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.helperText,
    this.obscureText = false,
    this.icon,
  });

  final Function(String) onChanged;
  final String labelText;
  final String errorText;
  final bool showError;
  final TextInputType keyboardType;
  final String initialValue;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? helperText;
  final bool obscureText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: themeData.textTheme.labelLarge,
        ),
        TextFormField(
          key: key,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          initialValue: initialValue,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(),
            border: const OutlineInputBorder(),
            errorText: showError ? errorText : null,
            icon: icon,
            helperText: helperText,
          ),
        ),
      ],
    );
  }
}
