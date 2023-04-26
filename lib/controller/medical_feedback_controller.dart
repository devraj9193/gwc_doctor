import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/medical_feedback_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';

class MedicalFeedbackController extends GetxController {
  MedicalFeedbackModel? medicalFeedbackModel;

  @override
  void onInit() {
    super.onInit();
    fetchMedicalFeedback();
  }

  Future<MedicalFeedbackModel> fetchMedicalFeedback() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;

    final response =
    await http.get(Uri.parse("${GwcApi.medicalFeedbackAnswerApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("Medical Feedback Url: ${GwcApi.medicalFeedbackAnswerApiUrl}/$userId");
    print("Medical Feedback body: ${response.body}");
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      medicalFeedbackModel = MedicalFeedbackModel.fromJson(res);
      print("Medical Feedback : ${medicalFeedbackModel!.data?.lifestyleHabits}");
    } else {
      throw Exception();
    }
    return MedicalFeedbackModel.fromJson(res);
  }
}
