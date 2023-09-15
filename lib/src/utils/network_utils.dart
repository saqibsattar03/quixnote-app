import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class NetworkUtils {
  NetworkUtils._();

  static final _instance = NetworkUtils._();

  static NetworkUtils get instance => _instance;

  void initialize() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  final _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  var _isEthernetReconnect = false;

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        if (!_isEthernetReconnect) return;
        SnackBarService.instance.showSnackBar(
          'Internet Connection Restored',
        );
        break;
      default:
        _isEthernetReconnect = true;
        SnackBarService.instance.showSnackBar(
          'Internet Connection Not Available',
        );
        break;
    }
  }

  void onClose() {
    _connectivitySubscription.cancel();
  }
}

class SnackBarService {
  SnackBarService._();

  static final _instance = SnackBarService._();

  static SnackBarService get instance => _instance;
  static final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldKey =>
      _scaffoldMessengerKey;

  Future<void> showSnackBar(String title) async {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(title),
        backgroundColor: AppColors.primaryYellow,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
