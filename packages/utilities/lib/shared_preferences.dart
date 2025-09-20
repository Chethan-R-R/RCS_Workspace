import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utilities/server_time/es_date_time_utils.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Common Shared prefs wrapper
 */

class SharedPrefs {
  static SharedPreferences? _prefs;

  static SharedPrefs? _instance;

  SharedPrefs._internal() {
    _initializePrefs();
  }

  factory SharedPrefs() => _instance ??= SharedPrefs._internal();

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Generic for String key value pair Storage

  setStringValue(String key, String value) {
    _prefs?.setString(key, value);
  }

  String getStringValueForKey(String key) => _prefs?.getString(key) ?? '';

  //To manage AppInit
  setAppInitStatus(String userId, {bool value = true}) {
    _prefs?.setBool(userId, value);
  }

  bool getAppInitStatusForUser(String userId) =>
      _prefs?.getBool(userId) ?? false;

  //Specific fields
  static const String _deviceId = "deviceId";

  String getDeviceId() => _prefs?.getString(_deviceId) ?? '';

  setDeviceId(String? deviceId) async {
    _prefs?.setString(_deviceId, deviceId ?? "");
  }

  static const String _username = "username";

  String getUsername() => _prefs?.getString(_username) ?? '';

  setUsername(String username) async {
    _prefs?.setString(_username, username);
  }

  static const String _deepLink = "deepLink";
  String getDeepLink() => _prefs?.getString(_deepLink) ?? '';
  setDeepLinkURL(String url) async {
    _prefs?.setString(_deepLink, url);
  }

  static const String _password = "password";

  String getPassword() => _prefs?.getString(_password) ?? '';

  setPassword(String password) async {
    _prefs?.setString(_password, password);
  }

  setAppInitAPIDownloadStatus(String tag) {
    _prefs?.setBool(tag, true);
  }

  bool checkAppInitAPIDownloadStatus(String tag) {
    return _prefs?.getBool(tag) ?? false;
  }

  static const String _splashDisplayIndex = "splashDisplayIndex"; // 0,1,2
  int getSplashDisplayIndex() => _prefs?.getInt(_splashDisplayIndex) ?? 0;

  setSplashDisplayIndex(int index) async {
    _prefs?.setInt(_splashDisplayIndex, index);
  }

  static const String _lastSyncTime = "lastSyncTime";

  String getLastSyncTime(String? userId, String? classId) =>
      _prefs?.getString('$_lastSyncTime$userId$classId') ?? '';

  setLastSyncTime(String? userId, String? classId) async {
    DateTime currentDateTime = await ESDateTimeUtils().getDateTime();
    String? time =
        DateFormat('dd MMM yyyy hh:mm:ss a').format(currentDateTime).toString();
    _prefs?.setString(('$_lastSyncTime$userId$classId'), time);
  }

  // Server time
  static const String _serverTime = "serverTime";
  String getServerTime() => _prefs?.getString(_serverTime) ?? '';
  setServerTime(String? time) async {
    _prefs?.setString((_serverTime), time ?? "");
  }

  static const String _bootTime = "bootTime";
  int getBootTime() => _prefs?.getInt(_bootTime) ?? 0;
  setBootTime(int? timeInSeconds) async {
    _prefs?.setInt((_bootTime), timeInSeconds ?? 0);
  }

  static const String _previousBootTimeDifferenceInSeconds =
      "previousBootTimeDifferenceInSeconds";
  int getElapsedBootTimeDifference() =>
      _prefs?.getInt(_previousBootTimeDifferenceInSeconds) ?? 0;
  setElapsedBootTimeDifference(int? timeInSeconds) async {
    _prefs?.setInt((_previousBootTimeDifferenceInSeconds), timeInSeconds ?? 0);
  }

  static const String _testFontPercent = "testFontPercent"; // 0,1,2
  double getTestFontPercent() => _prefs?.getDouble(_testFontPercent) ?? 0;

  setTestFontPercent(double percentage) async {
    _prefs?.setDouble(_testFontPercent, percentage);
  }

  static const String _appUpdate = "appUpdateSharedPreferences";
  bool isAppUpdateShowing() => _prefs?.getBool(_appUpdate) ?? true;
  setShowingAppUpdate(bool appUpdateValue) async {
    _prefs?.setBool(_appUpdate, appUpdateValue);
  }

  static const String _autoDownloadPlacementTest =
      "autoDownloadPlacementTestSharedPreferences";
  bool getAutoDownloadPTAndLaunch() =>
      _prefs?.getBool(_autoDownloadPlacementTest) ?? false;
  setAutoDownloadPTAndLaunch(bool autoDownloadValue) async {
    _prefs?.setBool(_autoDownloadPlacementTest, autoDownloadValue);
  }

  static const String _isWelcomeScreenShowing = "_isWelcomeScreenShown";
  bool showWelcomeScreen() => _prefs?.getBool(_isWelcomeScreenShowing) ?? false;
  setShowWelcomeScreen(bool isShow) async {
    _prefs?.setBool(_isWelcomeScreenShowing, isShow);
  }

  static const String _token = "pushNotificationToken";
  String getToken(String userId) => _prefs?.getString("$userId$_token") ?? '';
  setToken(String userId, String token) async {
    _prefs?.setString("$userId$_token", token);
  }

  static const String _tokenUploaded = "pushNotificationTokenUploadStatus";
  int isTokenUploaded(String userId) =>
      _prefs?.getInt("$userId$_tokenUploaded") ?? 0;
  updateTokenUploadedState(String userId, int isUploaded) async {
    _prefs?.setInt("$userId$_tokenUploaded", isUploaded);
  }

  static const String IsPushNotificationClicked = "isClicked";
  bool isPushNotificationClicked() =>
      _prefs?.getBool(IsPushNotificationClicked) ?? false;

  setPushNotificationClicked(bool _isClicked) async {
    _prefs?.setBool(IsPushNotificationClicked, _isClicked);
  }

  String getPushNotification(String key) => _prefs?.getString("FCM$key") ?? "";
  setPushNotificationData(String key, String payload) async {
    _prefs ??= await SharedPreferences
        .getInstance(); // sometimes getting trigger before main loads.. so
    _prefs?.setString("FCM$key", payload);
  }

  clearPushNotification(String key) {
    _prefs?.remove("FCM${key}");
  }

  static const String _firstTimeLoginDateAndTime =
      "firstTimeLoginDateAndTimeSharedPreferences";
  String getFirstTimeLoginDateAndTime(String? userId) =>
      _prefs?.getString("$_firstTimeLoginDateAndTime$userId") ?? "";
  setFirstTimeLoginDateAndTime(String? dateTimeValue, String? userId) async {
    _prefs?.setString(
        "$_firstTimeLoginDateAndTime$userId", dateTimeValue ?? "");
  }

  static const String _playVideoUsingWebView = "playVideoUsingWebView";
  bool playVideoUsingWebView() =>
      _prefs?.getBool(_playVideoUsingWebView) ?? false;
  setPlayVideoUsingWebView(bool value) async {
    _prefs?.setBool(_playVideoUsingWebView, value);
  }

  static const String _isDeviceRooted = "_isDeviceRooted";
  bool getIsDeviceRooted() => _prefs?.getBool(_isDeviceRooted) ?? false;
  setDeviceRooted(bool isShow) async {
    _prefs?.setBool(_isDeviceRooted, isShow);
  }
}
