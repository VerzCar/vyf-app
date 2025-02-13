import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({
    super.key,
    required this.circle,
  });

  final Circle circle;
  static final BorderRadius _borderRadius = BorderRadius.circular(10.0);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      borderRadius: _borderRadius,
      onTap: () {
        context.router.push(CircleRoute(circleId: circle.id));
      },
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
              title: Text(
                circle.name,
                style: themeData.textTheme.headlineSmall
                    ?.copyWith(overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(
                circle.description,
                style: themeData.textTheme.bodyMedium
                    ?.copyWith(overflow: TextOverflow.ellipsis),
              ),
              trailing: circle.stage == CircleStage.closed
                  ? const BannerText(msg: 'closed')
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
