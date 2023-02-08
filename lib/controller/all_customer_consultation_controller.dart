import 'package:doctor_app_new/utils/app_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customers_list_models/all_customer_consultation_model.dart';
import '../utils/gwc_apis.dart';

class AllCustomerConsultationController extends GetxController {
  AllCustomerConsultationModel? allCustomerConsultationModel;

  @override
  void onInit() {
    super.onInit();
    fetchAppointmentList();
  }

  Future<List<Appointment>?> fetchAppointmentList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;

    final response = await http
        .get(Uri.parse(GwcApi.newConsultationDocumentApiUrl), headers: {
      'Authorization': 'Bearer $token',
    });
    // print("Result: ${response.body}");
    if (response.statusCode == 200) {
      AllCustomerConsultationModel jsonData = allCustomerConsultationModelFromJson(response.body);
      List<Appointment>? arrData = jsonData.appointmentList;
      print("status Consultation: ${arrData?[0].status}");
      return arrData;
    } else {
      throw Exception();
    }
  }
}
