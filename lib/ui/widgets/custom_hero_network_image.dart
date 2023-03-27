import 'package:flutter/material.dart';

class CustomHeroNetworkImage extends StatelessWidget {
  final String imgKey;
  final double width;
  final double height;
  final String imgUrl;
  final ImageShape imageShape;

  const CustomHeroNetworkImage({
    Key? key,
    required this.imgKey,
    required this.imgUrl,
    required this.imageShape,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imgKey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          imageShape == ImageShape.circle
              ? 1000
              : imageShape == ImageShape.rounded
                  ? 8
                  : 0,
        ),
        child: Image.network(
          imgUrl,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

enum ImageShape { circle, rounded, square }
