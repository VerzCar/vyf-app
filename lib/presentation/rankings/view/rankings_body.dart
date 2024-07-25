import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/theme.dart';

class RankingsBody extends StatelessWidget {
  const RankingsBody({
    super.key,
    required this.lastViewed,
  });

  final List<RankingLastViewed> lastViewed;

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
          lastViewed.isNotEmpty
              ? _buildViewedRankingsListView(context)
              : _buildEmptyViewedRankingsPlaceholder(context),
        ],
      ),
    );
  }

  ListView _buildViewedRankingsListView(BuildContext context) {
    final themeData = Theme.of(context);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: lastViewed.length,
      itemBuilder: (BuildContext contextListView, int index) {
        final rankingViewed = lastViewed[index];

        return GestureDetector(
          onTap: () => context.router
              .push(RankingRoute(circleId: rankingViewed.circle.id)),
          child: Card(
            key: Key(rankingViewed.id.toString()),
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
                      imageSrc: rankingViewed.circle.imageSrc,
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
                          rankingViewed.circle.name,
                          style: themeData.textTheme.titleMedium,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          rankingViewed.circle.description,
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
                                  color: rankingViewed.circle.stage ==
                                          CircleStage.hot
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

  Widget _buildEmptyViewedRankingsPlaceholder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/empty-rankings.svg',
              semanticsLabel: 'Empty last viewed rankings',
              width: size.width * 0.28,
              height: size.height * 0.28,
            ),
            const SizedBox(height: 15),
            Text(
              'There are not any last viewed rankings of circles.',
              style: themeData.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: themeData.colorScheme.secondary,
              ),
              onPressed: () => context.router.navigateNamed('/circles'),
              child: const Text('Go to circles and see the current ranking'),
            ),
          ],
        ),
      ),
    );
  }
}
