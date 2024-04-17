import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({
    super.key,
    required this.circle,
  });

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: () {
        context.router.push(CircleRoute(circleId: circle.id));
      },
      child: Card.outlined(
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
            ListTile(
              title:Text(
                circle.name,
                style: TextStyle(
                  fontSize: themeData.textTheme.headlineSmall?.fontSize,
                  fontWeight: themeData.textTheme.headlineSmall?.fontWeight,
                ),
              ),
              subtitle: Text(
                circle.description,
                style: TextStyle(
                  fontSize: themeData.textTheme.bodyMedium?.fontSize,
                  fontWeight: themeData.textTheme.bodyMedium?.fontWeight,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
