// To parse this JSON data, do
//
//     final protocolGraphModel = protocolGraphModelFromJson(jsonString);

import 'dart:convert';

ProtocolGraphModel protocolGraphModelFromJson(String str) => ProtocolGraphModel.fromJson(json.decode(str));

String protocolGraphModelToJson(ProtocolGraphModel data) => json.encode(data.toJson());

class ProtocolGraphModel {
  ProtocolGraphModel({
    this.status,
    this.errorCode,
    this.key,
    this.days,
    this.data,
    this.teamPatientId,
  });

  int? status;
  int? errorCode;
  String? key;
  int? days;
  Map<String, Graph>? data;
  int? teamPatientId;

  factory ProtocolGraphModel.fromJson(Map<String, dynamic> json) => ProtocolGraphModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    days: json["days"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, Graph>(k, Graph.fromJson(v))),
    teamPatientId: json["team_patient_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "days": days,
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "team_patient_id": teamPatientId,
  };
}

class Graph {
  Graph({
    this.breakfast,
    this.lunch,
    this.dinner,
  });

  String? breakfast;
  String? lunch;
  String? dinner;

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    breakfast: json["breakfast"],
    lunch: json["lunch"],
    dinner: json["dinner"],
  );

  Map<String, dynamic> toJson() => {
    "breakfast": breakfast,
    "lunch": lunch,
    "dinner": dinner,
  };
}
