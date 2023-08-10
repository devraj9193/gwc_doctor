import '../api_service.dart';

class ProgramRepository{
  ApiClient? apiClient;

  ProgramRepository({required this.apiClient}) : assert(apiClient != null);

  Future getCombinedMealRepo(String userId) async{
    return await apiClient?.getCombinedMealApi(userId);
  }

  Future getProgressRepo(String userId) async{
    return await apiClient?.getProgressApi(userId);
  }

  Future getDailyProgressMealRepo(String selectedDay, String detoxOrHealing) async{
    return await apiClient?.getDailyProgressMealPlanApi(selectedDay, detoxOrHealing);
  }

  Future getAllDaysTrackerRepo() async{
    return await apiClient?.getAllDayTrackerApi();
  }

}