// import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  List<ConnectivityResult> _connectivityResults = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityProvider() {
    _initializeConnectivity();
  }

  List<ConnectivityResult> get connectivityResults => _connectivityResults;

  Future<void> _initializeConnectivity() async {
    _connectivityResults = await Connectivity().checkConnectivity();
    notifyListeners();

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _connectivityResults = results;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
