import 'package:demo_first_week/presentation/pages/get_started/get_started_page.dart';
import 'package:demo_first_week/presentation/pages/home/home_page.dart';
import 'package:demo_first_week/presentation/pages/sign_in/sign_in_page.dart';
import 'package:demo_first_week/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter/widgets.dart';

final routes = <String, WidgetBuilder>{
  SignInPage.routeName: (context) => const SignInPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  GetStartedPage.routeName: (context) => const GetStartedPage(),
  HomePage.routeName: (context) => const HomePage(),
};
