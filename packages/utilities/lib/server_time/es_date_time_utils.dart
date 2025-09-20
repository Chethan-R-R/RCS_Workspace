import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utilities/server_time/app_running_time_tracker.dart';
import 'package:utilities/shared_preferences.dart';
import 'package:utilities/utils.dart';

class ESDateTimeUtils {
  static ESDateTimeUtils? _instance;

  ESDateTimeUtils._internal();

  factory ESDateTimeUtils() => _instance ??= ESDateTimeUtils._internal();

  Future<void> init() async {}

  Future<void> onAppLaunch() async {
    updateElapsedTimeDifferenceInSeconds();
  }

  Future<void> updateElapsedTimeDifferenceInSeconds() async {
    int systemBootTime =
        (await Utils.nativeChannel.invokeMethod('getElapsedTime'));

    int previousStoredBootTime = SharedPrefs().getBootTime();
    if (systemBootTime >= previousStoredBootTime) {
      SharedPrefs().setElapsedBootTimeDifference(
          systemBootTime - previousStoredBootTime);
      AppRunningTime().resetAppRunningTime(); // restarting the stop watch
    } else {
      // TODO FORCE LOGOUT the User
    }
  }

  Future<void> storeServerTime(String serverDateTime) async {
    SharedPrefs().setServerTime(serverDateTime);

    int systemBootTime =
        (await Utils.nativeChannel.invokeMethod('getElapsedTime'));

    SharedPrefs().setBootTime((systemBootTime - 1));
    updateElapsedTimeDifferenceInSeconds();

    Utils.print(
        "*** Server time captured **** $serverDateTime ***** bootTme *** $systemBootTime");
  }

  Future<DateTime> getDateTime() async {
    final DateFormat formatter = DateFormat("yyyy/MM/dd hh:mm:ss aa", "en_US");
    try {
      String serverTime = SharedPrefs().getServerTime();
      DateTime? storedDateTime = formatter.tryParse(serverTime);

      if (storedDateTime == null) {
        return DateTime.now();
      }

      int systemBootTime =
          (await Utils.nativeChannel.invokeMethod('getElapsedTime'));

      int previousStoredBootTime = SharedPrefs().getBootTime();
      DateTime currentDateTime = storedDateTime
          .add(Duration(seconds: systemBootTime - previousStoredBootTime));

      return currentDateTime;
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      // This case never occur in life time
      return DateTime.now();
    }
  }

  DateTime getDateTimeSync() {
    final DateFormat formatter = DateFormat("yyyy/MM/dd hh:mm:ss aa", "en_US");
    try {
      String serverTime = SharedPrefs().getServerTime();
      DateTime? storedDateTime = formatter.tryParse(serverTime);

      if (storedDateTime == null) {
        return DateTime.now();
      }

      DateTime currentDateTime = storedDateTime.add(Duration(
          seconds: AppRunningTime().getAppRunningTimeInSeconds() +
              SharedPrefs().getElapsedBootTimeDifference()));

      return currentDateTime;
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      // This case never occur in life time
      return DateTime.now();
    }
  }

  DateTime getCurrentDateTimeWithFormat(String format) {
    final DateFormat formatter = DateFormat(format, "en_US");

    try {
      var currentDate = formatter.format(getDateTimeSync());
      return getDateTimeWithFormat(format, currentDate);
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return formatter.parse(DateTime.now().toString());
    }
  }

  String getCurrentDateTimeStringWithFormat(String format) {
    final DateFormat formatter = DateFormat(format, "en_US");

    try {
      return formatter.format(getDateTimeSync());
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return formatter.format(DateTime.now());
    }
  }

  String getDateTimeStringWithDate(String format, DateTime dateTime) {
    final DateFormat formatter = DateFormat(format, "en_US");

    try {
      return formatter.format(dateTime);
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return formatter.format(DateTime.now());
    }
  }

  DateTime getDateTimeWithFormat(String format, String dateTime) {
    if (dateTime.isEmpty) {
      return DateTime.now();
    }
    final DateFormat formatter = DateFormat(format, "en_US");

    try {
      dateTime = dateTime.replaceAll("p.m.", "PM");
      dateTime = dateTime.replaceAll("a.m.", "AM");
      return formatter.parse(dateTime);
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return DateTime.now();
    }
  }

  String getFormatedDateTimeStringWithFormat(
      String format, String dateTimeString) {
    final DateFormat formatter = DateFormat(format, "en_US");

    try {
      dateTimeString = dateTimeString.replaceAll("p.m.", "PM");
      dateTimeString = dateTimeString.replaceAll("a.m.", "AM");
      return formatter.format(formatter.parse(dateTimeString));
    } catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return formatter.format(DateTime.now());
    }
  }

  bool isStartTimeGreaterThanOrEqualToCurrentTime(
      TimeOfDay selectStartTime, DateTime selectedDate) {
    final currentTime = ESDateTimeUtils().getDateTimeSync();
    final currentHour = currentTime.hour;
    final currentMinute = currentTime.minute;
    final startHour = selectStartTime.hour;
    final startMinute = selectStartTime.minute;
    bool isToday = selectedDate.year == currentTime.year &&
        selectedDate.month == currentTime.month &&
        selectedDate.day == currentTime.day;
    if (isToday) {
      if (startHour > currentHour) {
        return true; // Start time is greater than the current time
      } else if (startHour == currentHour && startMinute >= currentMinute) {
        return true; // Start time is equal or greater than the current time (same hour, but minutes are equal or greater)
      } else {
        return false; // Start time is less than the current time
      }
    } else {
      return true;
    }
  }

  bool isEndTimeGreaterThanOrEqualToStartTime(TimeOfDay startTime,
      TimeOfDay endTime, DateTime startDate, DateTime endDate) {
    final startHour = startTime.hour;
    final startMinute = startTime.minute;
    final endHour = endTime.hour;
    final endMinute = endTime.minute;
    if (endDate.isAfter(startDate)) {
      return true;
    } else {
      if (endTime.hour > startTime.hour) {
        return true;
      } else if (endTime.hour == startTime.hour &&
          endTime.minute > startTime.minute) {
        return true;
      }
      return false;
    }
    if (endHour > startHour) {
      return true; // End time is greater than start time (later hour)
    } else if (endHour == startHour && endMinute > startMinute) {
      return true; // End time is equal or greater than start time (same hour, but minutes are equal or greater)
    } else {
      return false; // End time is less than start time
    }
  }
}
