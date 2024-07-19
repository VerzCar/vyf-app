import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_your_face/presentation/shared/utils/utils.dart';

class NetImage extends StatelessWidget {
  const NetImage({super.key, required this.imageSrc, this.fit});

  final String imageSrc;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SecureNetImage.image(imageSrc: imageSrc, fit: fit);
  }
}
