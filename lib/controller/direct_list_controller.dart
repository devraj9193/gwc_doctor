import 'package:doctor_app_new/utils/gwc_apis.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/direct_list_model.dart';
import '../utils/app_config.dart';
import 'package:http/http.dart' as http;

class DirectListController extends GetxController {
  DirectListModel? directListModel;

  @override
  void onInit() {
    super.onInit();
    fetchDirectList();
  }

  Future<List<UsersList>?> fetchDirectList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http.get(Uri.parse(GwcApi.directUsersListApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      DirectListModel jsonData = directListModelFromJson(response.body);
      List<UsersList>? arrData = jsonData.usersList;
      print("Direct: ${response.body}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
