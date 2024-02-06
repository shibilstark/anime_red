import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  static final _connectivity = Connectivity();

  static Future<bool> checkInernetConnectivity() async {
    final connectionState = (await _connectivity.checkConnectivity());

    switch (connectionState) {
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;

      default:
        return false;
    }
  }

  static StreamController<bool> isInternetConnected = StreamController<bool>();

  static Stream<bool> instantiateListening() async* {
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        isInternetConnected.add(false);
      } else {
        isInternetConnected.add(true);
      }
    });
  }
}
