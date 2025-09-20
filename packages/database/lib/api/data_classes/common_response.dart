import 'package:database/api/api_keys.dart';

class CommonResponse {
  String? data = "";
  String? serverDateTime = "";

  CommonResponse.fromMap(Map<String, dynamic> map)
      : data = map["data"] ?? "",
        serverDateTime = map["serverDateTime"]?.toString().trim() ?? "";
}

class CommonResponseWithStatusCode {
  String statusCode = "";
  String status = "";

  CommonResponseWithStatusCode.fromMap(Map<String, dynamic> map)
      : statusCode = map[ApiKey.statusCode] ?? "",
        status = map[ApiKey.status] ?? "";

  Map<String, dynamic> toMap() {
    return {ApiKey.statusCode: statusCode, ApiKey.status: status};
  }
}

class ResponseWithStatusCodeAndUserId {
  String statusCode = "";
  String userId = "";

  ResponseWithStatusCodeAndUserId.fromMap(Map<String, dynamic> map)
      : statusCode = map[ApiKey.statusCode] ?? "",
        userId = map[ApiKey.userId] ?? "";

  Map<String, dynamic> toMap() {
    return {ApiKey.statusCode: statusCode, ApiKey.userId: userId};
  }
}
