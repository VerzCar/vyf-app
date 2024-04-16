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
      elevation: 3,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                circle.name,
                style: TextStyle(
                  fontSize: themeData.textTheme.headlineSmall?.fontSize,
                  fontWeight: themeData.textTheme.headlineSmall?.fontWeight,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                circle.description,
                style: TextStyle(
                  fontSize: themeData.textTheme.bodyMedium?.fontSize,
                  fontWeight: themeData.textTheme.bodyMedium?.fontWeight,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
