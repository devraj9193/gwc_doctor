// To parse this JSON data, do
//
//     final calendarModel = calendarModelFromJson(jsonString);

import 'dart:convert';

CalendarModel calendarModelFromJson(String str) =>
    CalendarModel.fromJson(json.decode(str));

String calendarModelToJson(CalendarModel data) => json.encode(data.toJson());

class CalendarModel {
  CalendarModel({
    this.status,
    this.errorCode,
    this.data,
  });

  int? status;
  int? errorCode;
  List<Meeting>? data;

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
        status: json["status"],
        errorCode: json["errorCode"],
        data: List<Meeting>.from(json["data"].map((x) => Meeting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Meeting {
  Meeting({
    required this.title,
    required this.date,
    required this.start,
    required this.end,
    required this.color,
    required this.allDay,
  });

  String title;
  DateTime date;
  DateTime start;
  DateTime end;
  String color;
  bool allDay;

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        color: json["color"],
        allDay: json["allDay"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "color": color,
        "allDay": allDay,
      };
}
