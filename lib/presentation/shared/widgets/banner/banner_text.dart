import 'package:flutter/material.dart';

class BannerText extends StatelessWidget {
  const BannerText({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: themeData.colorScheme.error,
      ),
      child: Text(
        msg,
        style: themeData.textTheme.labelSmall?.copyWith(
          color: themeData.colorScheme.onError,
        ),
      ),
    );
  }
}
