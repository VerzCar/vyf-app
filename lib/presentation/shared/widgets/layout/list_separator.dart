import 'package:flutter/material.dart';
import 'package:vote_your_face/theme.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Divider(
      height: 10,
      thickness: 3,
      color: themeData.colorScheme.blackColor,
    );
  }
}
