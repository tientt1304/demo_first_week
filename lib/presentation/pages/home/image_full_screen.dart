import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({Key? key, required this.path, required this.tag})
      : super(key: key);
  final String path;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(path),
      ),
      body: SafeArea(
        child: Hero(
          tag: tag.isEmpty ? path : tag,
          child: Image.network(path, width: double.infinity),
          placeholderBuilder: (context, size, widget) {
            return Image.asset('assets/images/loading.gif');
          },
        ),
      ),
    );
  }
}
