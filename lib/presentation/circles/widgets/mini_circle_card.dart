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
  static final BorderRadius _borderRadius = BorderRadius.circular(10.0);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      borderRadius: _borderRadius,
      onTap: () {
        context.router.push(CircleRoute(circleId: circle.id));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Card.outlined(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: _borderRadius,
            ),
            elevation: 4,
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
                    style: themeData.textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(
                    circle.description,
                    style: themeData.textTheme.bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: themeData.cardTheme.color,
            ),
            child: Text(
              '$_countOfPeople Members',
              style: themeData.textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }

  int get _countOfPeople {
    final int candidatesCount = circle.candidatesCount ?? 0;
    final int votersCount = circle.votersCount ?? 0;
    return candidatesCount + votersCount;
  }
}
