import 'dart:convert';

import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/transition_meal_plan_model.dart';
import '../utils/gwc_apis.dart';

class TransitionController extends GetxController {
  TransitionMealPlanModel? transitionMealPlanModel;

  @override
  void onInit() {
    super.onInit();
    fetchDayPlanList();
  }

  Future<TransitionMealPlanModel> fetchDayPlanList() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response = await http
        .get(Uri.parse("${GwcApi.transitionApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      res = jsonDecode(response.body);
      transitionMealPlanModel = TransitionMealPlanModel.fromJson(res);
      print("object: ${transitionMealPlanModel?.data}");
    }
    else {
      throw Exception();
    }
    return TransitionMealPlanModel.fromJson(res);
  }
}
