import 'package:flutter/cupertino.dart';

enum LanguageCode { zh, en }

class AppLanguageProvider extends ChangeNotifier {
  LanguageCode languageCode = LanguageCode.en;

  changeLanguage(LanguageCode languageCode) {
    this.languageCode = languageCode;
    notifyListeners();
  }
}
