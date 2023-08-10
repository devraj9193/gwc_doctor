import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/calendar_model.dart';
import '../model/combined_meal_model/all_day_tracker_model.dart';
import '../model/combined_meal_model/combined_meal_model.dart';
import '../model/combined_meal_model/dailyProgressMealPlanModel.dart';
import '../model/customer_profile_model.dart';
import '../model/customers_list_models/all_customer_consultation_model.dart';
import '../model/customers_list_models/consultation_list_model.dart';
import '../model/customers_list_models/meal_active_model.dart';
import '../model/day_progress_model.dart';
import '../model/direct_list_model.dart';
import '../model/doctor_profile_service/user_profile_model.dart';
import '../model/error_model.dart';
import '../model/follow_up_calls_model/follow_up_calls_model.dart';
import '../model/kaleyra_chat_list_model.dart/kaleyra_chat_list_model.dart';
import '../model/login_model/login_otp_model.dart';
import '../model/login_model/logout_model.dart';
import '../model/login_model/resend_otp_model.dart';
import '../model/maintenance_guide_model.dart';
import '../model/message_model/get_chat_groupid_model.dart';
import '../model/post_program_model/breakfast/protocol_breakfast_get.dart';
import '../model/post_program_model/post_program_new_model/pp_get_model.dart';
import '../model/post_program_model/post_program_new_model/protocol_calendar_model.dart';
import '../model/post_program_model/protocol_guide_day_score.dart';
import '../model/post_program_model/protocol_summary_model.dart';
import '../model/post_program_model/start_post_program_model.dart';
import '../model/uvDesk_model/get_ticket_list_model.dart';
import '../model/uvDesk_model/get_ticket_threads_list_model.dart';
import '../model/uvDesk_model/sent_reply_model.dart';
import '../model/uvDesk_model/uvDesk_ticket_raise_model.dart';
import '../utils/app_config.dart';
import '../utils/doctor_details_storage.dart';
import '../utils/gwc_apis.dart';

class ApiClient {
  ApiClient({
    required this.httpClient,
  });

  final http.Client httpClient;

  final _prefs = AppConfig().preferences;

  String getHeaderToken() {
    if (_prefs != null) {
      final token = _prefs!.getString(AppConfig().bearerToken);
      // AppConfig().tokenUser
      // .substring(2, AppConstant().tokenUser.length - 1);
      return "Bearer $token";
    } else {
      return "Bearer ${AppConfig().bearer}";
    }
  }

  Map<String, String> header = {
    "Content-Type": "application/json",
    "Keep-Alive": "timeout=5, max=1"
  };

  serverLoginWithOtpApi(String phone, String otp, String deviceToken) async {
    var path = GwcApi.loginWithOtpUrl;

    dynamic result;

    Map bodyParam = {'phone': phone, 'otp': otp, 'device_token': deviceToken};
    print("Login Details : $bodyParam");

    try {
      final response = await httpClient
          .post(Uri.parse(path), body: bodyParam)
          .timeout(const Duration(seconds: 45));

      print('serverLoginWithOtpApi Response header: $path');
      print('serverLoginWithOtpApi Response status: ${response.statusCode}');
      print('serverLoginWithOtpApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (res['status'] == 200) {
          result = LoginOtpModel.fromJson(res);
        } else {
          result = ErrorModel.fromJson(res);
        }
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  serverGetOtpApi(String phone) async {
    String path = GwcApi.getOtpUrl;

    dynamic result;

    Map bodyParam = {'phone': phone};
    print("bodyParam: $bodyParam");

    try {
      final response = await httpClient
          .post(Uri.parse(path), body: bodyParam)
          .timeout(const Duration(seconds: 45));

      print('serverGetOtpApi Response header: $path');
      print('serverGetOtpApi Response status: ${response.statusCode}');
      print('serverGetOtpApi Response body: ${response.body}');

      final res = jsonDecode(response.body);

      if (response.statusCode != 200) {
        result = ErrorModel.fromJson(res);
      } else {
        if (res['status'] == 200) {
          result = getOtpFromJson(response.body);
        } else {
          result = ErrorModel.fromJson(res);
        }
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  serverLogoutApi() async {
    var path = GwcApi.logOutUrl;

    dynamic result;

    try {
      final response = await httpClient.post(
        Uri.parse(path),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": getHeaderToken(),
        },
      ).timeout(Duration(seconds: 45));

      print('serverLogoutApi Response header: $path');
      print('serverLogoutApi Response status: ${response.statusCode}');
      print('serverLogoutApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (res['status'] == 200) {
          result = LogoutModel.fromJson(res);
          // inMemoryStorage.cache.clear();
        } else {
          result = ErrorModel.fromJson(res);
        }
      }
      else if(response.statusCode == 500){
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      }
      else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  getCalendarListApi() async {

    DateTime now =  DateTime. now();
    DateTime lastDayOfMonth =  DateTime(now. year, now. month , now. day - 7);
    DateTime nextDayOfMonth =  DateTime(now. year, now. month , now. day + 7);
    var startDate = "${lastDayOfMonth.year}-${lastDayOfMonth.month}-${lastDayOfMonth.day}";
    var endDate = "${nextDayOfMonth.year}-${nextDayOfMonth.month}-${nextDayOfMonth.day}";
    print(startDate);
    print(endDate);

    String url = "${GwcApi.calendarUrl}?start=$startDate&end=$endDate";
    print(url);

    var token = _prefs?.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getCalendarListApi Url: $url');
      print('getCalendarListApi Response status: ${response.statusCode}');
      print('getCalendarListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = CalendarModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getFollowUpCallsListApi(String selectedDate) async{
    String url = "${GwcApi.followUpCallsUrl}/$selectedDate";
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getFollowUpCallsListApi Url: $url');
      print('getFollowUpCallsListApi Response status: ${response.statusCode}');
      print('getFollowUpCallsListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = FollowUpCallsModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getConsultationPendingListApi() async{
    String url = GwcApi.consultationUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = ConsultationModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getMealActiveListApi() async{
    String url = GwcApi.mealPlanListUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = MealActiveModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getPostProgramListApi() async{
    String url = GwcApi.maintenanceGuideUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = MaintenanceGuideModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getAllConsultationPendingListApi() async{
    String url = GwcApi.newConsultationDocumentApiUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = AllCustomerConsultationModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getAllMealActiveListApi() async{
    String url = GwcApi.newMealActiveListApiUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = MealActiveModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getAllPostProgramListApi() async{
    String url = GwcApi.newPostProgramApiUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = MaintenanceGuideModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getDirectListApi() async{
    String url = GwcApi.directUsersListApiUrl;
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getShipmentListApi Url: $url');
      print('getShipmentListApi Response status: ${response.statusCode}');
      print('getShipmentListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = DirectListModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getCustomerProfileApi(String userId) async{
    String url = "${GwcApi.getCustomerProfileApiUrl}/$userId";
    print(url);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getCustomerProfileApi Url: $url');
      print('getCustomerProfileApi Response status: ${response.statusCode}');
      print('getCustomerProfileApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = GetCustomerModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future startPostProgram() async {
    var url = GwcApi.startPostProgramUrl;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    dynamic result;

    try {
      final response = await httpClient.post(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      print('startPostProgram Response status: ${response.statusCode}');
      print('startPostProgram Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('startPostProgram result: $json');
        result = StartPostProgramModel.fromJson(json);
      } else {
        print('startPostProgram error: ${response.reasonPhrase}');
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getPPMealsOnStagesApi(int stage, String day) async {
    var url;
    switch (stage) {
      case 0:
        url = '$GwcApi.getPPEarlyMorningUrl/$day';
        break;
      case 1:
        url = '$GwcApi.getPPBreakfastUrl/$day';
        break;
      case 2:
        url = '$GwcApi.getPPMidDayUrl/$day';
        break;
      case 3:
        url = '$GwcApi.getPPLunchUrl/$day';
        break;
      case 4:
        url = '$GwcApi.getPPEveningUrl/$day';
        break;
      case 5:
        url = '$GwcApi.getPPDinnerUrl/$day';
        break;
      case 6:
        url = '$GwcApi.getPPPostDinnerUrl/$day';
        break;
    }

    dynamic result;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      print('getPPMealsOnStagesApi Response status: ${response.statusCode}');
      print('getPPMealsOnStagesApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('getPPMealsOnStagesApi result: $json');
        result = PPGetMealModel.fromJson(json);
      } else {
        print('getPPMealsOnStagesApi error: ${response.reasonPhrase}');
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getLunchOnclickApi(String day) async {
    // var url = '$getLunchOnclickUrl/$day';
    var url = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    dynamic result;

    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      print('getLunchOnclickApi Response status: ${response.statusCode}');
      print('getLunchOnclickApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('getLunchOnclickApi result: $json');
        result = GetProtocolBreakfastModel.fromJson(json);
      } else {
        print('getLunchOnclickApi error: ${response.reasonPhrase}');
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getDinnerOnclickApi(String day) async {
    // var url = '$getDinnerOnclickUrl/$day';
    var url = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    dynamic result;

    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      print('getDinnerOnclickApi Response status: ${response.statusCode}');
      print('getDinnerOnclickApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('getDinnerOnclickApi result: $json');
        result = GetProtocolBreakfastModel.fromJson(json);
      } else {
        print('getDinnerOnclickApi error: ${response.reasonPhrase}');
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  /// this is for old flow
  Future getProtocolDayDetailsApi({String? dayNumber}) async {
    var url;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    if (dayNumber != null) {
      url = '$GwcApi.getProtocolDayDetailsUrl/$dayNumber';
    } else {
      url = GwcApi.getProtocolDayDetailsUrl;
    }

    dynamic result;

    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      print('getProtocolDayDetailsApi Response status: ${response.statusCode}');
      print('getProtocolDayDetailsApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('getProtocolDayDetailsApi result: $json');
        result = ProtocolGuideDayScoreModel.fromJson(json);
      } else {
        print('getProtocolDayDetailsApi error: ${response.reasonPhrase}');
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getPPDayDetailsApi({String? dayNumber}) async {
    var url;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    if (dayNumber != null) {
      url = '$GwcApi.getProtocolDayDetailsUrl/$dayNumber';
    } else {
      url = GwcApi.getProtocolDayDetailsUrl;
    }

    dynamic result;

    try {
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
        },
      );

      print('getPPDayDetailsApi Response status: ${response.statusCode}');
      print('getPPDayDetailsApi Response body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('getPPDayDetailsApi result: $json');
        result = PPGetMealModel.fromJson(json);
      } else {
        print('getPPDayDetailsApi error: ${response.reasonPhrase}');
        result = ErrorModel(
            status: response.statusCode.toString(), message: response.body);
      }
    } catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getPPDaySummaryApi(String day) async {
    dynamic res;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;
    dynamic result;
    try {
      final response =
          await http.get(Uri.parse("${GwcApi.daySummaryUrl}/$day"), headers: {
        'Authorization': token,
      });
      res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        result = ProtocolSummary.fromJson(res);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      return ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getPPCalendarApi() async {
    dynamic result;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token")!;

    try {
      final response =
          await http.get(Uri.parse(GwcApi.ppCalendarUrl), headers: {
        'Authorization': token,
      });
      //  print("PPCalendar response: ${response.body}");
      final res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        result = ProtocolCalendarModel.fromJson(res);
        // print("PPCalendar: ${calendarEvents[0].date?.year}, ${calendarEvents[0].date?.month}, ${calendarEvents[0].date?.day}");
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getChatGroupId(String userId) async {
    String path = GwcApi.customerChatListApiUrl;

    dynamic result;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    try {
      final response = await httpClient.get(
        Uri.parse("$path/$userId"),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getChatGroupId Response header: $path/$userId');
      print('getChatGroupId Response status: ${response.statusCode}');
      print('getChatGroupId Response body: ${response.body}');

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['status'].toString() == '200') {
          result = GetChatGroupIdModel.fromJson(res);
        } else {
          result = ErrorModel(
              status: res['status'].toString(), message: res.toString());
        }
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      } else {
        print('getChatGroupId error: ${response.reasonPhrase}');
        result = ErrorModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }

    return result;
  }

  getSuccessChatGroupId(String userId) async {
    String path = GwcApi.successChatGroupIdUrl;

    dynamic result;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    try {
      final response = await httpClient.get(
        Uri.parse("$path/$userId"),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 45));

      print('getChatGroupId Response header: $path/$userId');
      print('getChatGroupId Response status: ${response.statusCode}');
      print('getChatGroupId Response body: ${response.body}');

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        if (res['status'].toString() == '200') {
          result = GetChatGroupIdModel.fromJson(res);
        } else {
          result = ErrorModel(
              status: res['status'].toString(), message: res.toString());
        }
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      } else {
        print('getChatGroupId error: ${response.reasonPhrase}');
        result = ErrorModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }

    return result;
  }

  Future getDoctorMemberProfileApi(String accessToken) async {
    final path = GwcApi.getUserProfileApiUrl;
    var result;

    print("token: $accessToken");
    try {
      final response = await httpClient.get(
        Uri.parse(path),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ).timeout(const Duration(seconds: 45));

      print(
          "getUserProfileApi response code:" + response.statusCode.toString());
      print("getUserProfileApi response body:" + response.body);

      final res = jsonDecode(response.body);
      print('${res['status'].runtimeType} ${res['status']}');
      if (res['status'].toString() == '200') {
        print("name: ${res['data']['name']}");
        result = GetUserModel.fromJson(res);
        _prefs?.setString(
            GwcApi.successMemberName, res['data']['name'] ?? '');
        _prefs?.setString(GwcApi.successMemberProfile,res['data']['profile'] ?? '');
        _prefs?.setString(GwcApi.successMemberAddress,res['data']['address'] ?? '');
      } else if (response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      print("getUserProfileApi catch error ${e}");
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future getKaleyraAccessTokenApi(String kaleyraUID) async{
    dynamic result;
    // production or sandbox
    // final environment = "sandbox";
    // final region = "eu";
    // testing api key: ak_live_c1ef0ed161003e0a2b419d20
    // final endPoint = "https://cs.${environment}.${region}.bandyer.com";
    /// live endpoint
    const endPoint = "https://api.in.bandyer.com";

    const String url = "$endPoint/rest/sdk/credentials";
    try{

      final response = await httpClient.post(Uri.parse(url),
          headers: {
            'apikey': 'ak_live_d2ad6702fe931fbeb2fa9cb4'
          },
          body: {
            "user_id": kaleyraUID
          }
      );
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = json['access_token'];
        print("access token got");
        _prefs!.setString(AppConfig.KALEYRA_ACCESS_TOKEN, result);
      }
      else{
        final json = jsonDecode(response.body);
        result = ErrorModel.fromJson(json);
      }
    }
    catch(e){
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  // meal plan api

  getProgressApi(String userId) async{
    String url = "${GwcApi.dayProgressListUrl}/$userId";
    print(url);

    dynamic result;
    try{

      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : getHeaderToken(),
        },
      ).timeout(const Duration(seconds: 45));

      print('getProgressApi Url: $url');
      print('getProgressApi Response status: ${response.statusCode}');
      print('getProgressApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = DayProgressModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future getCombinedMealApi(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final path = "${GwcApi.nutriDelightApiUrl}/$userId";
    var result;

    try {
      final response = await httpClient.get(
        Uri.parse(path),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": getHeaderToken(),
        },
      ).timeout(const Duration(seconds: 45));

      print("getCombinedMealApi response url:" +
          path);
      print("getCombinedMealApi response code:" +
          response.statusCode.toString());
      print("getCombinedMealApi response body:" + response.body);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        print('${res['status'].runtimeType} ${res['status']}');
        print(res['Detox']);

        if (res['status'].toString() == '200') {
          // result = CombinedMealModel.fromJson(mealJson);

          result = CombinedMealModel.fromJson(jsonDecode(response.body));

        } else {
          result = ErrorModel.fromJson(res);
        }
      }
      else if(response.statusCode == 500){
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      }
      else {
        print('status not equal called');
        final res = jsonDecode(response.body);
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      print("catch error::> $e");
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future getDailyProgressMealPlanApi(String selectedDay, String detoxOrHealing) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString("user_id")!;

    final path = "${GwcApi.dailyProgressMealPlanApiUrl}/$selectedDay/$userId/$detoxOrHealing";
    var result;

    try {
      final response = await httpClient.get(
        Uri.parse(path),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": getHeaderToken(),
        },
      ).timeout(const Duration(seconds: 45));

      print("getDailyProgressMealApi response url:" +
          path);
      print("getDailyProgressMealApi response code:" +
          response.statusCode.toString());
      print("getDailyProgressMealApi response body:" + response.body);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        print('${res['status'].runtimeType} ${res['status']}');
        print(res['Detox']);

        if (res['status'].toString() == '200') {
          // result = CombinedMealModel.fromJson(mealJson);

          result = DailyProgressMealPlanModel.fromJson(jsonDecode(response.body));

        } else {
          result = ErrorModel.fromJson(res);
        }
      }
      else if(response.statusCode == 500){
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      }
      else {
        print('status not equal called');
        final res = jsonDecode(response.body);
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      print("catch error::> $e");
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future getAllDayTrackerApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString("user_id")!;

    final path = "${GwcApi.allDayTrackerApiUrl}/$userId";
    var result;

    try {
      final response = await httpClient.get(
        Uri.parse(path),
        headers: {
          // "Authorization": "Bearer ${AppConfig().bearerToken}",
          "Authorization": getHeaderToken(),
        },
      ).timeout(const Duration(seconds: 45));

      print("getAllDayTrackerApi response url:" +
          path);
      print("getAllDayTrackerApi response code:" +
          response.statusCode.toString());
      print("getAllDayTrackerApi response body:" + response.body);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        print('${res['status'].runtimeType} ${res['status']}');
        print(res['Detox']);

        if (res['status'].toString() == '200') {
          // result = CombinedMealModel.fromJson(mealJson);

          result = AllDayTrackerModel.fromJson(jsonDecode(response.body));

        } else {
          result = ErrorModel.fromJson(res);
        }
      }
      else if(response.statusCode == 500){
        result = ErrorModel(status: "0", message: AppConfig.oopsMessage);
      }
      else {
        print('status not equal called');
        final res = jsonDecode(response.body);
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      print("catch error::> $e");
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future getKaleyraChatListApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var kaleyraUserId = preferences.getString("kaleyraUserId")!;

    final path =
        "https://api.in.bandyer.com/rest/user/$kaleyraUserId/chat/list";

    dynamic result;

    print('getKaleyraChatListApi Response header: $path');

    try {
      final response = await httpClient.get(
        Uri.parse(path),
        headers: {
          'apikey': GwcApi.apiKey,
        },
      ).timeout(const Duration(seconds: 45));

      print('getKaleyraChatListApi Response header: $path');
      print('getKaleyraChatListApi Response status: ${response.statusCode}');
      print('getKaleyraChatListApi Response body: ${response.body}');

      final json = jsonDecode(response.body);
      print('serverGetAboutProgramDetails result: $json');

      if (response.statusCode == 200) {
        result = KaleyraChatListModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(json);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }

    return result;
  }

  //UV Desk Integration
  Future uvDeskTicketRaiseApi(Map data,{List<File>? attachments}) async {
    final path = GwcApi.uvDeskTicketRaiseApiUrl;

    Map bodyParam = data;
    // {
    //   "name" : name,
    //   "from" : email,
    //   "subject" : title,
    //   "message" : description,
    //   "actAsType" : "agent",
    //   "actAsEmail" : _prefs!.getString(SuccessMemberStorage.successMemberEmail),
    // };

    print("Login Details : $bodyParam");

    print("uvDesk Token : ${DoctorDetailsStorage.uvDeskAccessToken}");

    dynamic result;
    var headers = {
      // "Authorization": adminToken,
      "Authorization": "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
    };

    try{

      var request = http.MultipartRequest('POST', Uri.parse(path));

      request.headers.addAll(headers);
      request.fields.addAll(Map.from(data));
      request.persistentConnection = false;

      if(attachments != null) {
        for(int i =0; i < attachments.length; i++){
          request.files.add(await http.MultipartFile.fromPath('attachments[$i]', attachments[i].path));
        }
      };

      // print("attachment .length: ${attachments!.length}");

      print("request.files.length: ${request.files.length}");

      var response = await http.Response.fromStream(await request.send())
          .timeout(Duration(seconds: 45));

      print('uvDeskTicketRaiseApi Response header: $path');
      print('uvDeskTicketRaiseApi Response status: ${response.statusCode}');
      print('uvDeskTicketRaiseApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('uvDeskTicketRaiseApi result: $json');
        result = UvDeskTicketRaiseModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  getOpenTicketListApi() async{
    String url = "${GwcApi.openListApiUrl}${_prefs!.getString(DoctorDetailsStorage.doctorDetailsUvId)}";
    print(url);

    dynamic result;
    try{
      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
        },
      ).timeout(Duration(seconds: 45));

      print("uvToken : ${DoctorDetailsStorage.uvDeskAccessToken}");
      print('getTicketListApi Url: $url');
      print('getTicketListApi Response status: ${response.statusCode}');
      print('getTicketListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = GetTicketListModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getTicketThreadsApi(String ticketId) async{
    String url = "${AppConfig().uvBaseUrl}/ticket/$ticketId";
    print(url);

    dynamic result;
    try{
      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('getTicketListApi Url: $url');
      print('getTicketListApi Response status: ${response.statusCode}');
      print('getTicketListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = ThreadsListModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getAnsweredThreadsApi(String ticketId) async{
    String url ="${GwcApi.answeredListApiUrl}${_prefs!.getString(DoctorDetailsStorage.doctorDetailsUvId)}";
    print(url);

    dynamic result;
    try{
      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('getTicketListApi Url: $url');
      print('getTicketListApi Response status: ${response.statusCode}');
      print('getTicketListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = GetTicketListModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getResolvedThreadsApi(String ticketId) async{
    String url = "${GwcApi.resolvedListApiUrl}${_prefs!.getString(DoctorDetailsStorage.doctorDetailsUvId)}";
    print(url);

    dynamic result;
    try{
      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('getTicketListApi Url: $url');
      print('getTicketListApi Response status: ${response.statusCode}');
      print('getTicketListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = GetTicketListModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  getClosedThreadsApi(String ticketId) async{
    String url = "${GwcApi.closedListApiUrl}${_prefs!.getString(DoctorDetailsStorage.doctorDetailsUvId)}";
    print(url);

    dynamic result;
    try{
      final response = await httpClient.get(Uri.parse(url),
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('getTicketListApi Url: $url');
      print('getTicketListApi Response status: ${response.statusCode}');
      print('getTicketListApi Response body: ${response.body}');

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        result = GetTicketListModel.fromJson(json);
      }
      else if(response.statusCode == 500) {
        result = ErrorModel(status: "0", message: GwcApi.oopsMessage);
      }
      else{
        result = ErrorModel(status: response.statusCode.toString(), message: response.body);
      }
    }
    catch (e) {
      print(e);
      result = ErrorModel(status: "", message: e.toString());
    }
    return result;
  }

  Future uvDeskSendReplyApi(String ticketId, Map data, {List<File>? attachments}) async {
    final path = "${AppConfig().uvBaseUrl}/ticket/$ticketId/thread";

    // Map bodyParam = {
    //   'threadType': threadType,
    //   'reply': message,
    // };
    print("body Details : $data");

    print("uvDesk Token : ${DoctorDetailsStorage.uvDeskAccessToken}");

    dynamic result;
    var headers = {
      // "Authorization": adminToken,
      "Authorization": "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
    };
    try{
      var request = http.MultipartRequest('POST', Uri.parse(path));

      request.headers.addAll(headers);
      request.fields.addAll(Map.from(data));
      request.persistentConnection = false;

      if(attachments != null) {
        for(int i =0; i < attachments.length; i++){
          request.files.add(await http.MultipartFile.fromPath('attachments[$i]', attachments[i].path));
        }
        print("attachment .length: ${attachments.length}");
      }

      print("request.files.length: ${request.files.length}");

      var response = await http.Response.fromStream(await request.send())
          .timeout(Duration(seconds: 45));

      print("uvToken : ${DoctorDetailsStorage.uvDeskAccessToken}");

      print('uvDeskSendReplyApi Response header: $path');
      print('uvDeskSendReplyApi Response status: ${response.statusCode}');
      print('uvDeskSendReplyApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('uvDeskSendReplyApi result: $json');
        result = SentReplyModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future uvDeskCancelledApi(String editType, String value,String threadId) async {
    final path = "${AppConfig().uvBaseUrl}/ticket/$threadId.json";

    Map bodyParam = {
      'editType': editType,
      'value': value,
    };
    print("Login Details : $bodyParam");

    print("uvDesk Token : ${DoctorDetailsStorage.uvDeskAccessToken}");

    dynamic result;

    try {
      final response = await httpClient.patch(
        Uri.parse(path),
        body: bodyParam,
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
          //   'OAuth 2.0': "Bearer ${GwcApi.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('uvDeskSendReplyApi Response header: $path');
      print('uvDeskSendReplyApi Response status: ${response.statusCode}');
      print('uvDeskSendReplyApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('uvDeskSendReplyApi result: $json');
        result = SentReplyModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future uvDeskTransferToDoctorApi(String email,String threadId) async {
    final path = "${AppConfig().uvBaseUrl}/ticket/$threadId/collaborator.json";

    Map bodyParam = {
      'email': email,
    };
    print("Login Details : $bodyParam");

    print("uvDesk Token : ${DoctorDetailsStorage.uvDeskAccessToken}");

    dynamic result;

    try {
      final response = await httpClient.post(
        Uri.parse(path),
        body: bodyParam,
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
          //   'OAuth 2.0': "Bearer ${GwcApi.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('uvDeskTransferToDoctorApi Response header: $path');
      print('uvDeskTransferToDoctorApi Response status: ${response.statusCode}');
      print('uvDeskTransferToDoctorApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('uvDeskTransferToDoctorApi result: $json');
        result = SentReplyModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

  Future uvDeskReassignApi(String agentId, String threadId) async {
    final path = GwcApi.reassignApiUrl;

    Map bodyParam = {
      'ids': threadId,
      'agentId': agentId,
    };
    print("Login Details : $bodyParam");

    print("uvDesk Token : ${DoctorDetailsStorage.uvDeskAccessToken}");

    dynamic result;

    try {
      final response = await httpClient.put(
        Uri.parse(path),
        body: jsonEncode(bodyParam),
        headers: {
          'Authorization' : "Bearer ${DoctorDetailsStorage.uvDeskAccessToken}",
        },
      ).timeout(const Duration(seconds: 45));

      print('uvDeskReassignApi Response header: $path');
      print('uvDeskReassignApi Response status: ${response.statusCode}');
      print('uvDeskReassignApi Response body: ${response.body}');
      final res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('uvDeskReassignApi result: $json');
        result = SentReplyModel.fromJson(json);
      } else {
        result = ErrorModel.fromJson(res);
      }
    } catch (e) {
      result = ErrorModel(status: "0", message: e.toString());
    }
    return result;
  }

}
