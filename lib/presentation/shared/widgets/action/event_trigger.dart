import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vote_your_face/presentation/shared/widgets/snackbar/snackbar.dart';

class EventTrigger {
  static void success({
    required BuildContext context,
    String? msg,
  }) {
    HapticFeedback.lightImpact();
    showSuccessSnackbar(
      context,
      msg ?? '',
    );
  }

  static void error({
    required BuildContext context,
    String? msg,
  }) {
    HapticFeedback.heavyImpact();
    showErrorSnackbar(
      context,
      msg ?? '',
    );
  }
}
