
// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";
  static const FONT_STATUS = 'FONTSTATUS';

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  setFontSize(String fontSize) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(FONT_STATUS, fontSize);
  }

  Future<String> getFontSize() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString(FONT_STATUS)?? 'M';
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? true;
  }
}