import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({
    super.key,
    required this.circle,
  });

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Card.outlined(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                circle.imageSrc,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Text(
              circle.name,
              style: TextStyle(
                fontSize: themeData.textTheme.labelLarge!.fontSize,
                fontWeight: themeData.textTheme.labelLarge!.fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
