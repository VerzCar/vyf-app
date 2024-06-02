import 'package:flutter/material.dart';

class VyfTextFormField extends StatelessWidget {
  const VyfTextFormField({
    super.key,
    this.controller,
    required this.onChanged,
    this.onTap,
    this.labelText = '',
    this.errorText = '',
    this.showError = false,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.helperText,
    this.obscureText = false,
    this.icon,
  });

  final TextEditingController? controller;
  final Function(String) onChanged;
  final VoidCallback? onTap;
  final String labelText;
  final String errorText;
  final bool showError;
  final TextInputType keyboardType;
  final String? initialValue;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final TextAlign textAlign;
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
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          initialValue: initialValue,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          readOnly: readOnly,
          textAlign: textAlign,
          onTap: onTap,
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
