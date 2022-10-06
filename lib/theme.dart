// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers/app_constants.dart';

var appTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor:
          AppConstants.hexToColor(AppConstants.appPrimaryColorGreen)),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromARGB(221, 175, 175, 175),
  ),
  brightness: Brightness.light,
  primaryColor: AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
  primaryColorLight: AppConstants.hexToColor(AppConstants.appPrimaryColorLight),
  dividerColor: AppConstants.hexToColor(AppConstants.appBackgroundColorGray),
  textTheme: TextTheme(
    bodySmall: TextStyle(
        color: AppConstants.hexToColor(AppConstants.appPrimaryFontColorWhite)),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 16),
    labelLarge: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
  fontFamily: GoogleFonts.nunito().fontFamily,
  colorScheme: ColorScheme.light(
    background: AppConstants.hexToColor(AppConstants.appBackgroundColor),
  ),
);

class ThemeTextStyle {
  static TextStyle loginTextFieldStyle = GoogleFonts.lato(
      textStyle: TextStyle(
    color: Colors.blueGrey,
  ));
}
