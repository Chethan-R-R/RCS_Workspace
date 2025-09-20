import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:utilities/network_utility/app_connectivity.dart';
import 'package:utilities/server_time/es_date_time_utils.dart';
import 'package:utilities/utils.dart';

import 'URLs.dart';
import 'config.dart';
import 'crypto_utils.dart';
import 'data_classes/common_response.dart';



class APIService {
  bool encryptionRequired = true;

  Future<CommonResponse?> post(String url, Map<String, dynamic> body,
      {int defaultTimeoutDuration = 40}) async {
    try {
      final uri = Uri.parse(url);
      try {
        // String jsonBody = json.encode(body);
        String jsonInputString = json.encode(body).toString();

        final encoding = Encoding.getByName('utf-8');

        var startTime = DateTime.now();

        Map<String, dynamic> encryptedJson = {
          "data": encryptionRequired
              ? Crypto.encrypt(jsonInputString)
              : jsonInputString,
          "alg": encryptionRequired ? "hash" : "hulk encryption"
        };
        String encryptedBody = json.encode(encryptedJson);

        /*Utils.print(
            "URL: $url input: $jsonInputString headers${_getHeaders()}");*/

        http.Response? response;

        try {
          response = await http
              .post(
            uri,
            headers: _getHeaders(),
            body: encryptedBody,
            encoding: encoding,
          )
              .timeout(Duration(seconds: defaultTimeoutDuration),
                  onTimeout: () {
            return http.Response("TimeOut", 500);
          });
        } catch (e) {
          Utils.print(e.toString());
        }

        if (response == null ||
            response.statusCode == 500 ||
            response.body.isEmpty) {
          if (AppConnectivity().isConnected) {
            response = await http
                .post(
                  uri,
                  headers: _getHeaders(),
                  body: encryptedBody,
                  encoding: encoding,
                )
                .timeout(
                  const Duration(seconds: 20), // on second try
                );
          }
        }

        var endTime = DateTime.now();

        Duration difference = endTime.difference(startTime);

        if (response?.statusCode == 200) {
          String body = response?.body ?? "";

          //Utils.print(
          //"URL: $url pure output: ${response.statusCode} body -- $body  ");
          CommonResponse? commonResponse;
          if (body.trim().isEmpty) return null;
          try {
            commonResponse = CommonResponse.fromMap(json.decode(body));
            commonResponse.data = encryptionRequired
                ? (Crypto.decrypt(commonResponse.data ?? "") ?? "")
                : (commonResponse.data ?? "");

            if (!_isCachedApiCall(url) &&
                commonResponse.serverDateTime?.isNotEmpty == true) {
              Utils.print(
                  "***Server Date Time -- ${commonResponse.serverDateTime} -- $url");
              ESDateTimeUtils()
                  .storeServerTime(commonResponse.serverDateTime ?? "");
            }

            Utils.print(
                "URL: $url milliSeconds:${difference.inMilliseconds} input: $jsonInputString output: ${response?.statusCode} body -- ${commonResponse.data}  ");
          } catch (e, stackTrace) {
            Utils.printCrashError(
                "URL: $url output:on catchBlock  ${response?.statusCode} body -- ${commonResponse?.data}  ",
                stacktrace: stackTrace);
          }
          return commonResponse;
        } else {
          Utils.print(
              "URL: $url statusCode: ${response?.statusCode} response body ${response?.body ?? "Empty body"}  ");
        }
      } catch (e, stackTrace) {
        Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      }

      return null;
    } on Exception catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return null;
    }
  }

  bool _isCachedApiCall(String url) {
    String method = url.replaceAll(Config.baseURL, "");
    method = method.replaceAll(Config.baseUploadURL, "");

    switch (method) {
      case Urls.getTopics:
      case Urls.getRecommendedLearningResources:
      case Urls.getRecommendedLessonPlanDetails:
      case Urls.getChapterPlanDetails:
      case Urls.getRecommendedAssessments:
      case Urls.getLearningTools:
      case Urls.getModuleCodes:
      case Urls.getDisclaimers:
      case Urls.getAssessmentTypes:
      case Urls.getThemes:
        return true;
      default:
        return false;
    }
  }

  Future<CommonResponse?> get(String url,
      {int defaultTimeoutDuration = 40}) async {
    try {
      final uri = Uri.parse(url);
      try {
        var response = await http
            .get(uri, headers: _getHeaders())
            .timeout(Duration(seconds: defaultTimeoutDuration));

        if (response.statusCode == 200) {
          Utils.print(
              "URL: $url output: ${response.statusCode} body -- ${response.body}  ");

          String body = response.body;
          CommonResponse? commonResponse;
          if (body.trim().isEmpty) return null;
          try {
            commonResponse = CommonResponse.fromMap(json.decode(body));

            commonResponse.data = encryptionRequired
                ? (Crypto.decrypt(commonResponse.data ?? "") ?? "")
                : (commonResponse.data ?? "");

            if (!_isCachedApiCall(url) &&
                commonResponse.serverDateTime?.isNotEmpty == true) {
              ESDateTimeUtils()
                  .storeServerTime(commonResponse.serverDateTime ?? "");
            }
          } catch (e, stackTrace) {
            Utils.printCrashError(e.toString(), stacktrace: stackTrace);
          }
          return commonResponse;
        } else {
          Utils.print(
              "URL: $url statusCode: ${response.statusCode} response body ${response.body}  ");
        }
      } catch (e, stackTrace) {
        Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      }

      return null;
    } on Exception catch (e, stackTrace) {
      Utils.printCrashError(e.toString(), stacktrace: stackTrace);
      return null;
    }
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      /*HttpHeaders.authorizationHeader:
          'Bearer ${SharedPrefs().getStringValueForKey(ApiKey.authToken).trim()}',
      'SessionID': SharedPrefs().getStringValueForKey(ApiKey.sessionId).trim(),*/
    };
  }
}
