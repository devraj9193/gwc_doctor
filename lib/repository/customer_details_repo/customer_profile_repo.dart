// import '../../service/api_service.dart';
//
// class uvDeskRepository{
//   ApiClient apiClient;
//
//   uvDeskRepository({required this.apiClient}) : assert(apiClient != null);
//
//   Future uvDeskTicketRaiseRepo(String description, String title) async{
//     return await apiClient.uvDeskTicketRaiseApi(description, title);
//   }
// }


import '../api_service.dart';

class CustomerProfileRepo {
  ApiClient apiClient;

  CustomerProfileRepo({required this.apiClient}) : assert(apiClient != null);

  Future getCustomerProfileRepo(String userId) async{
    return await apiClient.getCustomerProfileApi(userId);
  }

}