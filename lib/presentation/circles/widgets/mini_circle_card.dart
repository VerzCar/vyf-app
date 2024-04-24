import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class MiniCircleCard extends StatelessWidget {
  const MiniCircleCard({
    super.key,
    required this.circle,
  });

  final CirclePaginated circle;

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
        elevation: 4,
        surfaceTintColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: NetImage(
                  imageSrc: circle.imageSrc,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(
                circle.name,
                style: TextStyle(
                  fontSize: themeData.textTheme.titleMedium?.fontSize,
                  fontWeight: themeData.textTheme.titleMedium?.fontWeight,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                circle.description,
                style: TextStyle(
                  fontSize: themeData.textTheme.bodySmall?.fontSize,
                  fontWeight: themeData.textTheme.bodySmall?.fontWeight,
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
