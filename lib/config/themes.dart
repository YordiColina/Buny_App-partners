import 'package:flutter/material.dart';
darkTheme(context) {
  return ThemeData(
    fontFamily: 'GoogleSansRegular',
    primaryColor: const Color(0xFF262626),
    accentColor: const Color(0xFF2A74A5),
    cardColor: const Color(0xff1f2124),
    backgroundColor: const Color(0xff696969),
    canvasColor: const Color(0xFF262626),
    brightness: Brightness.dark,
    buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: const ColorScheme.dark(),
        buttonColor: Colors.blue,
        splashColor: Colors.black),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    textTheme: TextTheme(

    ),
  );
}