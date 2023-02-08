import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/preparatory_answer_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';

class PreparatoryAnswerController extends GetxController {
  PreparatoryAnswerModel? preparatoryAnswerModel;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<PreparatoryAnswerModel> fetchUserProfile() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;

    final response =
    await http.get(Uri.parse("${GwcApi.preparatoryAnswerApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      preparatoryAnswerModel = PreparatoryAnswerModel.fromJson(res);
      print(preparatoryAnswerModel!.trackingPrepMeals?.hungerImproved);
    } else {
      throw Exception();
    }
    return PreparatoryAnswerModel.fromJson(res);
  }
}
