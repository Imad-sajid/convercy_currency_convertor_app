import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default locale
  SharedPreferences? _prefs;

  LocaleProvider() {
    loadLocale();
  }

  Locale get locale => _locale;

 Future<void> loadLocale() async {
  try {
    _prefs = await SharedPreferences.getInstance();
    String? languageCode = _prefs?.getString('locale');
    if (languageCode != null && _localeSupported(Locale(languageCode))) {
      _locale = Locale(languageCode);
    } else {
      _locale = const Locale('en');
    }
  } catch (e) {
    print("Error loading locale: $e");
    _locale = const Locale('en'); // Fallback to default locale
  }
  notifyListeners();
}


  void setLocale(Locale locale) {
    if (!_localeSupported(locale)) return;
    _locale = locale;
    _saveLocale(locale);
    notifyListeners();
  }

  bool _localeSupported(Locale locale) {
    return ['en', 'ar', 'de', 'es'].contains(locale.languageCode);
  }

  void clearLocale() {
    _locale = const Locale('en');
    _prefs?.remove('locale');
    notifyListeners();
  }

  Future<void> _saveLocale(Locale locale) async {
    await _prefs?.setString('locale', locale.languageCode);
  }
}
