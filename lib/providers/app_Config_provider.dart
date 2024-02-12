import 'package:flutter/material.dart';

class ProviderConfig extends ChangeNotifier {
  String languageApp = 'ar';
  ThemeMode themeApp = ThemeMode.light;

  void changeLanguage(String languageNew) {
    if (languageApp == languageNew) {
      return;
    }
    languageApp = languageNew;
    notifyListeners();
  }

  void changeTheme(ThemeMode themeNew) {
    if (themeApp == themeNew) {
      return;
    }
    themeApp = themeNew;
    notifyListeners();
  }

  bool isDarkMode() {
    return themeApp == ThemeMode.dark;
  }
}
