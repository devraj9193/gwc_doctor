// To parse this JSON data, do
//
//     final evaluationDetailsModel = evaluationDetailsModelFromJson(jsonString);

import 'dart:convert';

EvaluationDetailsModel evaluationDetailsModelFromJson(String str) => EvaluationDetailsModel.fromJson(json.decode(str));

String evaluationDetailsModelToJson(EvaluationDetailsModel data) => json.encode(data.toJson());

class EvaluationDetailsModel {
  EvaluationDetailsModel({
    this.status,
    this.errorCode,
    this.data,
  });

  int? status;
  int? errorCode;
  Data? data;

  factory EvaluationDetailsModel.fromJson(Map<String, dynamic> json) => EvaluationDetailsModel(
    status: json["status"],
    errorCode: json["errorCode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.patientId,
    this.weight,
    this.height,
    this.healthProblem,
    this.listProblems,
    this.listProblemsOther,
    this.listBodyIssues,
    this.tongueCoating,
    this.tongueCoatingOther,
    this.anyUrinationIssue,
    this.urineColor,
    this.urineColorOther,
    this.urineSmell,
    this.urineSmellOther,
    this.urineLookLike,
    this.urineLookLikeOther,
    this.closestStoolType,
    this.anyMedicalIntervationDoneBefore,
    this.anyMedicalIntervationDoneBeforeOther,
    this.anyMedicationConsumeAtMoment,
    this.anyTherapiesHaveDoneBefore,
    this.medicalReport,
    this.mentionIfAnyFoodAffectsYourDigesion,
    this.anySpecialDiet,
    this.anyFoodAllergy,
    this.anyIntolerance,
    this.anySevereFoodCravings,
    this.anyDislikeFood,
    this.noGalssesDay,
    this.anyHabbitOrAddiction,
    this.anyHabbitOrAddictionOther,
    this.afterMealPreference,
    this.afterMealPreferenceOther,
    this.hungerPattern,
    this.hungerPatternOther,
    this.bowelPattern,
    this.bowelPatternOther,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? patientId;
  String? weight;
  String? height;
  String? healthProblem;
  String? listProblems;
  String? listProblemsOther;
  String? listBodyIssues;
  String? tongueCoating;
  String? tongueCoatingOther;
  String? anyUrinationIssue;
  String? urineColor;
  String? urineColorOther;
  String? urineSmell;
  String? urineSmellOther;
  String? urineLookLike;
  String? urineLookLikeOther;
  String? closestStoolType;
  String? anyMedicalIntervationDoneBefore;
  String? anyMedicalIntervationDoneBeforeOther;
  String? anyMedicationConsumeAtMoment;
  String? anyTherapiesHaveDoneBefore;
  String? medicalReport;
  String? mentionIfAnyFoodAffectsYourDigesion;
  String? anySpecialDiet;
  String? anyFoodAllergy;
  String? anyIntolerance;
  String? anySevereFoodCravings;
  String? anyDislikeFood;
  String? noGalssesDay;
  String? anyHabbitOrAddiction;
  String? anyHabbitOrAddictionOther;
  String? afterMealPreference;
  String? afterMealPreferenceOther;
  String? hungerPattern;
  String? hungerPatternOther;
  String? bowelPattern;
  String? bowelPatternOther;
  String? createdAt;
  String? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    patientId: json["patient_id"].toString(),
    weight: json["weight"].toString(),
    height: json["height"].toString(),
    healthProblem: json["health_problem"].toString(),
    listProblems: json["list_problems"].toString(),
    listProblemsOther: json["list_problems_other"].toString(),
    listBodyIssues: json["list_body_issues"].toString(),
    tongueCoating: json["tongue_coating"].toString(),
    tongueCoatingOther: json["tongue_coating_other"].toString(),
    anyUrinationIssue: json["any_urination_issue"].toString(),
    urineColor: json["urine_color"].toString(),
    urineColorOther: json["urine_color_other"].toString(),
    urineSmell: json["urine_smell"].toString(),
    urineSmellOther: json["urine_smell_other"].toString(),
    urineLookLike: json["urine_look_like"].toString(),
    urineLookLikeOther: json["urine_look_like_other"].toString(),
    closestStoolType: json["closest_stool_type"].toString(),
    anyMedicalIntervationDoneBefore: json["any_medical_intervation_done_before"].toString(),
    anyMedicalIntervationDoneBeforeOther: json["any_medical_intervation_done_before_other"].toString(),
    anyMedicationConsumeAtMoment: json["any_medication_consume_at_moment"].toString(),
    anyTherapiesHaveDoneBefore: json["any_therapies_have_done_before"].toString(),
    medicalReport: json["medical_report"].toString(),
    mentionIfAnyFoodAffectsYourDigesion: json["mention_if_any_food_affects_your_digesion"].toString(),
    anySpecialDiet: json["any_special_diet"].toString(),
    anyFoodAllergy: json["any_food_allergy"].toString(),
    anyIntolerance: json["any_intolerance"].toString(),
    anySevereFoodCravings: json["any_severe_food_cravings"].toString(),
    anyDislikeFood: json["any_dislike_food"].toString(),
    noGalssesDay: json["no_galsses_day"].toString(),
    anyHabbitOrAddiction: json["any_habbit_or_addiction"].toString(),
    anyHabbitOrAddictionOther: json["any_habbit_or_addiction_other"].toString(),
    afterMealPreference: json["after_meal_preference"].toString(),
    afterMealPreferenceOther: json["after_meal_preference_other"].toString(),
    hungerPattern: json["hunger_pattern"].toString(),
    hungerPatternOther: json["hunger_pattern_other"].toString(),
    bowelPattern: json["bowel_pattern"].toString(),
    bowelPatternOther: json["bowel_pattern_other"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patient_id": patientId,
    "weight": weight,
    "height": height,
    "health_problem": healthProblem,
    "list_problems": listProblems,
    "list_problems_other": listProblemsOther,
    "list_body_issues": listBodyIssues,
    "tongue_coating": tongueCoating,
    "tongue_coating_other": tongueCoatingOther,
    "any_urination_issue": anyUrinationIssue,
    "urine_color": urineColor,
    "urine_color_other": urineColorOther,
    "urine_smell": urineSmell,
    "urine_smell_other": urineSmellOther,
    "urine_look_like": urineLookLike,
    "urine_look_like_other": urineLookLikeOther,
    "closest_stool_type": closestStoolType,
    "any_medical_intervation_done_before": anyMedicalIntervationDoneBefore,
    "any_medical_intervation_done_before_other": anyMedicalIntervationDoneBeforeOther,
    "any_medication_consume_at_moment": anyMedicationConsumeAtMoment,
    "any_therapies_have_done_before": anyTherapiesHaveDoneBefore,
    "medical_report": medicalReport,
    "mention_if_any_food_affects_your_digesion": mentionIfAnyFoodAffectsYourDigesion,
    "any_special_diet": anySpecialDiet,
    "any_food_allergy": anyFoodAllergy,
    "any_intolerance": anyIntolerance,
    "any_severe_food_cravings": anySevereFoodCravings,
    "any_dislike_food": anyDislikeFood,
    "no_galsses_day": noGalssesDay,
    "any_habbit_or_addiction": anyHabbitOrAddiction,
    "any_habbit_or_addiction_other": anyHabbitOrAddictionOther,
    "after_meal_preference": afterMealPreference,
    "after_meal_preference_other": afterMealPreferenceOther,
    "hunger_pattern": hungerPattern,
    "hunger_pattern_other": hungerPatternOther,
    "bowel_pattern": bowelPattern,
    "bowel_pattern_other": bowelPatternOther,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
