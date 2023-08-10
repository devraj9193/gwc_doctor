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

class FollowUpCallsRepo {
  ApiClient apiClient;

  FollowUpCallsRepo({required this.apiClient}) : assert(apiClient != null);

  Future getFollowUpCallsListRepo(String selectedDate) async{
    return await apiClient.getFollowUpCallsListApi(selectedDate);
  }
}