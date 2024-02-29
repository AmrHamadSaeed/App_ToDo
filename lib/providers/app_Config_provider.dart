import 'package:app_to_do/model/task.dart';
import 'package:flutter/material.dart';

class ProviderConfig extends ChangeNotifier {
  String languageApp = 'en';

  ThemeMode themeApp = ThemeMode.light;
  late Task task;

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
