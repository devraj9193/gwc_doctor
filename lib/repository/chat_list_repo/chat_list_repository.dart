
import '../api_service.dart';

class ChatListRepository{
  ApiClient? apiClient;

  ChatListRepository({required this.apiClient}) : assert(apiClient != null);

  Future getChatListRepo() async{
    return await apiClient?.getKaleyraChatListApi();
  }
}