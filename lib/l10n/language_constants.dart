import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageValue {
  static const String languageCode = 'languageCode';

  static const String vietnam = 'vi';
  static const String english = 'en';
}

Future<Locale?> saveLocale(String languageCode) async {
  final _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LanguageValue.languageCode, languageCode);
  return localeWithLanguageCode(languageCode);
}

Future<String?> loadLocale() async {
  final _prefs = await SharedPreferences.getInstance();
  final languageCode = _prefs.getString(LanguageValue.languageCode);
  if (languageCode != null) {
    return languageCode;
  }
  final myLocale = ui.window.locale;
  final localeSupport = localeWithLanguageCode(myLocale.toString());
  if (localeSupport.countryCode != null) {
    return '${localeSupport.languageCode}_${localeSupport.countryCode}';
  }
  return localeSupport.languageCode;
}

Locale localeWithLanguageCode(String languageCode) {
  switch (languageCode) {
    case LanguageValue.english:
      return const Locale(LanguageValue.english);
    case LanguageValue.vietnam:
      return const Locale(LanguageValue.vietnam);

    default:
      return const Locale(LanguageValue.vietnam);
  }
}
