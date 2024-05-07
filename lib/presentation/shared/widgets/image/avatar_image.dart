import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/shared/shared.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    required this.src,
    this.capitalLetters = '',
    this.size = AvatarSize.base,
  });

  final AvatarSize size;
  final String src;
  final String capitalLetters;

  @override
  Widget build(BuildContext context) {
    final preSize = size.preSize;
    final hasSource = _isNetworkImage;

    return Container(
      width: preSize.width,
      height: preSize.height,
      decoration: hasSource
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(6.5),
              color: Colors.white70,
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.5),
        child: hasSource
            ? Image.network(
                src,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              )
            : Container(
                color: Colors.black87,
                child: Center(
                  child: Text(
                    capitalLetters.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: _fontSize(context),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                ),
              ),
      ),
    );
  }

  bool get _isNetworkImage => src.startsWith('http');

  double? _fontSize(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (size) {
      case AvatarSize.xs:
        return textTheme.bodySmall?.fontSize;
      case AvatarSize.sm:
        return textTheme.bodyMedium?.fontSize;
      case AvatarSize.md:
        return textTheme.bodyLarge?.fontSize;
      case AvatarSize.base:
        return textTheme.titleSmall?.fontSize;
      case AvatarSize.lg:
        return textTheme.titleMedium?.fontSize;
      case AvatarSize.xl:
        return textTheme.titleLarge?.fontSize;
    }
  }
}
