import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/success_team_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';

class GwcTeamController extends GetxController {
  SuccessList? successList;

  @override
  void onInit() {
    super.onInit();
    fetchSuccessList();
  }

  Future<List<SuccessTeam>?> fetchSuccessList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
print("token : $token");
    final response =
    await http.get(Uri.parse(GwcApi.successTeamListApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("status: ${response.body}");
      SuccessList jsonData = successListFromJson(response.body);
      List<SuccessTeam>? arrData = jsonData.data;
      print("status: ${arrData?[0].email}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
