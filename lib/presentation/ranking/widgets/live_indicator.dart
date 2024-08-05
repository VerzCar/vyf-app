import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class LiveIndicator extends StatelessWidget {
  const LiveIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Text.rich(
      TextSpan(
        style: themeData.textTheme.labelSmall,
        children: const [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Fading(
              repeat: true,
              reverse: true,
              child: Icon(
                Icons.circle_rounded,
                size: 10,
                color: Colors.green,
              ),
            ),
          ),
          TextSpan(
            text: ' Live',
          ),
        ],
      ),
    );
  }
}
