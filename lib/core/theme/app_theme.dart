import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Class for storing Theme data .

class AppTheme {
  /// ThemeData for DarkMode .
  static ThemeData hougakuTheme = ThemeData(
    fontFamily: 'Proxima',
    hoverColor: Colors.white,
    primaryColorDark: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontFamily: 'Proxima Bold',
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        fontSize: 12.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 9.sp,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    primarySwatch: Colors.deepPurple,
  );

  /// ThemeData for LightMode .
  static ThemeData hougakuThemeLight = ThemeData(
    primarySwatch: Colors.purple,
    hoverColor: Colors.white54,
    primaryColorDark: Colors.black,
    fontFamily: 'Proxima',
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 18.sp,
        fontFamily: 'Proxima Bold',
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        fontSize: 12.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 9.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );
}
