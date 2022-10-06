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
    bodyLarge: const TextStyle(fontSize: 18),
    bodyMedium: const TextStyle(fontSize: 16),
    labelLarge: const TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    labelMedium: const TextStyle(
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
    textStyle: const TextStyle(
      color: Colors.blueGrey,
    ),
  );
}
