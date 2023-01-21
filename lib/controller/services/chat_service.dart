import 'package:flutter/material.dart';

import '../../model/quick_blox_repository/message_repo.dart';

class ChatService extends ChangeNotifier{
  late final MessageRepository repository;

  ChatService({required this.repository}) : assert(repository != null);

  Future getChatGroupIdService(String userId) async{
    return await repository.getChatGroupIdRepo(userId);
  }

  Future getSuccessChatGroupIdService(String userId) async{
    return await repository.getSuccessChatGroupIdRepo(userId);
  }
}