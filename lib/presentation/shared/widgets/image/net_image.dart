import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {
  const NetImage({super.key, required this.imageSrc, this.fit});

  final String imageSrc;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return imageSrc.isEmpty ? _placeholderImage() : _networkImage();
  }

  Widget _placeholderImage() {
    return Image.asset(
      _placeholderSrc(),
      fit: fit,
    );
  }

  Widget _networkImage() {
    return Image.network(
      imageSrc,
      fit: fit,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              _placeholderImage(),
    );
  }

  String _placeholderSrc() {
    return 'assets/placeholder/placeholder_img_1.png';
  }
}
