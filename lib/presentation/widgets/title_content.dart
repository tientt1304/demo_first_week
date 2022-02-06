import 'package:demo_first_week/helper/constants.dart';
import 'package:flutter/material.dart';

class TitleContent extends StatelessWidget {
  const TitleContent({Key? key, required this.title, required this.content})
      : super(key: key);
  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontSize: 28,
                fontFamily: 'FSBold',
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: secondaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
