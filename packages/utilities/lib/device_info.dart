import 'dart:io';

import 'package:flutter/services.dart';
import 'package:utilities/utils.dart';

class DeviceInfo {

  static const MethodChannel _platform = MethodChannel("es_k12_app/nativechannel");

  static Future<bool> isDeviceManager() async{
    bool isRootedDevice = false;
    // bool a = await sendDataPlayServices();
    bool b = await checkDeviceManagerMethod1();
    bool c = await checkDeviceManagerMethod2();
    bool d = await checkDeviceManagerMethod3();
    bool e = await checkDeviceManagerMethod4();
    bool f = await checkDeviceManagerMethod5();
    bool g = await checkForMagiskFiles();
    bool h = await searchForMagiskFiles();
    bool i = await checkForSURights();
    bool j = await executeSUExist();
    bool k = await checkReadWriteFile();
    bool l = await checkReadWriteFile2();
    bool m = await checkIsSELinuxEnforcing();
    bool n = await checkFridaIsRunning();
    bool o = await executeBusyBoxExist();


    isRootedDevice = ( false || b || c || d || e || f || g || h || i || j || k || l || m || n || o);//TODO change it to a instead of false after safety net is implemented
    Utils.print("Is The Device Rooted : $isRootedDevice");
    return isRootedDevice;
  }

  static Future<bool> checkDeviceManagerMethod1() async{
    try{
      final bool isTestDevice = await _platform.invokeMethod("Method1");
      return isTestDevice;
    }on PlatformException catch(e,stackTrace){
      Utils.printCrashError("Method 1 Channel Platform Error : ${e.toString()}",stacktrace: stackTrace);
      return false;
    }
  }
  static Future<bool> checkDeviceManagerMethod2() async {
    try {
      final bool hasRootFiles = await _platform.invokeMethod('Method2');
      return hasRootFiles;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Method 2 Channel Platform Error : '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }
  static Future<bool> checkDeviceManagerMethod3() async {
    try {
      final bool hasSuCommand = await _platform.invokeMethod('Method3');
      return hasSuCommand;
    } on PlatformException catch (e, stackTrace) {
      Utils.printCrashError("Method 3 Channel Platform Error : '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }
  static Future<bool> checkDeviceManagerMethod4() async {
    try {
      final bool hasRootApps = await _platform.invokeMethod('Method4');
      return hasRootApps;
    } on PlatformException catch (e, stackTrace) {
      Utils.printCrashError("Method 4 Channel Platform Error : '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }
  static Future<bool> checkDeviceManagerMethod5() async {
    try {
      final bool hasWritablePaths = await _platform.invokeMethod('Method5');
      return hasWritablePaths;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Method 5 Channel Platform Error: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }
  static Future<bool> checkForMagiskFiles() async {
    try {
      final bool hasMagiskFiles = await _platform.invokeMethod('checkForMagiskFiles');
      return hasMagiskFiles;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Failed to check for Magisk files: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> searchForMagiskFiles() async {
    try {
      final bool hasMagiskFiles = await _platform.invokeMethod('searchForMagisk');
      return hasMagiskFiles;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Failed to search for Magisk files: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkForSURights() async {
    try {
      final bool hasSURights = await _platform.invokeMethod('checkForSURights');
      return hasSURights;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Failed to check for SU Rights: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> executeSUExist() async {
    try {
      final bool doesSUExistOrBusyBox = await _platform.invokeMethod('doesSUExist');
      return doesSUExistOrBusyBox;
    } on PlatformException catch (e, stackTrace) {
      Utils.printCrashError("Failed to execute SU Exists: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> executeBusyBoxExist() async {
    try {
      final bool doesSUExistOrBusyBox = await _platform.invokeMethod('doesBusyBoxExist');
      return doesSUExistOrBusyBox;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Failed to execute BusyBox Exists: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkReadWriteFile() async {
    try {
      final bool checkReadWriteFile = await _platform.invokeMethod('checkReadWriteFile');
      return checkReadWriteFile;
    } on PlatformException catch (e, stackTrace) {
      Utils.printCrashError("Failed to check ReadWrite File: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkReadWriteFile2() async {
    try {
      final bool checkReadWriteFile2 = await _platform.invokeMethod('checkReadWriteFile2');
      return checkReadWriteFile2;
    } on PlatformException catch (e, stackTrace) {
      Utils.printCrashError("Failed to check ReadWrite File for 2nd Method: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkIsSELinuxEnforcing() async {
    try {
      final bool checkIsSELinuxEnforcing = await _platform.invokeMethod('checkIsSELinuxEnforcing');
      return checkIsSELinuxEnforcing;
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Failed to check Is SE Linux is Enforcing or not: '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<void> nativeSystemGarbageCollect() async {
    try {
      if(Platform.isAndroid){
        await _platform.invokeMethod('systemGarbageCollect');
      }
    } on PlatformException catch (e,stackTrace) {
      Utils.printCrashError("Failed to collect garbage: '${e.message}'.",stacktrace: stackTrace);
    }
  }

  static Future<bool> checkFridaIsRunning() async {
    try {
      final bool checkFridaIsRunning = await _platform.invokeMethod('checkFridaIsRunning');
      return checkFridaIsRunning;
    } on PlatformException catch (e, stackTrace) {
      Utils.printCrashError("Failed to check Frida is Running or Not : '${e.message}'.",stacktrace: stackTrace);
      return false;
    }
  }
  /*Future<bool> sendDataPlayServices() async {
    if(kDebugMode) return true;
    try{
      Utils.print("SendData Play Services Has been called");
      final bool hasSendDataPlayServiceValue = await _platform.invokeMethod('sendDataPlayServices');
      Utils.print("Has send Data Play Services Value : ${hasSendDataPlayServiceValue}");
      return hasSendDataPlayServiceValue;
    } on PlatformException catch (e,stackTrace){
      Utils.print("Failed to send Data Play Services to google : ${e.toString()}",stacktrace: stackTrace);
      return true;
    }
  }*/

  static Future<bool> isDeviceJailBreak() async {
    //TODO implement Swift Code
    bool isRootedDevice = false;
    bool a = await checkForCydiaAppAndFileSystem();
    bool b = await checkSandBox();
    bool c = await checkIsChoicyExists();
    bool d = await checkIfJailbreakProcessesRunning();
    bool e = await checkIsDebuggerAttached();


    isRootedDevice = ( a || b || c || d || e );//TODO change it to a instead of false after safety net is implemented
    Utils.print("Is The Device Rooted : $isRootedDevice");
    return isRootedDevice;
  }

  static Future<bool> checkForCydiaAppAndFileSystem() async {
    try{
      final bool isDeviceJailBroken = await _platform.invokeMethod("jailBroken");
      Utils.print("check for Cydia App And File System Successfully : $isDeviceJailBroken");
      return isDeviceJailBroken;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To check for Cydia App And File System : ${e.toString()}",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkSandBox() async {
    try{
      final bool isSandBoxInstalled = await _platform.invokeMethod("sandBoxInstalled");
      Utils.print("check SandBox executed Successfully : $isSandBoxInstalled");
      return isSandBoxInstalled;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To check SandBox : ${e.toString()}",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkIsChoicyExists() async {
    try{
      final bool isChoicyExists = await _platform.invokeMethod("isChoicyExists");
      Utils.print("check IsChoicyExists executed Successfully : $isChoicyExists");
      return isChoicyExists;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To check IsChoicyExists : ${e.toString()}",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkIfJailbreakProcessesRunning() async {
    try{
      final bool isJailbreakProcessesRunning = await _platform.invokeMethod("JailbreakProcessesRunning");
      Utils.print("check JailbreakProcessesRunning executed Successfully : $isJailbreakProcessesRunning");
      return isJailbreakProcessesRunning;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To check JailbreakProcessesRunning : ${e.toString()}",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<bool> checkIsDebuggerAttached() async {
    try{
      final bool isDebuggerAttached = await _platform.invokeMethod("DebuggerAttached");
      Utils.print("check IsDebuggerAttached executed Successfully : $isDebuggerAttached");
      return isDebuggerAttached;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To check IsDebuggerAttached : ${e.toString()}",stacktrace: stackTrace);
      return false;
    }
  }

  static Future<double> getFreeDiskSpace() async {
    try{
      final double freeSpaceInMb = await _platform.invokeMethod("getFreeDiskSpace");
      Utils.print("Free disk space available : $freeSpaceInMb");
      return freeSpaceInMb;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To get Free disk space available : ${e.toString()}",stacktrace: stackTrace);
      return -1.0;
    }
  }

  static Future<double> getAvailableRam() async {
    try{
      final double freeRamInMb = await _platform.invokeMethod("getAvailableRam");
      Utils.print("Free RAM available : $freeRamInMb");
      return freeRamInMb;
    } on PlatformException catch(e, stackTrace){
      Utils.printCrashError("Failed To get Free RAM available : ${e.toString()}",stacktrace: stackTrace);
      return -1.0;
    }
  }
}