import 'dart:convert';

import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/day_plan_model.dart';
import '../model/preparatory_transition_model.dart';
import '../utils/gwc_apis.dart';

class PreparatoryController extends GetxController {
  PreparatoryTransitionModel? preparatoryTransitionModel;

  Future<PreparatoryTransitionModel> fetchDayPlanList() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response = await http
        .get(Uri.parse("${GwcApi.preparatoryApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    try{
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      res = jsonDecode(response.body);
      preparatoryTransitionModel = PreparatoryTransitionModel.fromJson(res);
      print("object: ${preparatoryTransitionModel?.data}");
    } else {
      throw Exception();
    }}catch(e){
      print(e);
    }

    return PreparatoryTransitionModel.fromJson(res);
  }
}
