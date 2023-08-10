import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';
import '../model/day_progress_model.dart';

class DayProgressController extends GetxController {
  DayProgressModel? dayProgressModel;

  @override
  void onInit() {
    super.onInit();
    fetchDayProgressList();
  }

  Future fetchDayProgressList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;

    final response = await http
        .get(Uri.parse("${GwcApi.dayProgressListUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("progress : ${GwcApi.dayProgressListUrl}/$userId");
    print("progress : ${response.body}");
    if (response.statusCode == 200) {
      DayProgressModel jsonData = dayProgressModelFromJson(response.body);
      List<double>? arrData = jsonData.detoxDayWiseProgress;
      print("status: ${arrData?[0]}");
      print("status: ${arrData?[1]}");
      return jsonData;
    } else {
      throw Exception();
    }
  }
}
