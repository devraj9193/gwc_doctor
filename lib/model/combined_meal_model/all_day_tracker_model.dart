// To parse this JSON data, do
//
//     final allDayTrackerMOdel = allDayTrackerMOdelFromJson(jsonString);

import 'dart:convert';

AllDayTrackerModel allDayTrackerModelFromJson(String str) => AllDayTrackerModel.fromJson(json.decode(str));

String allDayTrackerModelToJson(AllDayTrackerModel data) => json.encode(data.toJson());

class AllDayTrackerModel {
  int? status;
  int? errorCode;
  String? key;
  Preparatory? preparatory;
  List<Detox>? detox;
  List<Detox>? healing;
  List<Detox>? nourish;

  AllDayTrackerModel({
     this.status,
     this.errorCode,
     this.key,
     this.preparatory,
     this.detox,
     this.healing,
     this.nourish,
  });

  factory AllDayTrackerModel.fromJson(Map<String, dynamic> json) => AllDayTrackerModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    preparatory: Preparatory.fromJson(json["Preparatory"]),
    detox: List<Detox>.from(json["Detox"].map((x) => Detox.fromJson(x))),
    healing: List<Detox>.from(json["Healing"].map((x) => Detox.fromJson(x))),
    nourish: List<Detox>.from(json["Nourish"].map((x) => Detox.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "Preparatory": preparatory?.toJson(),
    "Detox": List<dynamic>.from(detox!.map((x) => x.toJson())),
    "Healing": List<dynamic>.from(healing!.map((x) => x.toJson())),
    "Nourish": List<dynamic>.from(nourish!.map((x) => x.toJson())),
  };
}

class Detox {
  int? id;
  int? teamPatientId;
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
  int? mealPlanType;
  String? createdAt;
  String? updatedAt;
  String? trackingAttachmentFullPath;

  Detox({
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
    this.mealPlanType,
     this.createdAt,
     this.updatedAt,
    this.trackingAttachmentFullPath,
  });

  factory Detox.fromJson(Map<String, dynamic> json) => Detox(
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
    trackingAttachment: json["tracking_attachment"],
    mealPlanType: json["meal_plan_type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    trackingAttachmentFullPath:json['tracking_attachment_full_path'],
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
    "tracking_attachment": trackingAttachment,
    "meal_plan_type": mealPlanType,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "tracking_attachment_full_path":trackingAttachmentFullPath,
  };
}

class Preparatory {
  int? id;
  int?userId;
  int ?teamPatientId;
  String? hungerImproved;
  String? appetiteImproved;
  String? feelingLight;
  String? feelingEnergetic;
  String? mildReduction;
  String? createdAt;
  String? updatedAt;

  Preparatory({
    required this.id,
    required this.userId,
    required this.teamPatientId,
    required this.hungerImproved,
    required this.appetiteImproved,
    required this.feelingLight,
    required this.feelingEnergetic,
    required this.mildReduction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Preparatory.fromJson(Map<String, dynamic> json) => Preparatory(
    id: json["id"],
    userId: json["user_id"],
    teamPatientId: json["team_patient_id"],
    hungerImproved: json["hunger_improved"],
    appetiteImproved: json["appetite_improved"],
    feelingLight: json["feeling_light"],
    feelingEnergetic: json["feeling_energetic"],
    mildReduction: json["mild_reduction"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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

