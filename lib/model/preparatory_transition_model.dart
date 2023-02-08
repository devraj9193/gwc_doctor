// To parse this JSON data, do
//
//     final preparatoryTransitionModel = preparatoryTransitionModelFromJson(jsonString);

import 'dart:convert';

PreparatoryTransitionModel preparatoryTransitionModelFromJson(String str) => PreparatoryTransitionModel.fromJson(json.decode(str));

String preparatoryTransitionModelToJson(PreparatoryTransitionModel data) => json.encode(data.toJson());

class PreparatoryTransitionModel {
  PreparatoryTransitionModel({
    required this.status,
    required this.errorCode,
    required this.key,
    required this.days,
    required this.data,
  });

  int? status;
  int? errorCode;
  String? key;
  String? days;
  Map<String, List<Preparatory>>? data;

  factory PreparatoryTransitionModel.fromJson(Map<String, dynamic> json) => PreparatoryTransitionModel(
    status: json["status"],
    errorCode: json["errorCode"],
    key: json["key"],
    days: json["days"],
    data: Map.from(json["data"]).map((k, v) =>
        MapEntry<String, List<Preparatory>>(
            k, List<Preparatory>.from(v.map((x) => Preparatory.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "key": key,
    "days": days,
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))),
  };
}

class Preparatory {
  Preparatory({
    required this.id,
    required this.itemId,
    required this.name,
    required this.benefits,
    required this.subtitle,
    required this.itemPhoto,
    required this.recipeUrl,
  });

  int id;
  int itemId;
  String name;
  String benefits;
  String subtitle;
  String itemPhoto;
  String recipeUrl;

  factory Preparatory.fromJson(Map<String, dynamic> json) => Preparatory(
    id: json["id"],
    itemId: json["item_id"],
    name: json["name"],
    benefits: json["benefits"],
    subtitle: json["subtitle"],
    itemPhoto: json["item_photo"],
    recipeUrl: json["recipe_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_id": itemId,
    "name": name,
    "benefits": benefits,
    "subtitle": subtitle,
    "item_photo": itemPhoto,
    "recipe_url": recipeUrl,
  };
}
