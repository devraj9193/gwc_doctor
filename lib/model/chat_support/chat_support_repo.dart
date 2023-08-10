
import '../../repository/api_service.dart';

class ChatSupportRepository{
  ApiClient apiClient;

  ChatSupportRepository({required this.apiClient}) : assert(apiClient != null);

  Future getKaleyraAccessTokenRepo(String kaleyraUID) async{
    return await apiClient.getKaleyraAccessTokenApi(kaleyraUID);
  }
}