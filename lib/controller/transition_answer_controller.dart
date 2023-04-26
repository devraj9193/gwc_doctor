import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/transition_answer_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';

class TransitionAnswerController extends GetxController {
  TransitionAnswerModel? transitionAnswerModel;

  @override
  void onInit() {
    super.onInit();
    fetchTransitionAnswer;
  }

  Future<TransitionAnswerModel>? fetchTransitionAnswer(String selectedDay) async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;

    final response =
    await http.get(Uri.parse("${GwcApi.transitionAnswerApiUrl}/$userId/$selectedDay"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("${GwcApi.transitionAnswerApiUrl}/$userId/$selectedDay");
    print("Day: ${response.body}");
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      transitionAnswerModel = TransitionAnswerModel.fromJson(res);
      print("Result: ${transitionAnswerModel?.data?.createdAt}");
    } else {}
    return TransitionAnswerModel.fromJson(res);
  }
}
