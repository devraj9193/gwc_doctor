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
  Map<String, List<DayPlan>>? data;

  factory DayPlanModel.fromJson(Map<String, dynamic> json) => DayPlanModel(
    status: json["status"],
    errorCode: json["errorCode"],
    programDay: json["program_day"],
    comment: json["comment"],
    data: Map.from(json["data"]).map((k, v) =>
        MapEntry<String, List<DayPlan>>(
            k, List<DayPlan>.from(v.map((x) => DayPlan.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "program_day": programDay,
    "comment": comment,
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))),
  };
}

class DayPlan {
  DayPlan({
    this.id,
    this.type,
    this.mealTime,
    this.itemId,
    this.name,
    this.mealWeight,
    this.weightType,
    this.url,
    this.status,
    this.itemPhoto,
    this.subTitle,
    this.benefits,
    this.note,
  });

  int? id;
  String? type;
  String? mealTime;
  int? itemId;
  String? name;
  String? mealWeight;
  String? weightType;
  String? url;
  String? status;
  String? itemPhoto;
  String? subTitle;
  String? benefits;
  String? note;

  factory DayPlan.fromJson(Map<String, dynamic> json) => DayPlan(
    id: json["id"],
    type: json["type"],
    mealTime: json["meal_time"],
    itemId: json["item_id"],
    name: json["name"],
    mealWeight: json["meal_weight"],
    weightType: json["weight_type"],
    url: json["url"],
    status: json["status"],
    itemPhoto: json["item_photo"],
    subTitle: json['sub_title'],
    benefits: json['benefits'],
    note: json['note'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "meal_time": mealTime,
    "item_id": itemId,
    "name": name,
    "meal_weight": mealWeight,
    "weight_type": weightType,
    "url": url,
    "status": status,
    "item_photo": itemPhoto,
    "sub_title": subTitle,
    "benefits": benefits,
    "note": note,
  };
}
