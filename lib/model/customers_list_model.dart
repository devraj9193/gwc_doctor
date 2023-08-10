// To parse this JSON data, do
//
//     final customersList = customersListFromJson(jsonString);

import 'dart:convert';

CustomersList customersListFromJson(String str) =>
    CustomersList.fromJson(json.decode(str));

String customersListToJson(CustomersList data) => json.encode(data.toJson());

class CustomersList {
  CustomersList({
    this.status,
    this.errorCode,
    this.key,
    this.data,
  });

  int? status;
  int? errorCode;
  String? key;
  List<Datum>? data;

  factory CustomersList.fromJson(Map<String, dynamic> json) => CustomersList(
        status: json["status"],
        errorCode: json["errorCode"],
        key: json["key"].toString(),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "key": key,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.fname,
    this.lname,
    this.date,
    this.time,
    this.profile,
  });

  int? id;
  String? fname;
  String? lname;
  String? date;
  String? time;
  String? profile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fname: json["fname"].toString(),
        lname: json["lname"].toString(),
        date: json["date"].toString(),
        time: json["time"].toString(),
        profile: json["profile"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "date": date,
        "time": time,
        "profile": profile,
      };
}
