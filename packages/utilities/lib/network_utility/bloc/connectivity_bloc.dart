import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils.dart';
import 'connectivity_state.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Common Network listener utility
 */

class ConnectivityBloc extends Cubit<ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial());

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> init() async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if ((await _connectivity.checkConnectivity())
        .contains(ConnectivityResult.none)) {
      emit(Disconnected());
    } else {
      emit(Connected());
    }
  }

  Future<void> refresh() async {
    if ((await _connectivity.checkConnectivity())
        .contains(ConnectivityResult.none)) {
      emit(Disconnected());
    } else {
      emit(Connected());
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      emit(Disconnected());
    } else {
      emit(Connected());
    }
  }

  void dispose() {
    try {
      _connectivitySubscription.cancel();
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(),stacktrace: stackTrace);
    }
  }
}
