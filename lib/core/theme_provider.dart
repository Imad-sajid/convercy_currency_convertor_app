import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
   bool _isDarkMode = true; // Declare _isDarkMode as late or nullable

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemeMode(); // Ensure _loadThemeMode is called to initialize _isDarkMode
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false; // Initialize _isDarkMode
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark; // Update _isDarkMode
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode); // Save _isDarkMode to SharedPreferences
    notifyListeners();
  }
   bool firstTimeOnboarding = true;

  Future<void> getScreen(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('firstTimeOnboarding') ?? true) {
      firstTimeOnboarding = true;
    } else {
      firstTimeOnboarding = false;
    }
    notifyListeners();
    // return firstTimeOnboarding;
    
  }
}
