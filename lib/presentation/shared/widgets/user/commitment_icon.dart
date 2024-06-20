import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/theme.dart';

class CommitmentIcon extends StatelessWidget {
  const CommitmentIcon({
    super.key,
    required this.commitment,
    this.size,
  });

  final Commitment commitment;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return buildCommitmentIcon(themeData);
  }

  Widget buildCommitmentIcon(ThemeData themeData) {
    var color = themeData.colorScheme.infoColor;
    var icon = Icons.question_mark_outlined;

    switch (commitment) {
      case Commitment.committed:
        {
          color = themeData.colorScheme.successColor;
          icon = Icons.check;
          break;
        }
      case Commitment.rejected:
        {
          color = themeData.colorScheme.error;
          icon = Icons.cancel_outlined;
          break;
        }
      case Commitment.open:
        {
          color = themeData.colorScheme.infoColor;
          icon = Icons.question_mark_outlined;
          break;
        }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: color,
      ),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
