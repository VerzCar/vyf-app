import 'package:flutter/material.dart';

enum AvatarSize {
  xs,
  sm,
  base,
  md,
  lg,
}

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
    final calculatedSize = _preSize;
    final hasSource = _isNetworkImage;

    return Container(
      width: calculatedSize.width,
      height: calculatedSize.height,
      decoration: hasSource
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white70,
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: hasSource
            ? Image.network(src)
            : Container(
                color: Colors.black87,
                child: Center(
                  child: Text(
                    capitalLetters,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  bool get _isNetworkImage => src.startsWith('http');

  Size get _preSize {
    switch (size) {
      case AvatarSize.xs:
        return const Size(24, 24);
      case AvatarSize.sm:
        return const Size(36, 36);
      case AvatarSize.base:
        return const Size(48, 48);
      case AvatarSize.md:
        return const Size(60, 60);
      case AvatarSize.lg:
        return const Size(72, 72);
    }
  }
}
