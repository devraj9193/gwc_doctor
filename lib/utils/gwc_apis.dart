import 'app_config.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class GwcApi {
  static String loginWithOtpUrl = "${AppConfig().baseUrl}/api/otp_login";

  static String getOtpUrl = "${AppConfig().baseUrl}/api/sendOTP";

  static String consultationUrl = "${AppConfig().baseUrl}/api/listData/consultation";

  static String evaluationUrl =
      "${AppConfig().baseUrl}/api/listData/customer_evaluation_form";

  static String calendarUrl = "${AppConfig().baseUrl}/api/listData/calendar";

  static String customerMRReport = "${AppConfig().baseUrl}/api/listData/customer_profile";

  static String mealPlanListUrl = "${AppConfig().baseUrl}/api/listData/meal_plan_list";

  static String dayMealListUrl =
      "${AppConfig().baseUrl}/api/getDataList/user_day_meal_plan";

  static String dayProgressListUrl = "${AppConfig().baseUrl}/api/listData/progress";

  static String maintenanceGuideUrl =
      "${AppConfig().baseUrl}/api/listData/post_program_list";

  static String guideMealPlanUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan";

  static String protocolGraphUrl =
      "${AppConfig().baseUrl}/api/getDataList/protocol_graph";

  static String notificationListUrl =
      "${AppConfig().baseUrl}/api/getData/notification_list";

  static String chatGroupIdUrl = "${AppConfig().baseUrl}/api/getData/get_chat_team_group";

  static String successChatGroupIdUrl = "${AppConfig().baseUrl}/api/getData/get_doctor_success_chat_group";

 // static String successChatGroupIdUrl = "${AppConfig().baseUrl}/api/getData/get_chat_messages_list/success_team_chat";

  static String customerChatListApiUrl =
      "${AppConfig().baseUrl}/api/getData/get_chat_messages_group";

  static String directUsersListApiUrl= "${AppConfig().baseUrl}/api/getDataList/users_list";

  static String callApiUrl = "${AppConfig().baseUrl}/api/listData/call_user";

  static String dayTrackerApiUrl = "${AppConfig().baseUrl}/api/getDataList/patient_meal_tracking_data";

  static String startPostProgramUrl = "${AppConfig().baseUrl}/api/submitForm/post_program";

  static String getPPEarlyMorningUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/early_morning";

  static String getPPBreakfastUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/breakfast";

  static String getPPMidDayUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/mid_day";

  static String getPPLunchUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/lunch";

  static String getPPEveningUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/evening";

  static String getPPDinnerUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/dinner";

  static String getPPPostDinnerUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_meal_plan/post_dinner";

  static String getProtocolDayDetailsUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_guide_day_score";

  static String daySummaryUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_summary";

  static String ppCalendarUrl = "${AppConfig().baseUrl}/api/getDataList/protocol_meal_tracking_calendar";

  static String getUserProfileApiUrl = "${AppConfig().baseUrl}/api/user";

  static String successTeamListApiUrl =
      "${AppConfig().baseUrl}/api/getDataValue/success_team_list";

  static String customersListApiUrl =
      "${AppConfig().baseUrl}/api/getDataValue/customers_list";

  static const String groupId = '635fa22932eaaf0030c5ef1e';
  static const String successGroupId = '635fa22932eaaf0030c5ef1e';
  static const String qbCurrentUserId = 'curr_userId';
  static const String getQBSession = 'qb_session';
  static const String isQBLogin = 'is_qb_login';
  static const String qbUsername = 'qb_username';

  static SharedPreferences? preferences;
  static Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }
}
