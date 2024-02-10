import 'package:flutter/material.dart';

class ProviderConfig extends ChangeNotifier {
  String languageApp = 'ar';

  void changeLanguage(String languageNew) {
    if (languageApp == languageNew) {
      return;
    }
    languageApp = languageNew;
    notifyListeners();
  }
}
