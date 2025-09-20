/*
Author: Nagaraju.lj
Date: April,2024.
Description: URLs endpoints used in the student and teacher side
 */
class Urls {
  static const String getApplicationSettings = "getApplicationSettings";

  static const String checkUser = "checkUser";
  static const String getUserDetails = "getUserDetails";

  static const String getSubjects = "getSubjects";
  static const String getLicenses = "getLicenses";
  static const String getTopics = "getTopics";
  static const String getThemes = "getThemes";
  static const String getRecommendedLearningResources =
      "getRecommendedLearningResources";
  static const String getSharedLearningResources = "getSharedLearningResources";
  static const String getMyLearningResources = "getMyLearningResources";
  static const String activityCentersAssignment = "activityCentersAssignment";
  static const String activityCentersTest = "activityCentersTest";
  static const String activityCentersLearningResource =
      "activityCentersScormResource"; // Activity Center Learning Resources
  static const String getScormProgressionSummary = "getScormProgressionSummary";
  static const String getContactsDetails = "getContactsDetails";
  static const String getNotifications = "GetNotifications";
  static const String getNotificationsCount = "GetNotificationCount";
  static const String notificationRead = "NotificationRead";
  static const String deleteNotification = "DeleteNotification";

  static const String termsAndConditionAcceptance =
      "termsAndConditionAcceptance";
  static const String getSecurityQuestions = "secureQuestions";
  static const String changePassword = "changePassword";
  static const String updateUserDetails = "UpdateUserDetail";
  static const String markAsCompleted = "MarkAsCompleted";
  static const String submitAssignment = "SubmitAssignments";
  static const String submitPenPaper = "PenAndPaperFileSubmit";
  static const String getUploadsPenPaper = "GetPenPaperUploadedFilesDetails";
  static const String getLessonDrivenTestsForLBQ = "GetLessonDrivenTestsForLBQ";
  static const String getZipPath = "GetTopicResourcesPackage";
  static const String getLearningTools = "GetLearningTools";
  static const String getVirtualClassRoomDetails = "GetVirtualClassRoomDetails";
  static const String markVirtualClassComplete = "MarkVirtualClassComplete";
  static const String downloadTestDetails = "GetTestDetails";
  static const String getTestInstruction = "GetAssessmentInstruction";
  static const String getTestReportReview = "GetTestReportReview";
  static const String authenticateERPToken = "AuthenticateERPUser";
  static const String getSingleAssignmentDetail = "GetSingleAssignmentDetail";
  static const String getFileUpload = "Upload/MultiPartMediaUpload";
  static const String getPlacementTestDetails = "GetPlacementTestDetails";
  static const String getFASATestDetails = "GetFASATestDetails";
  static const String getStudentAssessmentsFASA = "GetStudentAssessmentsFASA";
  static const String getStudentTestTermInfo = "GetStudentTestTermInfo";
  static const String getRemedialLearningSubjects =
      "GetRemedialLearningSubjects";
  static const String getRemedialLearningDetails = "GetRemedialLearningDetails";
  static const String updateMarkAsReadRemedial = "MarkAsReadRemedial";
  static const String updateRemedialTestToInProgress = "UpdateSchedule";
  static const String getScheduleDetails = "GetScheduleDetails";
  static const String getDetailsOnUserName = "getDetailsOnUserName";
  static const String generateOTPToResetPassword = "generateOTPToResetPassword";
  static const String validateUserOTP = "validateUserOTP";
  static const String getModuleCodes = "GetModuleCodes";
  static const String uploadApplicationUsageTracking =
      "ApplicationUsageTracking";
  static const String getStudentWiseLBQReport = "GetStudentWiseLBQReports";
  static const String getLBQClasses = "GetLBQClasses";
  static const String downloadLearningTools = "DownloadLearningTools";
  static const String getAllLBQList = "GetAllLBQAssessments";
  static const String uploadContentUsageTracking = "ContentUsageTracking";
  static const String uploadScormProgressInfo = "UserProgressInfo";

  static const String fileURL = "Upload/";

  static const String getServerTime = "GetServerTime";
  static const String checkMasterDataChanges = "CheckMasterDataChanges";
  static const String getActivationLink =
      "/OxfordAdvantage/Administration/Registration/ValidateLicence.aspx?&theme=oxford";
  static const String getDisclaimers = "GetDisclaimers";
  static const String getClassDetailsOnAssetCode = "GetClassDetailsOnAssetCode";

  //myClass APIs

  static const String getAcademicYears = "GetAcademicYears";
  static const String getPlacementTestListForTeacher =
      "GetPlacementTestListForTeacher";
  static const String getFASATestListForTeacher =
      "GetFASATestDetailsForTeacher";
  static const String getTeacherTermTestInfo = "GetTeacherTermTestInfo";
  static const String getSectionWiseUniqueSchedulesOfPlacementTests =
      "GetSectionWiseUniqueSchedulesOfPlacementTests";
  static const String getManageAssignmentTests = "GetManageAssignmentTests";
  static const String getChapterPlanDetails = "GetChapterPlanDetails";
  static const String getAssignedStudentsForTest = "GetAssignedStudentsForTest";
  static const String getManageAssignmentLRs = "GetManageAssignmentLRs";
  static const String getAssignedStudentsForLRs = "GetAssignedStudentsForLRs";
  static const String getAssignedTestSubmissionDetailsForStudent =
      "GetAssignedTestSubmissionDetailsForStudent";
  static const String getClassAndSectionsForScheduleTest =
      "GetClassAndSectionsForScheduleTest";
  static const String getFASAAssessmentDetailsForStudents =
      "GetFASAAssessmentDetailsForStudents";
  static const String getFASAAssessmentDetailsQuestionWise =
      "GetFASAAssessmentDetailsQuestionwise";
  static const String getStudentsForClassAndSections =
      "GetStudentsForClassAndSections";
  static const String getTeacherGroups = "GetTeacherGroups";
  static const String getClassList = "AssignPTForClass";
  static const String publishPlacementTest = "PublishPlacementTest";
  static const String assign = "Assign";
  static const String getLBQAssign = "GetLBQAssign";
  static const String assignPTForIndividual = "AssignPTForIndividual";
  static const String getScheduledAssetDetail = "GetScheduledAssetDetail";
  static const String getRecommendedLessonPlanDetails =
      "GetRecommendedLessonPlanDetails";
  static const String getSharedLessonPlanDetails = "GetSharedLessonPlanDetails";
  static const String getMyLessonPlanDetails = "GetMyLessonPlanDetails";
  static const String getRecommendedAssessments = "GetRecommendedAssessments";
  static const String getSharedAssessments = "GetSharedAssessments";
  static const String getMyAssessments = "GetMyAssessments";
  static const String getAIGeneratedAssessments = "GetAIGeneratedAssessments";
  static const String getSurveyDetails = "GetSurveyDetails";
  static const String encryptSurveyData = "EncryptSurveyData";

  static const String getSupportingFilesDetails = "GetSupportingFilesDetails";
  static const String getLessonImagesDetails = "GetLessonImagesDetails";

  static const String getTeacherCornerCategories =
      "GetPreloadTeacherCornerCategories";
  static const String getTeacherCornerResources =
      "GetPreloadTeacherCornerResources";
  static const String downloadTeacherCornerResources =
      "DownloadTeacherCornerResources";
  static const String getAssessmentTypes = "GetAssessmentTypes";
  static const String evaluateEssayQuestionDetails =
      "EvaluateEssayQuestionDetails";
  static const String updateRemarks = "UpdateRemarks";

  static const String updateFASAMarks = "UpdateFASAMarksQuestionWise";

  static const String submitTest = "SubmitTest";
  static const String onFlyTestSchedule = "OnFlyTestSchedule";
  static const String userSessionDetails = "GetUserSessionDetails";
  static const String submitUserFeedBackDetails = "SaveUserSessionDetails";
  static const String skipFeedBackByUser = "SkipFeedback";
  static const String saveFcmToken = "savefcmToken";
  static const String getEbookResources = "GetEbookResources";
  static const String getLRZipFileLastSyncDetails = "GetLRZipFileLastSyncDetails";
  //to be deleted in API code
// getSubjectLearningResources, getPreloadAssessments, getLessonPlanDetails
}
