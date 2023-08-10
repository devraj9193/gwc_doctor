// To parse this JSON data, do
//
//     final dayTrackerModel = dayTrackerModelFromJson(jsonString);

import 'dart:convert';

DayTrackerModel dayTrackerModelFromJson(String str) => DayTrackerModel.fromJson(json.decode(str));

String dayTrackerModelToJson(DayTrackerModel data) => json.encode(data.toJson());

class DayTrackerModel {
  DayTrackerModel({
    this.status,
    this.errorCode,
    this.key,
    this.data,
  });

  int? status;
  int? errorCode;
  String? key;
  DayTracker? data;

  factory DayTrackerModel.fromJson(Map<String, dynamic> json) => DayTrackerModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"].toString(),
    data: DayTracker.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "data": data?.toJson(),
  };
}

class DayTracker {
  DayTracker({
    this.id,
    this.teamPatientId,
    this.day,
    this.didUMiss,
    this.didUMissAnything,
    this.withdrawalSymptoms,
    this.detoxification,
    this.haveAnyOtherWorries,
    this.eatSomethingOther,
    this.completedCalmMoveModules,
    this.hadAMedicalExamMedications,
    this.trackingAttachment,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? teamPatientId;
  String? day;
  String? didUMiss;
  String? didUMissAnything;
  String? withdrawalSymptoms;
  String? detoxification;
  String? haveAnyOtherWorries;
  String? eatSomethingOther;
  String? completedCalmMoveModules;
  String? hadAMedicalExamMedications;
  String? trackingAttachment;
  String? createdAt;
  String? updatedAt;

  factory DayTracker.fromJson(Map<String, dynamic> json) => DayTracker(
    id: json["id"],
    teamPatientId: json["team_patient_id"].toString(),
    day: json["day"].toString(),
    didUMiss: json["did_u_miss"].toString(),
    didUMissAnything: json["did_u_miss_anything"].toString(),
    withdrawalSymptoms: json["withdrawal_symptoms"].toString(),
    detoxification: json["detoxification"].toString(),
    haveAnyOtherWorries: json["have_any_other_worries"].toString(),
    eatSomethingOther: json["eat_something_other"].toString(),
    completedCalmMoveModules: json["completed_calm_move_modules"].toString(),
    hadAMedicalExamMedications: json["had_a_medical_exam_medications"].toString(),
      trackingAttachment:json['tracking_attachment'].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_patient_id": teamPatientId,
    "day": day,
    "did_u_miss": didUMiss,
    "did_u_miss_anything": didUMissAnything,
    "withdrawal_symptoms": withdrawalSymptoms,
    "detoxification": detoxification,
    "have_any_other_worries": haveAnyOtherWorries,
    "eat_something_other": eatSomethingOther,
    "completed_calm_move_modules": completedCalmMoveModules,
    "had_a_medical_exam_medications": hadAMedicalExamMedications,
    "tracking_attachment":trackingAttachment,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
