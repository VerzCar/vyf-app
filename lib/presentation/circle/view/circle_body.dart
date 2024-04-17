import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vote_circle_repository/vote_circle_repository.dart';

class CircleBody extends StatelessWidget {
  const CircleBody({super.key, required this.circle});

  final Circle circle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Column(
      children: [
        // Container(
        //   height: size.height * 0.40,
        //   width: size.width,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: NetworkImage(circle.imageSrc), fit: BoxFit.contain),
        //   ),
        //   child: Container(
        //     height: size.height * 0.40,
        //     width: size.width,
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: NetworkImage(circle.imageSrc), fit: BoxFit.cover),
        //     ),
        //     child: ClipRect(
        //       child: BackdropFilter(
        //         filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        //         child: Container(
        //           color: Colors.black.withOpacity(0.1),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Container(
          height: size.height * 0.40,
          width: size.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Blurred Background Image
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Image.network(
                  circle.imageSrc,
                  fit: BoxFit.cover,
                ),
              ),
              // Foreground Image
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: size.height * 0.40,
                    child: Image.network(
                      circle.imageSrc,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Text(
                circle.description,
                style: TextStyle(
                  fontSize: themeData.textTheme.bodyMedium?.fontSize,
                  fontWeight: themeData.textTheme.bodyMedium?.fontWeight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
