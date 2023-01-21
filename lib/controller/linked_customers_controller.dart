import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customers_list_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';

class LinkedCustomersController extends GetxController {
  CustomersList? customersList;

  @override
  void onInit() {
    super.onInit();
    fetchCustomersList();
  }

  Future<List<Datum>?> fetchCustomersList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response =
        await http.get(Uri.parse(GwcApi.customersListApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
       print("status: ${response.body}");
      CustomersList jsonData = customersListFromJson(response.body);
      List<Datum>? arrData = jsonData.data;
      return arrData;
    } else {
      throw Exception();
    }
  }
}
