import '../../controller/repository/api_service.dart';
import 'chat_support_repo.dart';
import 'chat_support_service.dart';
import 'package:http/http.dart' as http;

final ChatSupportRepository repository = ChatSupportRepository(
  apiClient: ApiClient(
    httpClient: http.Client(),
  ),
);


Future getKaleyraAccessToken(String kaleyraUID) async{
  final res = await ChatSupportService(repository: repository).getAccessToken(kaleyraUID);
  return res;
}

Future openKaleyraChat(String name, String opponentId, String accessToken) async{
  final res = await ChatSupportService(repository: repository).openKaleyraChat(name, opponentId, accessToken);
  return res;
}