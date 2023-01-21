import 'dart:convert';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/consultation_model.dart';
import '../utils/gwc_apis.dart';

class ConsultationController extends GetxController {
  ConsultationModel? consultationModel;

  @override
  void onInit() {
    super.onInit();
    fetchConsultation();
    fetchAppointmentList();
    fetchDocumentUploadList();
  }

  Future<ConsultationModel>? fetchConsultation() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response =
        await http.get(Uri.parse(GwcApi.consultationUrl), headers: {
      'Authorization': 'Bearer $token',
    });
   // print("Result: ${response.body}");
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);

      consultationModel = ConsultationModel.fromJson(res);
      // print("Result: ${consultationModel?.completedConsultation}");
    } else {
      throw Exception();
    }
    return ConsultationModel.fromJson(res);
  }

  Future<List<Appointment>?> fetchAppointmentList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response =
        await http.get(Uri.parse(GwcApi.consultationUrl), headers: {
      'Authorization': 'Bearer $token',
    });
   // print("Result: ${response.body}");
    if (response.statusCode == 200) {
      ConsultationModel jsonData = consultationModelFromJson(response.body);
      List<Appointment>? arrData = jsonData.appointmentList;
      //   print("status: ${arrData?[0].status}");
      return arrData;
    } else {
      throw Exception();
    }
  }

  Future<List<DocumentUpload>?> fetchDocumentUploadList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response =
        await http.get(Uri.parse(GwcApi.consultationUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    //print("Result: ${response.body}");
    if (response.statusCode == 200) {
      ConsultationModel jsonData = consultationModelFromJson(response.body);
      List<DocumentUpload>? arrData = jsonData.documentUpload;
     // print("status: ${arrData?[0].status}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
