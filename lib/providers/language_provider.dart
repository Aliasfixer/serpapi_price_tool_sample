import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language_setting.dart';

class LanguageProvider extends ChangeNotifier {

  LanguageSetting languageSetting = LanguageSetting(Language.en);

  LanguageProvider(){
    loadLanguageSetting();
  }

  Future<void> loadLanguageSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Language language = Language.fromString(prefs.getString('language')?? 'en');
    languageSetting = LanguageSetting(language);
    notifyListeners();
  }

  Future<void> setLanguage(LanguageSetting language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    languageSetting = language;
    prefs.setString('language', language.language.toString());
    notifyListeners();
  }

}