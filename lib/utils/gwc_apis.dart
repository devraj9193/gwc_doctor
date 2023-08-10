import 'app_config.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GwcApi {
  static String loginWithOtpUrl = "${AppConfig().baseUrl}/api/otp_login";

  static String getOtpUrl = "${AppConfig().baseUrl}/api/sendOTP";

  static String logOutUrl = "${AppConfig().baseUrl}/api/logout";

  static String followUpCallsUrl =
      "${AppConfig().baseUrl}/api/listData/follow_up_calls_list";

  static String consultationUrl =
      "${AppConfig().baseUrl}/api/listData/consultation";

  static String evaluationUrl =
      "${AppConfig().baseUrl}/api/listData/customer_evaluation_form";

  static String calendarUrl = "${AppConfig().baseUrl}/api/listData/calendar";

  static String getCustomerProfileApiUrl =
      "${AppConfig().baseUrl}/api/getDataValue/customer_profile";

  static String customerMRReport =
      "${AppConfig().baseUrl}/api/listData/customer_profile";

  static String mealPlanListUrl =
      "${AppConfig().baseUrl}/api/listData/meal_plan_list";

  static String dayMealListUrl =
      "${AppConfig().baseUrl}/api/getDataList/user_day_meal_plan";

  static String dayProgressListUrl =
      "${AppConfig().baseUrl}/api/listData/progress";

  static String maintenanceGuideUrl =
      "${AppConfig().baseUrl}/api/listData/post_program_list";

  static String guideMealPlanUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan";

  static String protocolGraphUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_graph";

  static String notificationListUrl =
      "${AppConfig().baseUrl}/api/getData/notification_list";

  static String chatGroupIdUrl =
      "${AppConfig().baseUrl}/api/getData/get_chat_team_group";

  static String successChatGroupIdUrl =
      "${AppConfig().baseUrl}/api/getData/get_doctor_success_chat_group";

  // static String successChatGroupIdUrl = "${AppConfig().baseUrl}/api/getData/get_chat_messages_list/success_team_chat";

  static String customerChatListApiUrl =
      "${AppConfig().baseUrl}/api/getData/get_chat_messages_group";

  static String directUsersListApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/users_list";

  static String callApiUrl = "${AppConfig().baseUrl}/api/listData/call_user";

  static String dayTrackerApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/patient_meal_tracking_data";

  static String startPostProgramUrl =
      "${AppConfig().baseUrl}/api/submitForm/post_program";

  static String getPPEarlyMorningUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/early_morning";

  static String getPPBreakfastUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/breakfast";

  static String getPPMidDayUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/mid_day";

  static String getPPLunchUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/lunch";

  static String getPPEveningUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/evening";

  static String getPPDinnerUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/dinner";

  static String getPPPostDinnerUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/post_dinner";

  static String getProtocolDayDetailsUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_day_score";

  static String daySummaryUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_summary";

  static String ppCalendarUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_meal_tracking_calendar";

  static String getUserProfileApiUrl = "${AppConfig().baseUrl}/api/user";

  static String successTeamListApiUrl =
      "${AppConfig().baseUrl}/api/getDataValue/success_team_list";

  static String customersListApiUrl =
      "${AppConfig().baseUrl}/api/getDataValue/customers_list";

  static String nutriDelightApiUrl =
      "${AppConfig().baseUrl}/api/getData/NutriDelight";

  // selected day, user id, detox = 1, healing = 2 need to pass
  static String dailyProgressMealPlanApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/user_day_meal_plan";

  static String allDayTrackerApiUrl =
      "${AppConfig().baseUrl}/api/getData/NutriDelightTracker";

  static const String groupId = '635fa22932eaaf0030c5ef1e';
  static const String successGroupId = '635fa22932eaaf0030c5ef1e';
  static const String qbCurrentUserId = 'curr_userId';
  static const String getQBSession = 'qb_session';
  static const String isQBLogin = 'is_qb_login';
  static const String qbUsername = 'qb_username';

  static String oopsMessage = "OOps ! Something went wrong.";

  static String successMemberName = "successMemberName";
  static String successMemberProfile = "successMemberProfile";
  static String successMemberAddress = "successMemberAddress";

  // static String uvDeskAccessToken =
  //     "HBTCAEHAAAOTTVECVMNJGLWYVXVN3GBJUR0XVZNOJTO4N1Y4LD7LT3LE4PVONODF";

  static SharedPreferences? preferences;

  static Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

// === NEW API === //

  static String newConsultationDocumentApiUrl =
      "${AppConfig().baseUrl}/api/listData/all_consultation";

  static String newMealActiveListApiUrl =
      "${AppConfig().baseUrl}/api/listData/all_meal_plan_list";

  static String newPostProgramApiUrl =
      "${AppConfig().baseUrl}/api/listData/all_post_program_list";

  static String preparatoryApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/user_prep_meal_plan";

  static String transitionApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/user_trans_meal_plan";

  static String preparatoryAnswerApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/tracking_prep_meal";

  static String transitionAnswerApiUrl =
      "${AppConfig().baseUrl}/api/getDataList/trans_meal_tracking_data";

  static String medicalFeedbackAnswerApiUrl =
      "${AppConfig().baseUrl}/api/getData/medical_feedback";

  static const String apiKey = "ak_live_d2ad6702fe931fbeb2fa9cb4";
  static const String appId =
      "mAppId_a4908f3e2fa60c828daff5e875b0af422545696fa0bffa76d614489aae8d";
  static const String kaleyraAccessToken = "kaleyra_access_token";

  //uvDesk Urls
  static String uvDeskTicketRaiseApiUrl =
      "${AppConfig().uvBaseUrl}/tickets.json";

  static String openListApiUrl = "${AppConfig().uvBaseUrl}/tickets?status=1&agent=";

  static String answeredListApiUrl = "${AppConfig().uvBaseUrl}/tickets?status=3&agent=";

  static String resolvedListApiUrl = "${AppConfig().uvBaseUrl}/tickets?status=4&agent=";

  static String closedListApiUrl = "${AppConfig().uvBaseUrl}/tickets?status=5&agent=";

  static String reassignApiUrl =
      "${AppConfig().uvBaseUrl}/tickets/agent.json";
}
