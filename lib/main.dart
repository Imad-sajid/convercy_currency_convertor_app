import 'package:Convertify/core/connectivity_provider.dart';
import 'package:Convertify/core/country_code_provider.dart';
import 'package:Convertify/core/crypto_provider.dart';
import 'package:Convertify/core/locale_provider.dart';
import 'package:Convertify/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_utils/app_routes.dart';
import 'core/currency_provider.dart';
import '../core/search_history_provider.dart';
import '../core/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
  bool firstTimeOnboarding = prefs.getBool('firstTimeOnboarding') ??
      true; // Default to true for the first launch
  LocaleProvider localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  // runApp(MyApp(isDarkMode: isDarkMode));
  runApp(
      MyApp(isDarkMode: isDarkMode, firstTimeOnboarding: firstTimeOnboarding));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final bool firstTimeOnboarding;

  const MyApp(
      {super.key, required this.isDarkMode, required this.firstTimeOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrencyProvider()),
        ChangeNotifierProvider(create: (_) => SearchHistoryProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => CountryCodeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => CurrencyCryptoProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        final localeProvider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,

          //initial ROUTE
          initialRoute: firstTimeOnboarding
              ? AppRoutes.onboarding
              : AppRoutes.standardCurrency,
          routes: AppRoutes.getRoutes(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            shadowColor: Colors.white,
            brightness:
                themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              displayLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              displayMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
            Locale('de', ''),
            Locale('es', ''),
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      }),
    );
  }
}
