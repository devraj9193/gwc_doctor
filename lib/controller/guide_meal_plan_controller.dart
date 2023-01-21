import 'dart:convert';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/guide_meal_plan_model.dart';
import '../utils/gwc_apis.dart';

class GuideMealPlanController extends GetxController {
  GuideMealPlanModel? guideMealPlanModel;

  @override
  void onInit() {
    super.onInit();
    fetchBreakFastPlan();
    fetchLunchPlan();
    fetchDinnerPlan();
  }

  Future<GuideMealPlanModel> fetchBreakFastPlan() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response = await http
        .get(Uri.parse("${GwcApi.guideMealPlanUrl}/breakfast/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      res = jsonDecode(response.body);
      guideMealPlanModel = GuideMealPlanModel.fromJson(res);
      //  print("object: ${dayPlanModel?.data}");
    } else {
      throw Exception();
    }
    return GuideMealPlanModel.fromJson(res);
  }

  Future<GuideMealPlanModel> fetchLunchPlan() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response =
        await http.get(Uri.parse("${GwcApi.guideMealPlanUrl}/lunch/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      res = jsonDecode(response.body);
      guideMealPlanModel = GuideMealPlanModel.fromJson(res);
      //  print("object: ${dayPlanModel?.data}");
    } else {
      throw Exception();
    }
    return GuideMealPlanModel.fromJson(res);
  }

  Future<GuideMealPlanModel> fetchDinnerPlan() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response =
        await http.get(Uri.parse("${GwcApi.guideMealPlanUrl}/dinner/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      res = jsonDecode(response.body);
      guideMealPlanModel = GuideMealPlanModel.fromJson(res);
      //  print("object: ${dayPlanModel?.data}");
    } else {
      throw Exception();
    }
    return GuideMealPlanModel.fromJson(res);
  }
}
