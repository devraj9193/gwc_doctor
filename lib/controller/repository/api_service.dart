import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/error_model.dart';
import '../../model/login_model/login_otp_model.dart';
import '../../model/login_model/resend_otp_model.dart';
import '../../model/message_model/get_chat_groupid_model.dart';
import '../../model/post_program_model/breakfast/protocol_breakfast_get.dart';
import '../../model/post_program_model/post_program_new_model/pp_get_model.dart';
import '../../model/post_program_model/post_program_new_model/protocol_calendar_model.dart';
import '../../model/post_program_model/protocol_guide_day_score.dart';
import '../../model/post_program_model/protocol_summary_model.dart';
import '../../model/post_program_model/start_post_program_model.dart';
import '../../utils/app_config.dart';
import '../../utils/gwc_apis.dart';

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

  serverLoginWithOtpApi(String phone, String otp,String deviceToken) async {
    var path = GwcApi.loginWithOtpUrl;

    dynamic result;

    Map bodyParam = {'phone': phone, 'otp': otp,'device_token' : deviceToken};
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
          result = loginOtpFromJson(response.body);
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

  Future getKaleyraAccessTokenApi(String kaleyraUID) async {
    dynamic result;
    // production or sandbox
    const environment = "sandbox";
    const region = "eu";

    const endPoint = "https://cs.$environment.$region.bandyer.com";

    const String url = "$endPoint/rest/sdk/credentials";
    try {
      final response = await httpClient.post(Uri.parse(url),
          headers: {'apikey': 'ak_live_c1ef0ed161003e0a2b419d20'},
          body: {"user_id": kaleyraUID});
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        result = json['access_token'];
      } else {
        final json = jsonDecode(response.body);
        result = ErrorModel.fromJson(json);
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
}
