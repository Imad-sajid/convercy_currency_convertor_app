import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchHistoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _searchHistory = [];

  List<Map<String, dynamic>> get searchHistory => _searchHistory;

  SearchHistoryProvider() {
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final searchHistoryString = prefs.getString('searchHistory') ?? '[]';
    _searchHistory = List<Map<String, dynamic>>.from(json.decode(searchHistoryString));
    notifyListeners();
  }

  Future<void> saveSearch(String fromCurrency, String toCurrency, String amount, double rate) async {
    final prefs = await SharedPreferences.getInstance();
    final convertedAmount = (double.parse(amount) * rate).toStringAsFixed(2);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final searchEntry = {
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'amount': double.parse(amount),
      'convertedAmount': convertedAmount,
      'timestamp': timestamp,
    };

    if (rate != 0.00) {
      _searchHistory.add(searchEntry);
    }

    await prefs.setString('searchHistory', json.encode(_searchHistory));
    notifyListeners();
  }

  Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory.clear();
    await prefs.remove('searchHistory');
    notifyListeners();
  }
}
