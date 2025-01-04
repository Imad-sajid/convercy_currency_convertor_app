// lib/routes/app_routes.dart
import 'package:Convertify/presentation/crypto_screen.dart';
import 'package:Convertify/presentation/onboarding_screen.dart';
import 'package:Convertify/presentation/standard_currency_screen.dart';
import 'package:Convertify/presentation/search_history_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // static const String home = '/';

  static const String standardCurrency = '/';
  static const String onboarding = '/onboarding';
  static const String searchHistory = '/searchHistory';
  static const String currencyHistory = '/currencyHistory';
  static const String crypto = '/crypto';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      onboarding : (context) => OnBoardingScreen(),
      standardCurrency: (context) => const StandardCurrencyScreen(),
      searchHistory: (context) => const HistoryScreen(),
      crypto: (context) => CryptoScreen(),
    };
  }
}
