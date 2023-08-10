// To parse this JSON data, do
//
//     final calendarModel = calendarModelFromJson(jsonString);

import 'dart:convert';

import 'customers_list_models/consultation_list_model.dart';

CalendarModel calendarModelFromJson(String str) =>
    CalendarModel.fromJson(json.decode(str));

String calendarModelToJson(CalendarModel data) => json.encode(data.toJson());

class CalendarModel {
  CalendarModel({
    this.status,
    this.errorCode,
    this.data,
    this.followUpSchedule,
  });

  int? status;
  int? errorCode;
  List<Meeting>? data;
  List<FollowUpSchedule>? followUpSchedule;

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        status: json["status"],
        errorCode: json["errorCode"],
        data: List<Meeting>.from(json["data"].map((x) => Meeting.fromJson(x))),
        followUpSchedule: List<FollowUpSchedule>.from(json['follow_up_schedule']
            .map((x) => FollowUpSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        'follow_up_schedule':
            List<dynamic>.from(followUpSchedule!.map((x) => x.toJson())),
      };
}

class Meeting {
  Meeting({
    required this.userId,
    required this.type,
    required this.title,
    required this.date,
    required this.start,
    required this.end,
    required this.color,
    required this.allDay,
  });

  int userId;
  String title;
  String type;
  DateTime date;
  DateTime start;
  DateTime end;
  String color;
  bool allDay;

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        userId: json['user_id'],
        type: json['type'].toString(),
        title: json["title"],
        date: DateTime.parse(json["date"]),
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        color: json["color"],
        allDay: json["allDay"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        'type': type,
        "title": title,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "color": color,
        "allDay": allDay,
      };
}

class FollowUpSchedule {
  int? id;
  int? teamPatientId;
  String? date;
  String? slotStartTime;
  String? slotEndTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  TeamPatients? teamPatients;

  FollowUpSchedule({
    this.id,
    this.teamPatientId,
    this.date,
    this.slotStartTime,
    this.slotEndTime,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.teamPatients,
  });

  factory FollowUpSchedule.fromJson(Map<String, dynamic> json) =>
      FollowUpSchedule(
        id: json["id"],
        teamPatientId: json["team_patient_id"],
        date: json["date"],
        slotStartTime: json["slot_start_time"],
        slotEndTime: json["slot_end_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        teamPatients: TeamPatients.fromJson(json["team_patients"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "team_patient_id": teamPatientId,
        "date": date,
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
        "team_patients": teamPatients?.toJson(),
      };
}
