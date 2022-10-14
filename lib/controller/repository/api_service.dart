import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/error_model.dart';
import '../../model/login_model/login_otp_model.dart';
import '../../model/login_model/resend_otp_model.dart';
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

  serverLoginWithOtpApi(String phone, String otp) async {
    var path = loginWithOtpUrl;

    dynamic result;

    Map bodyParam = {'phone': phone, 'otp': otp};

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
    String path = getOtpUrl;

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
}
