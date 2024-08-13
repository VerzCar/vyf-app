import 'package:flutter/material.dart';

class VyfTextFormField extends StatelessWidget {
  const VyfTextFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
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
    this.hintText,
    this.obscureText = false,
    this.icon,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
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
  final String? hintText;
  final bool obscureText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    if (labelText.isEmpty) {
      return _field();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: themeData.textTheme.labelLarge,
        ),
        _field(),
      ],
    );
  }

  TextFormField _field() {
    return TextFormField(
      key: key,
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
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
        errorMaxLines: 2,
        //errorStyle: TextStyle(fontSize: 0),
        icon: icon,
        helperText: helperText,
        hintText: hintText,
      ),
    );
  }
}
