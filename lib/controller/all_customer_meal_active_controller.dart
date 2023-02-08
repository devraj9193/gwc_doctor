import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customers_list_models/all_customer_meal_active_model.dart';
import '../utils/gwc_apis.dart';

class AllCustomerMealActiveListController extends GetxController {
  AllCustomerMealActiveModel? allCustomerMealActiveModel;

  @override
  void onInit() {
    super.onInit();
    fetchMealPlanList();
    fetchActiveList();
  }

  Future<List<MealPlanList>?> fetchMealPlanList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http.get(Uri.parse(GwcApi.newMealActiveListApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      AllCustomerMealActiveModel jsonData = mealActiveModelFromJson(response.body);
      List<MealPlanList>? arrData = jsonData.mealPlanList;
      //print("status: ${arrData?[0].userDetails?.status}");
      return arrData;
    } else {
      throw Exception();
    }
  }

  Future<List<ActiveDetail>?> fetchActiveList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http.get(Uri.parse(GwcApi.newMealActiveListApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    print("Active List: ${response.body}");
    if (response.statusCode == 200) {
      AllCustomerMealActiveModel jsonData = mealActiveModelFromJson(response.body);
      List<ActiveDetail>? arrData = jsonData.activeDetails;
      print("diagnosis: ${arrData?[1].userFinalDiagnosis}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
