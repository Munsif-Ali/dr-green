import 'package:flutter/material.dart';

const secondaryColor = Color(0xFF966F33);
const primaryColor = Color(0xFF62BD69);

final lightTheme = ThemeData(
  // primaryColor: const Color(0xFF966F33),
  // accentColor: const Color(0xFF62BD69),
  colorScheme: const ColorScheme.light(
    secondary: Color(0xFF966F33),
    primary: Color(0xFF62BD69),
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF62BD69), textTheme: ButtonTextTheme.primary),
  // textTheme: const TextTheme(
  //   headline1: TextStyle(color: Color(0xFF966F33), fontSize: 24),
  //   headline2: TextStyle(color: Color(0xFF966F33), fontSize: 22),
  //   headline3: TextStyle(color: Color(0xFF62BD69), fontSize: 20),
  //   bodyText1: TextStyle(color: Color(0xFF62BD69), fontSize: 18),
  //   bodyText2: TextStyle(color: Color(0xFF62BD69), fontSize: 16),
  //   caption: TextStyle(color: Color(0xFF966F33), fontSize: 14),
  //   button: TextStyle(color: Colors.white, fontSize: 18),
  // )
  // ,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 24,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w800),
    displayMedium: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 22,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w800),
    bodyLarge: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 16,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 14,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400),
    labelLarge: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFF62BD69), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFF62BD69), width: 2),
    ),
    // labelStyle: const TextStyle(color: Color(0xFF966F33), fontSize: 18),
    labelStyle: const TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  // primaryColor: const Color(0xFF966F33),
  // accentColor: const Color(0xFF62BD69),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF62BD69),
    secondary: Color(0xFF966F33),
  ),
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF62BD69), textTheme: ButtonTextTheme.primary),
  // textTheme: const TextTheme(
  //   headline1: TextStyle(color: Color(0xFF966F33), fontSize: 24),
  //   headline2: TextStyle(color: Color(0xFF966F33), fontSize: 22),
  //   headline3: TextStyle(color: Color(0xFF62BD69), fontSize: 20),
  //   bodyText1: TextStyle(color: Colors.white, fontSize: 18),
  //   bodyText2: TextStyle(color: Colors.white, fontSize: 16),
  //   caption: TextStyle(color: Color(0xFF966F33), fontSize: 14),
  //   button: TextStyle(color: Colors.white, fontSize: 18),
  // ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 24,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w800),
    displayMedium: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 22,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w800),
    displaySmall: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 20,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 14,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400),
    labelLarge: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFF62BD69), width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFF62BD69), width: 2),
    ),
    // labelStyle: const TextStyle(color: Color(0xFF62BD69), fontSize: 18),
    labelStyle: const TextStyle(
        color: Color(0xFF62BD69),
        fontSize: 18,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0xFF62BD69), width: 2),
    ),
  ),
);
