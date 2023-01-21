import 'package:doctor_app_new/model/notification_list_model.dart';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/gwc_apis.dart';

class NotificationListController extends GetxController {
  NotificationList? notificationList;

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  Future<List<NotificationModel>?> getNotificationList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http.get(Uri.parse(GwcApi.notificationListUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("notification : ${response.body}");
      NotificationList jsonData = notificationListFromJson(response.body);
      List<NotificationModel>? arrData = jsonData.data;
      //   print("status: ${arrData?[0].status}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
