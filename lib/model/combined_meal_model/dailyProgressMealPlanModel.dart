// To parse this JSON data, do
//
//     final dailyProgressMealPlan = dailyProgressMealPlanFromJson(jsonString);

import 'dart:convert';

import '../day_tracker_model.dart';
import 'detox_nourish_model/detox_healing_common_model/child_meal_plan_details_model1.dart';

DailyProgressMealPlanModel dailyProgressMealPlanModelFromJson(String str) => DailyProgressMealPlanModel.fromJson(json.decode(str));

String dailyProgressMealPlanModelToJson(DailyProgressMealPlanModel data) => json.encode(data.toJson());

class DailyProgressMealPlanModel {
  int? status;
  int? errorCode;
  int? programDay;
  String? comment;
  Map<String, List<ChildMealPlanDetailsModel1>>? data;
  DayTracker? userProgramStatusTracker;
  String? note;

  DailyProgressMealPlanModel({
     this.status,
     this.errorCode,
     this.programDay,
     this.comment,
    required this.data,
    this.userProgramStatusTracker,
     this.note,
  });

  factory DailyProgressMealPlanModel.fromJson(Map<String, dynamic> json) => DailyProgressMealPlanModel(
    status: json["status"],
    errorCode: json["errorCode"],
    programDay: json["program_day"],
    comment: json["comment"],
    data: Map.from(json["data"]).map((k, v) =>
        MapEntry<String, List<ChildMealPlanDetailsModel1>>(
            k, List<ChildMealPlanDetailsModel1>.from(v.map((x) => ChildMealPlanDetailsModel1.fromJson(x))))),
    userProgramStatusTracker: DayTracker.fromJson(json["user_program_status_tracker"]),
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "program_day": programDay,
    "comment": comment,
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))),
    "user_program_status_tracker": userProgramStatusTracker?.toJson(),
    "note": note,
  };
}