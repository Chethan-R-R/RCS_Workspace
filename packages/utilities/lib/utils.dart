import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:utilities/base_widgets/rcs_text_widget.dart';
import 'package:utilities/server_time/es_date_time_utils.dart';
import 'package:utilities/shared_preferences.dart';
import 'package:utilities/strings.dart';
import 'package:utilities/text_size.dart';

import 'app_images.dart';
import 'base_widgets/common_widgets.dart';
import 'base_widgets/rcs_bottom_sheet.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:package_info_plus/package_info_plus.dart';
/*
Author: Nagaraju.lj
Date: April,2024.
Description: Common Utilities
 */

class Utils {
  static double _height = 720;
  static double _heightPadding = 10;
  static double _width = 560;
  static bool isOfflineApk = false;

  static bool isTv = false;
  static MediaQueryData? mediaQueryData;

  static const int requiredDaysForMandatorySync = 15;
  static const int requiredDaysForAutoSync = 5;
  static const int requiredDaysForUserFeedbackSubmission = 5;

  static Orientation orientation = Orientation.portrait;

  static setDefaultOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  static double get heightPadding {
    return _heightPadding;
  }

  static double get height {
    if (mediaQueryData?.orientation == Orientation.portrait) {
      return max(_height, _width) - _heightPadding;
    }
    return min(_height, _width) - _heightPadding;
  }

  static double get width {
    if (mediaQueryData?.orientation == Orientation.portrait) {
      return min(_height, _width);
    }
    return max(_height, _width);
  }

  static double get statusBarHeight {
    return (mediaQueryData?.padding.top ?? 0);
  }

  static double get commonDivideFactorForSP {
    return mediaQueryData?.devicePixelRatio ?? 1.0;
  }

  static const MethodChannel nativeChannel =
  MethodChannel("es_k12_app/nativechannel");

  static init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    orientation = mediaQueryData?.orientation ?? Orientation.portrait;
    _heightPadding = (mediaQueryData?.padding.bottom ?? 0) +
        (mediaQueryData?.padding.top ?? 0);
    _height = (mediaQueryData?.size.height ?? 0) -
        (mediaQueryData?.padding.top ?? 0) -
        (mediaQueryData?.padding.bottom ?? 0);
    _width = (mediaQueryData?.size.width ?? 0) -
        (mediaQueryData?.padding.left ?? 0) -
        (mediaQueryData?.padding.right ?? 0);
  }

  static updateOrientation(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
  }

  static String getPlatformCode() {
    if (kIsWeb) {
      return "3";
    }
    return Platform.isAndroid ? "2" : "1";
  }

  static void print(String message) {
    debugPrint(message);
  }

  static void printCrashError(String message,
      {required StackTrace? stacktrace}) {
    debugPrint(message);

    if (kDebugMode && stacktrace != null) {
      debugPrintStack(stackTrace: stacktrace);
    } else if (kReleaseMode && stacktrace != null) {
      FirebaseCrashlytics.instance.recordError(message, stacktrace);
      FirebaseCrashlytics.instance.log(message);
    }
  }

  static bool isTab() {
    return min(height, width) > 600;
  }

  static bool isDeviceSmall() {
    return min(height, width) < 360;
  }






  static String formatDate(String date, {bool isTimeRequired = true}) {
    DateFormat inputFormat = DateFormat("yyyy/MM/dd hh:mm a");
    DateFormat outputFormat = isTimeRequired
        ? DateFormat("dd MMM yyyy, hh:mm a")
        : DateFormat("dd MMM yyyy");

    DateTime dateTime = inputFormat.parse(date);
    return outputFormat.format(dateTime);
  }

  static String formatTime(String date) {
    DateFormat inputFormat = DateFormat("yyyy/MM/dd hh:mm a");
    DateFormat outputFormat = DateFormat("hh:mm a");

    DateTime dateTime = inputFormat.parse(date);
    return outputFormat.format(dateTime);
  }



  static String bytesToMb(num? bytes) {
    if (bytes == null || bytes == 0) return "--";
    var value = ((((bytes) / 1024.0)) / 1024.0).toStringAsFixed(1);

    if (double.parse(value) == 0) return "0.1 MB";

    return "$value MB";
  }

  static double bytesToMbDouble(num? bytes) {
    if (bytes == null || bytes == 0) return 0.0;
    return ((((bytes) / 1024.0)) / 1024.0);
  }










  static String formatDateTimeForDbSorting(String columnName) {
    return '''
      (substr($columnName, 1, 11) || CASE WHEN substr($columnName, 18, 2) = 'AM' AND substr($columnName, 12, 2) = '12' THEN '00' WHEN substr($columnName, 18, 2) = 'PM' AND substr($columnName, 12, 2) != '12' THEN printf('%02d', substr($columnName, 12, 2) + 12) ELSE substr($columnName, 12, 2) END || ':' || substr($columnName, 15, 2) )
    ''';
  }

  static String osVersion = "";

  static Future<String> getOSVersion() async {
    if (osVersion.isNotEmpty) {
      return osVersion;
    }

    String appVersion = await getAppVersion();

    var deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      osVersion = "${iosDeviceInfo.systemVersion}-$appVersion";
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      osVersion = "${androidDeviceInfo.version.release}-$appVersion";
      //for android 15 and version 8.0.4-101 ---> 15-8.0.4-101
    }
    return osVersion;
  }

  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}-${packageInfo.buildNumber}";
  }

  static String formatToDecimals(String? input,
      {int decimalPlaces = 2, bool trimEnd = true}) {
    double value = double.tryParse(input?.trim() ?? "0") ?? 0.0;
    if (trimEnd) {
      return value
          .toStringAsFixed(decimalPlaces)
          .replaceAll(RegExp(r'\.?0+$'), '');
    } else {
      return value.toStringAsFixed(decimalPlaces);
    }
  }



  static int? parseIntFromMap(dynamic data) =>
      (data is int) ? data : int.tryParse(data?.toString() ?? "");

  static void closeAllBottomSheets(BuildContext context) {
    for (var element in UI.bottomSheetScaffoldMessengerKeyList) {
      if (element.currentState != null) {
        Navigator.pop(context); // This closes persistent bottom sheets
      }
    }
  }



}

enum ForceSyncType {
  autoSync(0),
  mandatorySync(1),
  none(2);

  const ForceSyncType(this.value);

  final int value;
}
