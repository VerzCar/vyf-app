import 'package:flutter/material.dart';
import 'package:vote_your_face/theme.dart';

void showSuccessSnackbar(
  BuildContext context,
  String text,
) {
  final themeData = Theme.of(context);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: themeData.colorScheme.successColor,
      content: Text(text),
    ));
}

void showErrorSnackbar(
    BuildContext context,
    String text,
    ) {
  final themeData = Theme.of(context);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: themeData.colorScheme.error,
      content: Text(text),
    ));
}
