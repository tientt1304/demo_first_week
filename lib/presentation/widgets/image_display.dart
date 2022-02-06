import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final double width, height;
  final String path;
  final VoidCallback onTap;
  final int seed;
  const ImageDisplay(
      {Key? key,
      required this.width,
      required this.height,
      required this.path,
      required this.onTap,
      required this.seed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: '$seed',
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/loading.gif',
          image: path,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
