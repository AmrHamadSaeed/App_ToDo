import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteLight = Color(0xffffffff);
  static Color blackColor = Color(0xff383838);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color greyColor = Color(0xff707070);
  static Color backgroundDark = Color(0xff060E1E);
  static Color backgroundLight = Color(0xffc5d5bf);
  static Color greyDarkColor = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: whiteLight,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(),
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 35,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyTheme.whiteLight, width: 4),
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: primaryColor,
    ),
  );

  /// Dark Theme

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: backgroundDark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteLight,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(style: BorderStyle.solid),
        ),
      ),
      color: greyDarkColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: 35,
      shape: StadiumBorder(
        side: BorderSide(
          width: 5,
          color: greyDarkColor,
        ),
      ),
      backgroundColor: primaryColor,
    ),
    // shadowColor: Colors.green,
  );
}
