import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils.dart';

class AppConnectivity {
  AppConnectivity._();

  static AppConnectivity? _singleton;

  factory AppConnectivity() {
    _singleton ??= AppConnectivity._();
    return _singleton!;
  }

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> init() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if ((await _connectivity.checkConnectivity())
        .contains(ConnectivityResult.none)) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
  }

  Future<void> refresh() async {
    if ((await _connectivity.checkConnectivity())
        .contains(ConnectivityResult.none)) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
  }

  bool _isConnected = false;

  bool get isConnected {
    return _isConnected;
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    _isConnected = !(results.contains(ConnectivityResult.none));
    //processPendingRequests();
  }

/*
  List<void Function()> _pendingRequestQueue = [];

  void addToConnectionRetryQueue(void Function() req){
    _pendingRequestQueue.add(req);
  }
  void processPendingRequests(){
    if(isConnected){
      _pendingRequestQueue.forEach((reqMethod) => reqMethod(),);
      _pendingRequestQueue=[];
    }
  }
*/

  void dispose() {
    try {
      _connectivitySubscription.cancel();
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(),stacktrace: stackTrace);
    }
  }
}
