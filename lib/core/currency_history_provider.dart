// import 'dart:convert';
// import 'package:Convertify/models/currency_history_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

// class CurrencyHistoryProvider with ChangeNotifier {
//   List<CurrencyHistoryModel> _currencyHistory = []; // Initialize as empty list
//   bool _isLoading = false;

//   List<CurrencyHistoryModel> get currencyHistory => _currencyHistory;
//   bool get isLoading => _isLoading;

//   String getApiKey() {
//     return dotenv.DotEnv().env['API_KEY'] ?? '';
//   }
//   final String baseUrl = 'https://www.alphavantage.co/query/';

//   Future<void> fetchCurrencyHistory(
//       String fromCurrency, String toCurrency) async {
//     _isLoading = true;
//     notifyListeners();

//     final url = Uri.parse(
//         'https://www.alphavantage.co/query/?function=FX_MONTHLY&from_symbol=USD&to_symbol=PKR&apikey=87ESY6T0ITKRYYN1');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final timeSeries =
//           data['Time Series FX (Monthly)'] as Map<String, dynamic>;

//       List<CurrencyHistoryModel> currencyHistory = [];
//       timeSeries.forEach((date, value) {
//         currencyHistory.add(
//             CurrencyHistoryModel.fromJson(value as Map<String, dynamic>, date));
//       });

//       _currencyHistory = currencyHistory;
//     } else {
//       throw Exception('Failed to load currency data');
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
