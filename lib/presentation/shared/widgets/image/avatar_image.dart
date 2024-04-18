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
    return Container(
      width: calculatedSize.width,
      height: calculatedSize.height,
      decoration: _isNetworkImage ? BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.blue,
      ) : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(src),
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
