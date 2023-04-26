// To parse this JSON data, do
//
//     final transitionAnswerModel = transitionAnswerModelFromJson(jsonString);

import 'dart:convert';

TransitionAnswerModel transitionAnswerModelFromJson(String str) => TransitionAnswerModel.fromJson(json.decode(str));

String transitionAnswerModelToJson(TransitionAnswerModel data) => json.encode(data.toJson());

class TransitionAnswerModel {
  TransitionAnswerModel({
     this.status,
     this.errorCode,
     this.key,
     this.data,
  });

  int? status;
  int? errorCode;
  String? key;
  Data? data;

  factory TransitionAnswerModel.fromJson(Map<String, dynamic> json) => TransitionAnswerModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
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
  String? createdAt;
  String? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    teamPatientId: json["team_patient_id"],
    day: json["day"],
    didUMiss: json["did_u_miss"],
    didUMissAnything: json["did_u_miss_anything"],
    withdrawalSymptoms: json["withdrawal_symptoms"],
    detoxification: json["detoxification"],
    haveAnyOtherWorries: json["have_any_other_worries"],
    eatSomethingOther: json["eat_something_other"],
    completedCalmMoveModules: json["completed_calm_move_modules"],
    hadAMedicalExamMedications: json["had_a_medical_exam_medications"],
    createdAt:json["created_at"],
    updatedAt:json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
