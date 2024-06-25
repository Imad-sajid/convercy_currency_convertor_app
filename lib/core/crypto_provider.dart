import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyCryptoProvider with ChangeNotifier {
  double _conversionRate = 1.0;
  bool _isLoading = false;
  String _fromCurrency = 'BTC';
  String _toCurrency = 'XRP';
  int _currentIndex = 0;
  final TextEditingController amountController = TextEditingController();

  bool _swap = false;

  bool get swap => _swap;

  void toggleSwap() {
    _swap = !_swap;
    notifyListeners();
  }

  final List<String> _availableCurrencies = [
    'AED',
    'AFN',
    'ALL',
    'AMD',
    'ANG',
    'AOA',
    'AUD',
    'AZN',
    'BAM',
    'BBD',
    'BDT',
    'BGN',
    'BHD',
    'BIF',
    'BND',
    'BOB',
    'BRL',
    'BSD',
    'BTN',
    'BWP',
    'BYN',
    'BZD',
    'CAD',
    'CDF',
    'CHF',
    'CLP',
    'CNY',
    'COP',
    'CRC',
    'CUP',
    'CVE',
    'CZK',
    'DJF',
    'DKK',
    'DOP',
    'DZD',
    'EGP',
    'ERN',
    'ETB',
    'EUR',
    'FJD',
    'GBP',
    'GEL',
    'GHS',
    'GMD',
    'GNF',
    'GTQ',
    'GYD',
    'HKD',
    'HNL',
    'HRK',
    'HUF',
    'IDR',
    'INR',
    'IQD',
    'IRR',
    'ISK',
    'JMD',
    'JOD',
    'JPY',
    'KES',
    'KGS',
    'KHR',
    'KID',
    'KMF',
    'KRW',
    'KWD',
    'KZT',
    'LAK',
    'LBP',
    'LRD',
    'LSL',
    'LYD',
    'MAD',
    'MDL',
    'MGA',
    'MKD',
    'MMK',
    'MNT',
    'MOP',
    'MRU',
    'MUR',
    'MVR',
    'MWK',
    'MXN',
    'MYR',
    'MZN',
    'NAD',
    'NGN',
    'NIO',
    'NOK',
    'NPR',
    'NZD',
    'OMR',
    'PAB',
    'PHP',
    'PKR',
    'PLN',
    'PYG',
    'QAR',
    'RON',
    'RUB',
    'RWF',
    'SAR',
    'SBD',
    'SCR',
    'SDG',
    'SEK',
    'SGD',
    'SLL',
    'SOS',
    'SRD',
    'SSP',
    'STN',
    'SYP',
    'SZL',
    'THB',
    'TJS',
    'TMT',
    'TND',
    'TOP',
    'TRY',
    'TTD',
    'TWD',
    'TZS',
    'UAH',
    'UGX',
    'USD',
    'UYU',
    'UZS'
  ];

  final List<String> _availableCryptoCurrencies = [
    'ADA',
    'BAT',
    'BCH',
    'BNT',
    'BTC',
    'BTG',
    'DASH',
    'DOT',
    'EOS',
    'ETC',
    'ETH',
    'IOTA',
    'LINK',
    'LTC',
    'NEO',
    'QTUM',
    'USDT',
    'XRP',
    'XLM',
  ];

  // Dispose method to clean up the controller
  @override
  void dispose() {
    amountController.dispose();
    _listenToConnectivityChanges();
    super.dispose();
  }

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners(); // Notify listeners to update UI
  }

  // Getters
  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;
  double get conversionRate => _conversionRate;
  bool get isLoading => _isLoading;
  int get currentIndex =>
      _currentIndex; // Replace _currentIndex with your actual variable name

  List<String> get availableCurrencies => _availableCurrencies;
  List<String> get availableCryptoCurrencies => _availableCryptoCurrencies;

  //Methods
  Future<void> fetchConversionRate(
      String fromCurrency, String toCurrency, bool isConnected) async {
    _isLoading = true;
    notifyListeners();

    try {
      fiatToCrypto(fromCurrency, toCurrency, isConnected);
      _isLoading = false;
    } catch (e) {
      debugPrint('Error fetching conversion rate: $e');
      throw Exception('Failed to fetch conversion rate');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fiatToCrypto(String fromCurrency, String toCurrency, bool isConnected) async {
    if(isConnected){
    try {
      // final now = DateTime.now();
      // final oneDayAgo = DateTime(now.year, now.month, now.day - 1);
      // final formattedDate =
      //     '${oneDayAgo.year}-${oneDayAgo.month.toString().padLeft(2, '0')}-${oneDayAgo.day.toString().padLeft(2, '0')}';

      // Fetch fiat conversion rate
      // final fiatUrl =
      //     'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@$formattedDate/v1/currencies/$fromCurrency.json';
      // final fiatResponse = await http.get(Uri.parse(fiatUrl));

      // if (fiatResponse.statusCode == 200) {
      //   final fiatData = jsonDecode(fiatResponse.body);
      //   final double toUsdRate = fiatData[fromCurrency]['usd'];

      // Fetch crypto conversion rate
      final cryptoUrl =
          'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$fromCurrency.json';
      final cryptoResponse = await http.get(Uri.parse(cryptoUrl));

      if (cryptoResponse.statusCode == 200) {
        final cryptoData = jsonDecode(cryptoResponse.body);
        if (cryptoData.containsKey(fromCurrency) &&
            cryptoData[fromCurrency].containsKey(toCurrency)) {
          _conversionRate = cryptoData[fromCurrency][toCurrency];
          print(_conversionRate.toString());
          _isLoading = false;

          // final double cryptoRate = cryptoData['usd'][toCurrency.toLowerCase()];

          // Calculate the final conversion rate
          // _conversionRate = toUsdRate * cryptoRate;

          // Save conversion data locally
          final prefs = await SharedPreferences.getInstance();
          await prefs.setDouble('conversionRate', _conversionRate);
          await prefs.setString('fromCurrency', fromCurrency);
          await prefs.setString('toCurrency', toCurrency);

          notifyListeners();
        } else{
          throw Exception(
              'Failed to fetch crypto conversion rate. Status code: ${cryptoResponse.statusCode}');
        }
      } else {
        throw Exception(
            'Failed to fetch crypto conversion rate. Status code: ${cryptoResponse.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching fiat to crypto conversion rate: $e');
      throw Exception('Failed to fetch fiat to crypto conversion rate');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }else{
    await fetchStoredData();
  }
  }


  void updateFromCurrency(String currency) {
    _fromCurrency = currency;
    notifyListeners();
  }

  void updateToCurrency(String currency) {
    _toCurrency = currency;
    notifyListeners();
  }

  void swapCurrencies() {
    final String temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;
    notifyListeners();
  }
  Future<void> fetchStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    _conversionRate = prefs.getDouble('conversionRate') ?? 1.0;
    _fromCurrency = prefs.getString('fromCurrency') ?? 'BTC';
    _toCurrency = prefs.getString('toCurrency') ?? 'USD';
    notifyListeners();
  }
  void _listenToConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result != ConnectivityResult.none) {
        fetchStoredData();
      }
    });
}
}