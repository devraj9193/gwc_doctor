
import '../../repository/api_service.dart';

class DoctorMemberProfileRepository{
  ApiClient apiClient;

  DoctorMemberProfileRepository({required this.apiClient}) : assert(apiClient != null);

  Future getDoctorProfileRepo(String accessToken) async{
    return await apiClient.getDoctorMemberProfileApi(accessToken);
  }
}