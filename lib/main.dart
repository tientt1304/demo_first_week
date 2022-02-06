import 'package:demo_first_week/helper/theme.dart';
import 'package:demo_first_week/presentation/pages/get_started/get_started_page.dart';
import 'package:demo_first_week/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DemoFirstWeek());
}

class DemoFirstWeek extends StatelessWidget {
  const DemoFirstWeek({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo First Week',
      theme: theme(),
      routes: routes,
      home: const Scaffold(
        body: GetStartedPage(),
      ),
    );
  }
}