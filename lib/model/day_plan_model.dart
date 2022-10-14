// To parse this JSON data, do
//
//     final dayPlanModel = dayPlanModelFromJson(jsonString);

import 'dart:convert';

DayPlanModel dayPlanModelFromJson(String str) =>
    DayPlanModel.fromJson(json.decode(str));

String dayPlanModelToJson(DayPlanModel data) => json.encode(data.toJson());

class DayPlanModel {
  DayPlanModel({
    this.status,
    this.errorCode,
    this.programDay,
    this.comment,
    this.data,
  });

  int? status;
  int? errorCode;
  String? programDay;
  String? comment;
  List<DayPlan>? data;

  factory DayPlanModel.fromJson(Map<String, dynamic> json) => DayPlanModel(
        status: json["status"],
        errorCode: json["errorCode"],
        programDay: json["program_day"],
        comment: json["comment"],
        data: List<DayPlan>.from(json["data"].map((x) => DayPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "program_day": programDay,
        "comment": comment,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DayPlan {
  DayPlan({
    this.type,
    this.mealTime,
    this.itemId,
    this.name,
    this.mealWeight,
    this.weightType,
    this.url,
    this.status,
  });

  String? type;
  String? mealTime;
  int? itemId;
  String? name;
  String? mealWeight;
  String? weightType;
  String? url;
  String? status;

  factory DayPlan.fromJson(Map<String, dynamic> json) => DayPlan(
        type: json["type"],
        mealTime: json["meal_time"],
        itemId: json["item_id"],
        name: json["name"],
        mealWeight: json["meal_weight"],
        weightType: json["weight_type"],
        url: json["url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "meal_time": mealTime,
        "item_id": itemId,
        "name": name,
        "meal_weight": mealWeight,
        "weight_type": weightType,
        "url": url,
        "status": status,
      };
}
