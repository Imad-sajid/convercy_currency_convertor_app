import 'package:Convertify/app_utils/app_colors.dart';
import 'package:Convertify/app_utils/app_strings.dart';
import 'package:Convertify/core/locale_provider.dart';
import 'package:Convertify/core/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    // Debug prints to check the current locale and items
    final items = <Locale>[
      const Locale('en', ''),
      const Locale('ar', ''),
      const Locale('de', ''),
      const Locale('es', ''),
    ];
    Locale initialLocale = items.firstWhere(
      (locale) => locale == localeProvider.locale,
      orElse: () => items.first,
    );

    // Define flag icons for each language (these are placeholders)
    Map<String, String> flagIcons = {
      'en': AppStrings.usa,
           // Example icons, replace with appropriate flag icons
      'ar': AppStrings.ksa,
      'de': AppStrings.germany,
      'es': AppStrings.spain,
    };
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DropdownButton<Locale>(
      value: initialLocale,
      icon:  Icon(Icons.arrow_drop_down, color: themeProvider.isDarkMode?Colors.blue:AppColors.black,), // Icon for the dropdown button
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          localeProvider.setLocale(newLocale);
        }
      },
      items: items.map<DropdownMenuItem<Locale>>((Locale locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: SizedBox(height: 24, width: 18,child: Image.asset(flagIcons[locale.languageCode].toString())), // Display flag icon based on language code
        );
      }).toList(),
    );
  }
}
