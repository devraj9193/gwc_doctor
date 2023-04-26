import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customer_mr_reports_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';
import '../widgets/widgets.dart';

class MRReportsController extends GetxController {
  MrReportsModel? mrReportsModel;

  @override
  void onInit() {
    super.onInit();
    fetchPersonalDetails();
    fetchMRReportsList();
    fetchAfterMRReportsList();
  }

  Future<MrReportsModel>? fetchPersonalDetails() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var teamPatientId = preferences.getString("team_patient_id");
    final response = await http
        .get(Uri.parse("${GwcApi.customerMRReport}/$teamPatientId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      print("userReportsResponse: ${response.body}");
      mrReportsModel = MrReportsModel.fromJson(res);
      print("Result: ${mrReportsModel?.data?.status}");
    } else {
      buildSnackBar("Error Loading Data!",
          "Server responded : ${response.statusCode}:${response.reasonPhrase.toString()}");
    }
    return MrReportsModel.fromJson(res);
  }

  Future<List<Report>?> fetchMRReportsList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var teamPatientId = preferences.getString("team_patient_id");

    final response = await http
        .get(Uri.parse("${GwcApi.customerMRReport}/$teamPatientId"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("userReportsTeamPatientId : $teamPatientId");
    print("userReportsUrl : ${GwcApi.customerMRReport}/$teamPatientId");
    print("userReportsResponse: ${response.body}");

    if (response.statusCode == 200) {
      MrReportsModel jsonData = mrReportsModelFromJson(response.body);
      List<Report>? arrData = jsonData.reports;
      print("reportsList: ${response.body}");
      print("status: ${arrData?[0].report}");
      return arrData;
    } else {
      throw Exception();
    }
  }

  Future<List<Report>?> fetchAfterMRReportsList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var teamPatientId = preferences.getString("team_patient_id");

    final response = await http
        .get(Uri.parse("${GwcApi.customerMRReport}/$teamPatientId"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("userReportsTeamPatientId : $teamPatientId");
    print("userReportsUrl : ${GwcApi.customerMRReport}/$teamPatientId");
    print("userReportsResponse: ${response.body}");

    if (response.statusCode == 200) {
      MrReportsModel jsonData = mrReportsModelFromJson(response.body);
      List<Report>? arrData = jsonData.afterReports;
      print("reportsList: ${response.body}");
      print("status: ${arrData?[0].report}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
