import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';
import 'package:vote_your_face/presentation/user-avatar/view/user_avatar_view.dart';

class CircleBody extends StatelessWidget {
  const CircleBody({super.key, required this.circle});

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Column(
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
                  child: Image.network(
                    circle.imageSrc,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Image.network(
                circle.imageSrc,
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
              Text(
                'Owner',
                style: TextStyle(
                  fontSize: themeData.textTheme.titleMedium?.fontSize,
                  fontWeight: themeData.textTheme.titleMedium?.fontWeight,
                ),
              ),
              const SizedBox(height: 10.0),
              UserAvatar(
                identityId: circle.createdFrom,
                option: UserAvatarOption(withLabel: true),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: themeData.textTheme.titleMedium?.fontSize,
                  fontWeight: themeData.textTheme.titleMedium?.fontWeight,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                circle.description,
                style: TextStyle(
                  fontSize: themeData.textTheme.bodyMedium?.fontSize,
                  fontWeight: themeData.textTheme.bodyMedium?.fontWeight,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Members',
                style: TextStyle(
                  fontSize: themeData.textTheme.titleMedium?.fontSize,
                  fontWeight: themeData.textTheme.titleMedium?.fontWeight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
