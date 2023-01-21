// To parse this JSON data, do
//
//     final guideMealPlanModel = guideMealPlanModelFromJson(jsonString);

import 'dart:convert';

GuideMealPlanModel guideMealPlanModelFromJson(String str) => GuideMealPlanModel.fromJson(json.decode(str));

String guideMealPlanModelToJson(GuideMealPlanModel data) => json.encode(data.toJson());

class GuideMealPlanModel {
  GuideMealPlanModel({
    this.status,
    this.errorCode,
    this.key,
    this.day,
    this.time,
    this.data,
    this.history,
  });

  int? status;
  int? errorCode;
  String? key;
  String? day;
  String? time;
  Data? data;
  List<History>? history;

  factory GuideMealPlanModel.fromJson(Map<String, dynamic> json) => GuideMealPlanModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    day: json["day"].toString(),
    time: json["time"],
    data: Data.fromJson(json["data"]),
    history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "day": day,
    "time": time,
    "data": data?.toJson(),
    "history": List<dynamic>.from(history!.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.dataDo,
    this.doNot,
    this.none,
  });

  Do? dataDo;
  Do? doNot;
  None? none;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataDo: Do.fromJson(json["do"]),
    doNot: Do.fromJson(json["do not"]),
    none: None.fromJson(json["none"]),
  );

  Map<String, dynamic> toJson() => {
    "do": dataDo?.toJson(),
    "do not": doNot?.toJson(),
    "none": none?.toJson(),
  };
}

class Do {
  Do({
    this.the0,
    this.isSelected,
  });

  The0? the0;
  int? isSelected;

  factory Do.fromJson(Map<String, dynamic> json) => Do(
    the0: The0.fromJson(json["0"]),
    isSelected: json["is_selected"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0?.toJson(),
    "is_selected": isSelected,
  };
}

class The0 {
  The0({
    this.id,
    this.itemId,
    this.name,
  });

  int? id;
  int? itemId;
  String? name;

  factory The0.fromJson(Map<String, dynamic> json) => The0(
    id: json["id"],
    itemId: json["item_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "name": name,
  };
}

class None {
  None({
    this.isSelected,
  });

  int? isSelected;

  factory None.fromJson(Map<String, dynamic> json) => None(
    isSelected: json["is_selected"],
  );

  Map<String, dynamic> toJson() => {
    "is_selected": isSelected,
  };
}

class History {
  History({
    this.totalScore,
    this.day,
  });

  String? totalScore;
  String? day;

  factory History.fromJson(Map<String, dynamic> json) => History(
    totalScore: json["total_score"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "total_score": totalScore,
    "day": day,
  };
}
