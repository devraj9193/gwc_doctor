import '../api_service.dart';

class CalendarListRepo {
  ApiClient apiClient;

  CalendarListRepo({required this.apiClient});

  Future getCalendarListRepo() async{
    return await apiClient.getCalendarListApi();
  }

}