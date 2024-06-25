// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Currency Converter`
  String get app_title {
    return Intl.message(
      'Currency Converter',
      name: 'app_title',
      desc: 'Title for the application',
      args: [],
    );
  }

  /// `Enter amount`
  String get amount_placeholder {
    return Intl.message(
      'Enter amount',
      name: 'amount_placeholder',
      desc: 'Placeholder text for the amount input field',
      args: [],
    );
  }

  /// `From`
  String get from_currency {
    return Intl.message(
      'From',
      name: 'from_currency',
      desc: 'Label for the currency to convert from',
      args: [],
    );
  }

  /// `To`
  String get to_currency {
    return Intl.message(
      'To',
      name: 'to_currency',
      desc: 'Label for the currency to convert to',
      args: [],
    );
  }

  /// `Converted Amount`
  String get converted_amount {
    return Intl.message(
      'Converted Amount',
      name: 'converted_amount',
      desc: 'Label for the converted amount',
      args: [],
    );
  }

  /// `Search History`
  String get search_history {
    return Intl.message(
      'Search History',
      name: 'search_history',
      desc: 'Label for the search history section',
      args: [],
    );
  }

  /// `No history available`
  String get no_history {
    return Intl.message(
      'No history available',
      name: 'no_history',
      desc: 'Message displayed when there is no search history',
      args: [],
    );
  }

  /// `Clear History`
  String get clear_history {
    return Intl.message(
      'Clear History',
      name: 'clear_history',
      desc: 'Button text for clearing the search history',
      args: [],
    );
  }

  /// `Check Rates`
  String get checkRates {
    return Intl.message(
      'Check Rates',
      name: 'checkRates',
      desc: 'Button text for checking exchange rates',
      args: [],
    );
  }

  /// `Amount`
  String get amountLabel {
    return Intl.message(
      'Amount',
      name: 'amountLabel',
      desc: 'Label for the amount input field',
      args: [],
    );
  }

  /// `Please enter a valid amount`
  String get enterValidAmount {
    return Intl.message(
      'Please enter a valid amount',
      name: 'enterValidAmount',
      desc: 'Message displayed when the entered amount is not valid',
      args: [],
    );
  }

  /// `From`
  String get fromCurrencyLabel {
    return Intl.message(
      'From',
      name: 'fromCurrencyLabel',
      desc: 'Label for the from currency dropdown',
      args: [],
    );
  }

  /// `To`
  String get toCurrencyLabel {
    return Intl.message(
      'To',
      name: 'toCurrencyLabel',
      desc: 'Label for the to currency dropdown',
      args: [],
    );
  }

  /// `Invalid input or rate is zero`
  String get invalidInputOrRateZero {
    return Intl.message(
      'Invalid input or rate is zero',
      name: 'invalidInputOrRateZero',
      desc:
          'Message displayed when the input is invalid or the conversion rate is zero',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
