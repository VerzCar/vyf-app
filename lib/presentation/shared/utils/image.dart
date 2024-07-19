import 'package:flutter/material.dart';

class SecureNetImage {
  SecureNetImage._({
    required this.imageSrc,
    this.fit,
    this.placeholderPath,
  });

  final String imageSrc;
  final BoxFit? fit;
  final String? placeholderPath;

  static Image image({
    required String imageSrc,
    BoxFit? fit,
    String? placeholderPath,
  }) {
    return SecureNetImage._(
      imageSrc: imageSrc,
      fit: fit,
      placeholderPath: placeholderPath,
    )._image();
  }

  Image _image() {
    return imageSrc.isEmpty ? _placeholderImage() : _networkImage();
  }

  Image _placeholderImage() {
    return Image.asset(
      _placeholderSrc(),
      fit: fit,
    );
  }

  Image _networkImage() {
    return Image.network(
      imageSrc,
      fit: fit,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              _placeholderImage(),
    );
  }

  String _placeholderSrc() {
    return placeholderPath == null
        ? 'assets/placeholder/placeholder_img_1.png'
        : placeholderPath!;
  }
}
