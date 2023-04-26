import 'package:doctor_app_new/model/preparatory_transition_model.dart';

class TransitionMealPlanModel {
  int? status;
  int? errorCode;
  String? key;
  String? days;
  String? currentDay;
  String? isTransCompleted;
  String? note;
  String? currentDayStatus;
  String? previousDayStatus;
  // early morning <=> Object
  Map<String, SubItems>? data;

  TransitionMealPlanModel({
    this.status,
    this.note,
    this.currentDay,
    this.errorCode,
    this.key,
    this.data,
    this.isTransCompleted,
    this.currentDayStatus,
    this.previousDayStatus,
    this.days,
  });

  TransitionMealPlanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    key = json['key'];
    currentDay = json['current_day'];
    isTransCompleted = json['is_trans_completed'];
    note = json['note'];
    days = json['days'];
    currentDayStatus = json['current_day_status'].toString();
    previousDayStatus = json['previous_day_status'].toString();
    if (json['data'] != null) {
      data = {};
      (json['data'] as Map).forEach((key, value) {
        // print("$key <==> ${(value as List).map((element) =>MealSlot.fromJson(element)) as List<MealSlot>}");
        // data!.putIfAbsent(key, () => List.from((value as List).map((element) => MealSlot.fromJson(element))));
        data!.addAll({key: SubItems.fromJson(value)});
      });

      data!.forEach((key, value) {
        print("$key -- $value");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['errorCode'] = this.errorCode;
    data['key'] = this.key;
    data['current_day'] = this.currentDay;
    data['is_trans_completed'] = this.isTransCompleted;
    data['days'] = this.days;
    data['current_day_status'] = this.currentDayStatus;
    data['previous_day_status'] = this.previousDayStatus;
    data['note'] = this.note;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    return data;
  }
}
