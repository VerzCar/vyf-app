import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class MiniCircleCard extends StatelessWidget {
  const MiniCircleCard({
    super.key,
    required this.circle,
  });

  final CirclePaginated circle;
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
        child: Stack(
          children: [
            Column(
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
                    style: themeData.textTheme.titleMedium
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(
                    circle.description,
                    style: themeData.textTheme.bodySmall
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ClipRRect(
                //clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    color: Colors.grey.withOpacity(0.2),
                    child: Text(
                      '$_countOfPeople Members',
                      style: themeData.textTheme.labelSmall?.copyWith(
                        color: themeData.colorScheme.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int get _countOfPeople {
    final int candidatesCount = circle.candidatesCount ?? 0;
    final int votersCount = circle.votersCount ?? 0;
    return candidatesCount + votersCount;
  }
}
