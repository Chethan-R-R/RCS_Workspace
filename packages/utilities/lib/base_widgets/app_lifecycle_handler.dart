import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.suspendingCallBack,
  });

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    Utils.print('state >>>>>>>>>>>>>>>>>>>>>> : ${state}');
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        await suspendingCallBack();
        break;
    }
  }
}
