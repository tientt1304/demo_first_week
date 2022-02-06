import 'package:demo_first_week/presentation/pages/sign_in/sign_in_page.dart';
import 'package:demo_first_week/presentation/pages/sign_up/sign_up_page.dart';
import 'package:demo_first_week/presentation/widgets/main_button.dart';
import 'package:demo_first_week/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  static String routeName = '/GetStartedPage';
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/icons/Logo.png'),
                ),
                const SizedBox(
                  height: 200,
                ),
                MainButton(
                    onTap: () {
                      Navigator.pushNamed(context, SignInPage.routeName);
                    },
                    title: 'Sign In'),
                PrimaryButton(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpPage.routeName);
                    },
                    title: 'Sign Up')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
