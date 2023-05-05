import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'chat_support_repo.dart';

class ChatSupportService extends ChangeNotifier {
  final ChatSupportRepository repository;

  ChatSupportService({required this.repository}) : assert(repository != null);

  Future getAccessToken(String kaleyraUID) async {
    return await repository.getKaleyraAccessTokenRepo(kaleyraUID);
  }

  listenForCall() {
    String eventChannelName = "callNative1";

    print("Listen call");
    var channel1 = EventChannel(eventChannelName);

    //same key is used in the native code also
    try {
      print('called');
      var result;
      final result1 = channel1.receiveBroadcastStream('eventChannel');
      print("eventchannel: ${result1.asBroadcastStream().listen((event) {
        // ("type","onNetworkStatusChanged");
        print("event==>: $event");
        // if(event['type'].toString().contains(Constants.onNetworkChange)){
        //   _deviceNetworkStatus = event['status'];
        // }
        // if(event['type'].toString().contains(Constants.onStatusChange)){
        //   _deviceStatus = event['status'].toString().contains("false") ? false : true;
        // }
      })}");
      print("result1: $result1");
      notifyListeners();
      return result1;
    } on PlatformException catch (e) {
      print('error: $e');
      notifyListeners();
      // Unable to open the browser print(e);
    }
  }

  /// kaleyra Chat methods****************
  ///   // we need to get access token and need to pass here...

  Future openKaleyraChat(
      String name, String opponentId, String accessToken) async {
    final String channelName = "callNative";

    var channel = MethodChannel(channelName);
    print("CHAT");

    Map m = {
      'user_id': name,
      'access_token': accessToken,
      'opponent_id': opponentId
    };

    print("m: $m");

    try {
      listenForCall();
      var result =
          await channel.invokeMethod("chat_support", m).whenComplete(() {
        // _showProgress = false;
        // notifyListeners();
      });
      print("Provider openKaleyraChat" + result.toString());
      // final users = result['users'];
      // print("users: ${users.runtimeType}");
      notifyListeners();
    } on PlatformException catch (e) {
      print("Provider openKaleyraChat error" + e.message.toString());
      // _errorMsg = e.message.toString();
      // _isGetHomeListSuccess = false;
      notifyListeners();
    }
    // return _isGetHomeListSuccess;
  }
}
