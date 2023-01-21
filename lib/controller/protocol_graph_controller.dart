import 'dart:convert';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/protocol_graph_model.dart';
import '../utils/gwc_apis.dart';

class ProtocolGraphController extends GetxController {
  ProtocolGraphModel? protocolGraphModel;

  @override
  void onInit() {
    super.onInit();
    fetchProtocolGraph;
  }

  Future<ProtocolGraphModel> fetchProtocolGraph(String selectedDay) async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response =
        await http.get(Uri.parse("${GwcApi.protocolGraphUrl}/$userId/$selectedDay"), headers: {
      'Authorization': 'Bearer $token',
    });print("Graph: ${response.body}");
    if (response.statusCode == 200) {

      res = jsonDecode(response.body);
      protocolGraphModel = ProtocolGraphModel.fromJson(res);
      //  print("object: ${dayPlanModel?.data}");
    } else {
      throw Exception();
    }
    return ProtocolGraphModel.fromJson(res);
  }
}
