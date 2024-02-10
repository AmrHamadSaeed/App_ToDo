import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffffffff);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color greyColor = Color(0xff707070);
  static Color backgroundDark = Color(0xff060E1E);
  static Color backgroundLight = Color(0xffc5d5bf);
  static Color greyDarkColor = Color(0xff141922);
  static Color blackColor = Color(0xff383838);
  static Color colorInput = Color(0xffCDCACA);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: blackColor),
      titleSmall: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: blackColor,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: whiteColor,
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
        side: BorderSide(color: MyTheme.whiteColor, width: 4),
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: primaryColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        side: BorderSide(color: MyTheme.greyDarkColor, width: 1),
      ),
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
        titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: whiteColor,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: backgroundDark,
        ),
      ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
        unselectedItemColor: whiteColor,
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
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: greyDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          side: BorderSide(color: MyTheme.greyDarkColor, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: colorInput,
        ),
      ));
}
