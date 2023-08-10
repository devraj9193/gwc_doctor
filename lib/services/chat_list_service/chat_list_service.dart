import 'package:flutter/material.dart';

import '../../repository/chat_list_repo/chat_list_repository.dart';

class ChatListService extends ChangeNotifier {
  final ChatListRepository repository;

  ChatListService({required this.repository});

  Future getChatListService() async {
    return await repository.getChatListRepo();
  }
}
