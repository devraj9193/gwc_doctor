// To parse this JSON data, do
//
//     final uvDeskTicketRaiseModel = uvDeskTicketRaiseModelFromJson(jsonString);

import 'dart:convert';

UvDeskTicketRaiseModel uvDeskTicketRaiseModelFromJson(String str) =>
    UvDeskTicketRaiseModel.fromJson(json.decode(str));

String uvDeskTicketRaiseModelToJson(UvDeskTicketRaiseModel data) =>
    json.encode(data.toJson());

class UvDeskTicketRaiseModel {
  String? message;
  int? id;
  int? incrementId;
  int? ticketId;

  UvDeskTicketRaiseModel({
    this.message,
    this.id,
    this.incrementId,
    this.ticketId,
  });

  factory UvDeskTicketRaiseModel.fromJson(Map<String, dynamic> json) =>
      UvDeskTicketRaiseModel(
        message: json["message"],
        id: json["id"],
        incrementId: json["incrementId"],
        ticketId: json["ticketId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "incrementId": incrementId,
        "ticketId": ticketId,
      };
}
