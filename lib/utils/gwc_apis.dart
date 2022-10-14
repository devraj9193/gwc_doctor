import 'app_config.dart';

var loginWithOtpUrl = "${AppConfig().baseUrl}/api/otp_login";

var getOtpUrl = "${AppConfig().baseUrl}/api/sendOTP";

var consultationUrl = "${AppConfig().baseUrl}/api/listData/consultation";

var evaluationUrl =
    "${AppConfig().baseUrl}/api/listData/customer_evaluation_form";

var calendarUrl = "${AppConfig().baseUrl}/api/listData/calendar";

var customerMRReport = "${AppConfig().baseUrl}/api/listData/customer_profile";

var mealPlanListUrl = "${AppConfig().baseUrl}/api/listData/meal_plan_list";

var dayMealListUrl =
    "${AppConfig().baseUrl}/api/getDataList/user_day_meal_plan";

var dayProgressListUrl =
    "${AppConfig().baseUrl}/api/listData/progress";
