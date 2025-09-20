class UserDetails {
  String? statusCode = "";
  String? loginName = "";
  String? password = "";
  String? userId = "";
  String? fullName = "";
  String? schoolCode = "";
  String? schoolName = "";
  String? classId = "";
  String? className = "";
  String? sectionId = "";
  String? sectionName = "";
  String? parentName = "";
  String? parentUserId = "";
  String? mobileNumber = "";
  String? address = "";
  String? imagePath = "";
  String? userType = "";
  String? roleName = "";
  String? dob = "";
  String? firstName = "";
  String? organizationLogo = "";
  String? organizationType = "";
  String? lastName = "";
  String? email = "";
  String? securityQuestion = "";
  String? securityAnswer = "";
  String? admissionNumber = "";
  String? firstTimePasswordUpdated = "";
  String? organizationId = "";
  String? academicStartDate = "";
  String? academicEndDate = "";
  String? yearId = "";
  int active = 0;
  String? termsAndConditionsUrl = "";
  String? termsAndConditionAccepted = "";
  String? educationLevelName = "";
  String? educationLevelId = "";
  String? classCode = "";
  String? classSectionId = "";
  String? allowFirstTimePasswordChange = "";
  String? isUserSessionFeedbackEnabled = "";
  String? isFeedbackSubmitted = "";
  static bool isFirstTimeLoggedIn = false;

  static UserDetails? _instance;
  UserDetails._internal();
  factory UserDetails() => _instance ??= UserDetails._internal();

  factory UserDetails.fromMap(Map<String?, dynamic> map) {
    UserDetails();
    _instance?.loginName = map["loginName"] ?? "";
    _instance?.password = map["password"] ?? "";
    _instance?.userId = map["userId"] ?? "";
    _instance?.fullName = map["fullName"] ?? "";
    _instance?.schoolCode = map["schoolCode"] ?? "";
    _instance?.schoolName = map["schoolName"] ?? "";
    _instance?.classId = map["classId"] ?? "";
    _instance?.className = map["className"] ?? "";
    _instance?.sectionId = map["sectionId"] ?? "";
    _instance?.sectionName = map["sectionName"] ?? "";
    _instance?.parentName = map["parentName"] ?? "";
    _instance?.parentUserId = map["parentUserId"] ?? "";
    _instance?.mobileNumber = map["mobileNumber"] ?? "";
    _instance?.address = map["address"] ?? "";
    _instance?.imagePath = map["imagePath"] ?? "";
    _instance?.userType = map["userType"] ?? "";
    _instance?.roleName = map["roleName"] ?? "";
    _instance?.dob = map["dob"] ?? "";
    _instance?.firstName = map["firstName"] ?? "";
    _instance?.organizationLogo = map["organizationLogo"] ?? "";
    _instance?.organizationType = map["organizationType"] ?? "";
    _instance?.lastName = map["lastName"] ?? "";
    _instance?.email = map["email"] ?? "";
    _instance?.securityQuestion = map["securityQuestion"] ?? "";
    _instance?.securityAnswer = map["securityAnswer"] ?? "";
    _instance?.admissionNumber = map["admissionNumber"] ?? "";
    _instance?.firstTimePasswordUpdated = map["firstTimePasswordUpdated"] ?? "";
    _instance?.organizationId = map["organizationId"] ?? "";
    _instance?.academicStartDate = map["academicStartDate"] ?? "";
    _instance?.academicEndDate = map["academicEndDate"] ?? "";
    _instance?.yearId = map["yearId"] ?? "";
    _instance?.statusCode = map["statusCode"] ?? "";
    _instance?.termsAndConditionsUrl = map["termsAndConditionsUrl"] ?? "";
    _instance?.termsAndConditionAccepted =
        map["isAgreeTermsAndCondition"] ?? "";
    _instance?.educationLevelName = map["educationLevelName"] ?? "";
    _instance?.educationLevelId = map["educationLevelId"] ?? "";
    _instance?.classCode = map["classCode"] ?? "";
    _instance?.classSectionId = map["classSectionId"] ?? "";
    _instance?.allowFirstTimePasswordChange = map["allowFirstTimePasswordChange"] ?? "";
    _instance?.isUserSessionFeedbackEnabled = map["isUserSessionFeedbackEnabled"] ?? "";
    _instance?.isFeedbackSubmitted = map["isFeedbackSubmitted"] ?? "";

    return UserDetails();
  }

  Map<String, dynamic> toMap() {
    return {
      'loginName': loginName,
      'password': password,
      'userId': userId,
      'fullName': fullName,
      'schoolCode': schoolCode,
      'schoolName': schoolName,
      'classId': classId,
      'className': className,
      'sectionId': sectionId,
      'sectionName': sectionName,
      'parentName': parentName,
      'parentUserId': parentUserId,
      'mobileNumber': mobileNumber,
      'address': address,
      'imagePath': imagePath,
      'userType': userType,
      'roleName': roleName,
      'dob': dob,
      'firstName': firstName,
      'organizationLogo': organizationLogo,
      'organizationType': organizationType,
      'lastName': lastName,
      'email': email,
      'securityQuestion': securityQuestion,
      'securityAnswer': securityAnswer,
      'admissionNumber': admissionNumber,
      'firstTimePasswordUpdated': firstTimePasswordUpdated,
      'organizationId': organizationId,
      'academicStartDate': academicStartDate,
      'academicEndDate': academicEndDate,
      'yearId': yearId,
      'active': active,
      'termsAndConditionsUrl': termsAndConditionsUrl,
      'termsAndConditionAccepted': termsAndConditionAccepted,
      'educationLevelName': educationLevelName,
      'educationLevelId': educationLevelId,
      'classCode': classCode,
      'classSectionId': classSectionId,
      'allowFirstTimePasswordChange': allowFirstTimePasswordChange,
      'isUserSessionFeedbackEnabled': isUserSessionFeedbackEnabled,
      'isFeedbackSubmitted': isFeedbackSubmitted,
    };
  }
}
