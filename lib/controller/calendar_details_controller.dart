import 'package:doctor_app_new/utils/gwc_apis.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/calendar_model.dart';
import '../utils/app_config.dart';
import 'package:http/http.dart' as http;

class CalendarDetailsController extends GetxController {
  CalendarModel? calendarModel;

  @override
  void onInit() {
    super.onInit();
    fetchCalendarList();
  }

  Future<List<Meeting>?> fetchCalendarList() async {
    DateTime now =  DateTime. now();
    DateTime lastDayOfMonth =  DateTime(now. year, now. month , now. day - 7);
    DateTime nextDayOfMonth =  DateTime(now. year, now. month , now. day + 7);
    var startDate = "${lastDayOfMonth.year}-${lastDayOfMonth.month}-${lastDayOfMonth.day}";
    var endDate = "${nextDayOfMonth.year}-${nextDayOfMonth.month}-${nextDayOfMonth.day}";
    print(startDate);
    print(endDate);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken);
    print(token);
    final response = await http.get(Uri.parse("${GwcApi.calendarUrl}?start=$startDate&end=$endDate"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      CalendarModel jsonData = calendarModelFromJson(response.body);
      List<Meeting>? arrData = jsonData.data;
      print("status: ${response.body}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
