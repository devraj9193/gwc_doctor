class KaleyraChatListModel {
  String userId;
  List<ChatList> chatList;

  KaleyraChatListModel({
    required this.userId,
    required this.chatList,
  });

  factory KaleyraChatListModel.fromJson(Map<String, dynamic> json) => KaleyraChatListModel(
    userId: json["user_id"],
    chatList: List<ChatList>.from(json["chat_list"].map((x) => ChatList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "chat_list": List<dynamic>.from(chatList.map((x) => x.toJson())),
  };
}

class ChatList {
  List<String> users;
  String channelId;
  int unreadMessagesCount;
  LastMessage? lastMessage;

  ChatList({
    required this.users,
    required this.channelId,
    required this.unreadMessagesCount,
    this.lastMessage,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
    users: List<String>.from(json["users"].map((x) => x)),
    channelId: json["channel_id"],
    unreadMessagesCount: json["unread_messages_count"],
    lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x)),
    "channel_id": channelId,
    "unread_messages_count": unreadMessagesCount,
    "last_message": lastMessage?.toJson(),
  };
}

class LastMessage {
  String messageId;
  String body;
  String from;
  DateTime date;
  Type type;

  LastMessage({
    required this.messageId,
    required this.body,
    required this.from,
    required this.date,
    required this.type,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    messageId: json["message_id"],
    body: json["body"],
    from: json["from"],
    date: DateTime.parse(json["date"]),
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "body": body,
    "from": from,
    "date": date.toIso8601String(),
    "type": typeValues.reverse[type],
  };
}

enum Type { TEXT }

final typeValues = EnumValues({
  "text": Type.TEXT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
