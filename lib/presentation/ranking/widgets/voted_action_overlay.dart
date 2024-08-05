import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vote_your_face/theme.dart';

class VotedActionOverlay extends StatelessWidget {
  const VotedActionOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: (size.height * 0.98) -
          kBottomNavigationBarHeight -
          (Scaffold.of(context).appBarMaxHeight ?? 0),
      width: size.width * 0.98,
      decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(800),
          ),
          border: Border.all(
            color: themeData.colorScheme.blackColor,
            width: 5.0,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats!',
            style: themeData.textTheme.titleMedium,
          ),
          SvgPicture.asset(
            'assets/svg/vote.svg',
            semanticsLabel: 'voted',
            width: size.width * 0.15,
            height: size.height * 0.15,
          ),
          Text(
            'Your vote has been placed for user x.',
            style: themeData.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
