import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/routes/router.gr.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/shared/widgets/time/time_box.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class CircleBody extends StatelessWidget {
  const CircleBody({super.key, required this.circle});

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.25,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30.0),
                  ),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: NetImage(
                      imageSrc: circle.imageSrc,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                NetImage(
                  imageSrc: circle.imageSrc,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    style: themeData.textButtonTheme.style?.copyWith(
                      foregroundColor: MaterialStatePropertyAll(
                          themeData.colorScheme.secondary),
                    ),
                    onPressed: () {
                      // https://github.com/Milad-Akarie/auto_route_library/blob/master/auto_route/example/lib/mobile/screens/books/book_details_page.dart
                      //context.navigateTo(RankingRoute(circleId: circle.id));
                      context.tabsRouter
                          .navigate(RankingRoute(circleId: circle.id));
                      // context.router.push(RankingRoute(circleId: circle.id));
                    },
                    child: const Text('Go to Rankings')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Owner',
                            style: themeData.textTheme.titleMedium,
                          ),
                        ),
                        UserAvatar(
                          identityId: circle.createdFrom,
                          option: UserAvatarOption(withLabel: true),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Valid',
                            style: themeData.textTheme.titleMedium,
                          ),
                        ),
                        TimeBox(
                          from: circle.validFrom,
                          until: circle.validUntil,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Description',
                  style: themeData.textTheme.titleMedium,
                ),
                const SizedBox(height: 10.0),
                Text(
                  circle.description,
                  style: themeData.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Members',
                  style: themeData.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
