import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customer_call_model.dart';
import '../utils/app_config.dart';
import '../utils/gwc_apis.dart';

class CustomerCallController extends GetxController {
  CustomerCallModel? customerCallModel;

  @override
  void onInit() {
    super.onInit();
    fetchCustomersCall();
  }

  Future<CustomerCallModel> fetchCustomersCall() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id");

    final response = await http
        .get(Uri.parse("${GwcApi.callApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("Customer Profile:$userId");
    print("Customer Profile:$token");
    print("Customer Profile:${response.body}");
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      customerCallModel = CustomerCallModel.fromJson(res);
      print("Name: ${customerCallModel!.data}");
    } else {
      throw Exception();
    }
    return CustomerCallModel.fromJson(res);
  }
}
