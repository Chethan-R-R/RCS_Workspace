import 'dart:core';

import 'package:database/api/api_keys.dart';
import 'package:database/db/queries/core_queries.dart';
import 'package:utilities/utils.dart';
import 'api/config.dart';
import 'api/data_classes/user_details.dart';
import 'file_directory/file_system.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
type: Singleton
Description: Holds the loggedIn user details through out the app lifecycle
 */

class ActiveUser {
  static ActiveUser? _instance;

  ActiveUser._internal();

  factory ActiveUser() => _instance ??= ActiveUser._internal();

  String? lastSyncTime;
  String? userId;
  String? loginName;
  String? password;
  String? fullName;
  String? firstName;
  String? lastName;
  String? organizationId;
  String? profileImage;


  Future<void> initValues() async {
    _instance = ActiveUser._internal();

    // try {
    //   var userDetails = await CoreQueries().getActiveUser();
    //   if (userDetails.isNotEmpty) {
    //     UserDetails.fromMap(userDetails[0]);
    //
    //     initValuesWithUserDetails();
    //   }
    // } on Exception catch (e, stackTrace) {
    //   Utils.printCrashError(e.toString(),stacktrace: stackTrace);
    // }
  }

  Future<void> initValuesWithUserId(String? userId) async {
    _instance = ActiveUser._internal();

    // try {
    //   var userDetails = await CoreQueries().getUserDetailsForUserId(userId);
    //   if (userDetails.isNotEmpty) {
    //     UserDetails.fromMap(userDetails[0]);
    //
    //     initValuesWithUserDetails();
    //   }
    // } on Exception catch (e, stackTrace) {
    //   Utils.printCrashError(e.toString(),stacktrace: stackTrace);
    // }
  }

  Future<void> initValuesWithUserDetails() async {
    UserDetails details = UserDetails();
    if (UserDetails().userId?.isNotEmpty == true) {
      _instance?.userId = details.userId;
      _instance?.loginName = details.loginName;
      _instance?.password = details.password;
      _instance?.fullName = '${details.firstName} ${details.lastName}';
      _instance?.firstName = details.firstName;
      _instance?.lastName = details.lastName;
      _instance?.organizationId = details.organizationId;
      _instance?.profileImage = details.imagePath;
    }
  }

  void updateDataForForgotPasswordFlow(Map<String, dynamic> json) {
    _instance?.userId = json['userId'];
    _instance?.firstName = json[ApiKey.firstName];
    _instance?.lastName = json[ApiKey.lastName];
  }

  String getProfileImagePath({String? path}) {
    if (path != null) {
      if (path.isNotEmpty == false) {
        return "";
      } else {
        return "${FileSystem.imageDirectory}${path.replaceAll("\\", "/")}";
      }
    } else {
      if (ActiveUser().profileImage?.isNotEmpty == false) {
        return "";
      } else {
        return "${FileSystem.imageDirectory}${ActiveUser().profileImage?.replaceAll("\\", "/")}";
      }
    }
  }
}
