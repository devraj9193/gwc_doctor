// To parse this JSON data, do
//
//     final sentReplyModel = sentReplyModelFromJson(jsonString);

import 'dart:convert';

SentReplyModel sentReplyModelFromJson(String str) => SentReplyModel.fromJson(json.decode(str));

String sentReplyModelToJson(SentReplyModel data) => json.encode(data.toJson());

class SentReplyModel {
  String? message;
  int? id;

  SentReplyModel({
     this.message,
     this.id,
  });

  factory SentReplyModel.fromJson(Map<String, dynamic> json) => SentReplyModel(
    message: json["message"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "id": id,
  };
}
