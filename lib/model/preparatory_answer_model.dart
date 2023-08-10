// To parse this JSON data, do
//
//     final preparatoryAnswerModel = preparatoryAnswerModelFromJson(jsonString);

import 'dart:convert';

PreparatoryAnswerModel preparatoryAnswerModelFromJson(String str) =>
    PreparatoryAnswerModel.fromJson(json.decode(str));

String preparatoryAnswerModelToJson(PreparatoryAnswerModel data) =>
    json.encode(data.toJson());

class PreparatoryAnswerModel {
  PreparatoryAnswerModel({
    this.status,
    this.errorCode,
    this.key,
    this.trackingPrepMeals,
  });

  int? status;
  int? errorCode;
  String? key;
  TrackingPrepMeals? trackingPrepMeals;

  factory PreparatoryAnswerModel.fromJson(Map<String, dynamic> json) =>
      PreparatoryAnswerModel(
        status: json["status"],
        errorCode: json["errorCode"],
        key: json["key"].toString(),
        trackingPrepMeals:
            TrackingPrepMeals.fromJson(json["tracking_prep_meals"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "key": key,
        "tracking_prep_meals": trackingPrepMeals?.toJson(),
      };
}

class TrackingPrepMeals {
  TrackingPrepMeals({
    this.id,
    this.userId,
    this.teamPatientId,
    this.hungerImproved,
    this.appetiteImproved,
    this.feelingLight,
    this.feelingEnergetic,
    this.mildReduction,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? teamPatientId;
  String? hungerImproved;
  String? appetiteImproved;
  String? feelingLight;
  String? feelingEnergetic;
  String? mildReduction;
  String? createdAt;
  String? updatedAt;

  factory TrackingPrepMeals.fromJson(Map<String, dynamic> json) =>
      TrackingPrepMeals(
        id: json["id"],
        userId: json["user_id"].toString(),
        teamPatientId: json["team_patient_id"].toString(),
        hungerImproved: json["hunger_improved"].toString(),
        appetiteImproved: json["appetite_improved"].toString(),
        feelingLight: json["feeling_light"].toString(),
        feelingEnergetic: json["feeling_energetic"].toString(),
        mildReduction: json["mild_reduction"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "team_patient_id": teamPatientId,
        "hunger_improved": hungerImproved,
        "appetite_improved": appetiteImproved,
        "feeling_light": feelingLight,
        "feeling_energetic": feelingEnergetic,
        "mild_reduction": mildReduction,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
