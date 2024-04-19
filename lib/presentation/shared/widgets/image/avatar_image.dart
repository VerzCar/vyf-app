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
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white70,
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: hasSource
            ? Image.network(
                src,
                fit: BoxFit.cover,
              )
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
}
