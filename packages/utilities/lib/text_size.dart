import 'dart:io' show Platform;
import 'dart:math';

import 'package:utilities/utils.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Dynamic text size, 720 pixels is the base height for calculations
 */

class TextSize {
  static double setSp(int size) {
    num newSize = _reduceForSmallDevice(size);
    return Platform.isIOS
        ? (((newSize + 1) / 720) * max(Utils.height, Utils.width))
        : (newSize / 720) * max(Utils.height, Utils.width);
  }
}

class Space {
  static double sp(int size) {
    num newSize = _reduceForSmallDevice(size);
    return (newSize / 720) * max(Utils.height, Utils.width);
  }

  static double spa(int size) {
    num newSize = _reduceForSmallDevice(size);
    return (((newSize / 760) * max(Utils.height, Utils.width)) +
            ((newSize / 393) * min(Utils.height, Utils.width))) /
        2;
  }
}

num _reduceForSmallDevice(int size) {
  if (Utils.isDeviceSmall() && Platform.isAndroid) {
    return size * 0.9;
  } else {
    return size;
  }
}
