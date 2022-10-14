// To parse this JSON data, do
//
//     final dayProgressModel = dayProgressModelFromJson(jsonString);

import 'dart:convert';

DayProgressModel dayProgressModelFromJson(String str) => DayProgressModel.fromJson(json.decode(str));

String dayProgressModelToJson(DayProgressModel data) => json.encode(data.toJson());

class DayProgressModel {
  DayProgressModel({
    this.status,
    this.errorCode,
    this.data,
  });

  int? status;
  int? errorCode;
  List<double>? data;

  factory DayProgressModel.fromJson(Map<String, dynamic> json) => DayProgressModel(
    status: json["status"],
    errorCode: json["errorCode"],
    data: List<double>.from(json["data"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
