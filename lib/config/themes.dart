import 'package:flutter/material.dart';
darkTheme(context) {
  return ThemeData(
    fontFamily: 'GoogleSansRegular',
    primaryColor: Colors.black,
    accentColor: const Color(0x002A74A5),
    cardColor: const Color(0xff1f2124),
    backgroundColor: const Color(0x00696969),
    canvasColor: Colors.black,
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