import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class RankingsBody extends StatelessWidget {
  const RankingsBody({
    super.key,
    required this.circles,
  });

  final List<Circle> circles;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              'Last viewed',
              style: themeData.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 10),
          circles.isNotEmpty
              ? _buildViewedRankingsListView(context)
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }

  ListView _buildViewedRankingsListView(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: circles.length,
      itemBuilder: (BuildContext contextListView, int index) {
        final circle = circles[index];

        return GestureDetector(
          onTap: () => context.router.push(RankingRoute(circleId: circle.id)),
          child: Card(
            key: Key(circle.id.toString()),
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: NetImage(
                      imageSrc: circle.imageSrc,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          circle.name,
                          style: themeData.textTheme.titleMedium,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          circle.description,
                          style: themeData.textTheme.bodySmall,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_forward_ios_outlined),
                        const SizedBox(height: 3),
                        Text.rich(
                          TextSpan(
                            style: themeData.textTheme.labelSmall,
                            children: [
                              const TextSpan(
                                text: 'Active:',
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.circle_rounded,
                                  size: 10,
                                  color: circle.stage == CircleStage.hot
                                      ? themeData.colorScheme.successColor
                                      : themeData.colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 5,
      ),
    );
  }
}
