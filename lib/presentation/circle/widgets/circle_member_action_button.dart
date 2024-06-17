import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/circle/widgets/circle_member_action_sheet.dart';

class CircleMemberActionButton extends StatelessWidget {
  const CircleMemberActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showActionsSheet(context),
      child: const Icon(Icons.more_horiz_outlined),
    );
  }

  void _showActionsSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context2) {
        return const SingleChildScrollView(
          child: CircleMemberActionSheet(),
        );
      },
    );
  }
}
