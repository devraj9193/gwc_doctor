// To parse this JSON data, do
//
//     final customerCallModel = customerCallModelFromJson(jsonString);

import 'dart:convert';

CustomerCallModel customerCallModelFromJson(String str) => CustomerCallModel.fromJson(json.decode(str));

String customerCallModelToJson(CustomerCallModel data) => json.encode(data.toJson());

class CustomerCallModel {
  CustomerCallModel({
    this.status,
    this.errorCode,
    this.key,
    this.data,
  });

  int? status;
  int? errorCode;
  String? key;
  String? data;

  factory CustomerCallModel.fromJson(Map<String, dynamic> json) => CustomerCallModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "data": data,
  };
}
