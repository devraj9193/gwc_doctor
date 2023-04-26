import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/maintenance_guide_model.dart';
import '../utils/gwc_apis.dart';

class MaintenanceGuideController extends GetxController {
  MaintenanceGuideModel? maintenanceGuideModel;

  @override
  void onInit() {
    super.onInit();
    fetchPostProgramList();
    fetchMaintenanceGuideList();
  }

  Future<List<GutMaintenanceGuide>?> fetchPostProgramList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http.get(Uri.parse(GwcApi.maintenanceGuideUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("Gut: ${response.body}");
      MaintenanceGuideModel jsonData =
          maintenanceGuideModelFromJson(response.body);
      List<GutMaintenanceGuide>? arrData = jsonData.postProgramList;
      print("status: ${arrData?[0].status}");
      return arrData;
    } else {
      throw Exception();
    }
  }

  Future<List<GutMaintenanceGuide>?> fetchMaintenanceGuideList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http.get(Uri.parse(GwcApi.maintenanceGuideUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    print("Maintenance Guide Url: ${GwcApi.maintenanceGuideUrl}");
    print("Maintenance Guide body: ${response.body}");
    if (response.statusCode == 200) {
      MaintenanceGuideModel jsonData =
          maintenanceGuideModelFromJson(response.body);
      List<GutMaintenanceGuide>? arrData = jsonData.gutMaintenanceGuide;
      return arrData;
    } else {
      throw Exception();
    }
  }
}
