import 'dart:convert';

import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/day_plan_model.dart';
import '../utils/gwc_apis.dart';

class DayPlanListController extends GetxController {
  DayPlanModel? dayPlanModel;

  Future<DayPlanModel> fetchDayPlanList(String selectedDay) async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;

    final response = await http
        .get(Uri.parse("$dayMealListUrl/$selectedDay/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      dayPlanModel = DayPlanModel.fromJson(res);
      DayPlanModel jsonData = dayPlanModelFromJson(response.body);
      // List<DayPlan>? arrData = jsonData.data;
      // print("status: ${arrData?[0].name}");
      // return arrData;
    } else {
      throw Exception();
    }
    return DayPlanModel.fromJson(res);
  }
}
