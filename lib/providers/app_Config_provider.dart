import 'package:app_to_do/model/task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderConfig extends ChangeNotifier {
  String languageApp = 'en';
  ThemeMode themeApp = ThemeMode.light;
  late Task task;

  Future<void> changeLanguage(String languageNew) async {
    if (languageApp == languageNew) {
      return;
    }
    languageApp = languageNew;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', languageNew);
    print(prefs.getString('language'));
  }

  Future<void> changeLanguage2(String newSelected, BuildContext context) async {
    if (languageApp == newSelected) {
      return;
    }
    languageApp = newSelected;
    //Todo : set lang in Shared preferences
    // SharedPrefs.setData(context, newSelected);
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', newSelected);
  }

  Future<void> changeTheme(ThemeMode themeNew) async {
    if (themeApp == themeNew) {
      return;
    }
    themeApp = themeNew;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', themeNew == ThemeMode.dark);
  }

  bool isDarkMode() {
    return themeApp == ThemeMode.dark;
  }

  Future<void> getLanguageSP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    if (language != null) {
      languageApp = language;
      notifyListeners();
    }
  }

  Future<void> getThemeSp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('theme');
    if (isDark != null) {
      if (isDark) {
        themeApp = ThemeMode.dark;
      } else {
        themeApp = ThemeMode.light;
      }
      notifyListeners();
    }
  }
}
