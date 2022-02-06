import 'package:demo_first_week/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'FSRegular',
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: mainColor),
      colorScheme: ThemeData().colorScheme.copyWith(secondary: mainColor));
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder({Color borderColor = secondaryColor}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: borderColor),
        gapPadding: 10,
      );

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(borderColor: mainColor),
    border: outlineInputBorder(),
    focusedErrorBorder: outlineInputBorder(borderColor: kWarningColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Colors.black),
      toolbarTextStyle: TextStyle(color: Colors.black, fontSize: 15),
      titleTextStyle: TextStyle(
          color: kTitleColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'FSSemiBold'));
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: secondaryColor),
  );
}
