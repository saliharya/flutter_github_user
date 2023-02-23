import 'package:flutter/material.dart';

class CustomHeroNetworkImage extends StatelessWidget {
  final String imgUrl;
  final ImageShape imageShape;

  const CustomHeroNetworkImage({
    Key? key,
    required this.imgUrl,
    required this.imageShape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imgUrl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          imageShape == ImageShape.circle
              ? 100
              : imageShape == ImageShape.rounded
                  ? 8
                  : 0,
        ),
        child: Image.network(
          imgUrl,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

enum ImageShape { circle, rounded, square }
