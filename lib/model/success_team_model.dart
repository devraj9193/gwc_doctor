// To parse this JSON data, do
//
//     final successList = successListFromJson(jsonString);

import 'dart:convert';

SuccessList successListFromJson(String str) =>
    SuccessList.fromJson(json.decode(str));

String successListToJson(SuccessList data) => json.encode(data.toJson());

class SuccessList {
  SuccessList({
    required this.status,
    required this.errorCode,
    required this.key,
    required this.data,
  });

  int status;
  int errorCode;
  String key;
  List<SuccessTeam> data;

  factory SuccessList.fromJson(Map<String, dynamic> json) => SuccessList(
        status: json["status"],
        errorCode: json["errorCode"],
        key: json["key"].toString(),
        data: List<SuccessTeam>.from(json["data"].map((x) => SuccessTeam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "key": key,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SuccessTeam {
  SuccessTeam({
    this.id,
    this.roleId,
    this.name,
    this.fname,
    this.lname,
    this.email,
    this.emailVerifiedAt,
    this.countryCode,
    this.phone,
    this.gender,
    this.profile,
    this.address,
    this.otp,
    this.deviceToken,
    this.deviceType,
    this.deviceId,
    this.age,
    this.kaleyraUserId,
    this.chatId,
    this.loginUsername,
    this.pincode,
    this.isDoctorAdmin,
    this.isActive,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.signupDate,
  });

  int? id;
  String? roleId;
  String? name;
  String? fname;
  String? lname;
  String? email;
  String? emailVerifiedAt;
  String? countryCode;
  String? phone;
  String? gender;
  String? profile;
  String? address;
  String? otp;
  String? deviceToken;
  String? deviceType;
  String? deviceId;
  String? age;
  String? kaleyraUserId;
  String? chatId;
  String? loginUsername;
  String? pincode;
  String? isDoctorAdmin;
  String? isActive;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  String? signupDate;

  factory SuccessTeam.fromJson(Map<String, dynamic> json) => SuccessTeam(
        id: json["id"],
        roleId: json["role_id"].toString(),
        name: json["name"].toString(),
        fname: json["fname"].toString(),
        lname: json["lname"].toString(),
        email: json["email"].toString(),
        emailVerifiedAt: json["email_verified_at"].toString(),
        countryCode: json["country_code"].toString(),
        phone: json["phone"].toString(),
        gender: json["gender"].toString(),
        profile: json["profile"].toString(),
        address: json["address"].toString(),
        otp: json["otp"].toString(),
        deviceToken: json["device_token"].toString(),
        deviceType: json["device_type"].toString(),
        deviceId: json["device_id"].toString(),
        age: json["age"].toString(),
        kaleyraUserId: json["kaleyra_user_id"].toString(),
        chatId: json["chat_id"].toString(),
        loginUsername: json["login_username"].toString(),
        pincode: json["pincode"].toString(),
        isDoctorAdmin: json["is_doctor_admin"].toString(),
        isActive: json["is_active"].toString(),
        addedBy: json["added_by"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        signupDate: json["signup_date"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "fname": fname,
        "lname": lname,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "country_code": countryCode,
        "phone": phone,
        "gender": gender,
        "profile": profile,
        "address": address,
        "otp": otp,
        "device_token": deviceToken,
        "device_type": deviceType,
        "device_id": deviceId,
        "age": age,
        "kaleyra_user_id": kaleyraUserId,
        "chat_id": chatId,
        "login_username": loginUsername,
        "pincode": pincode,
        "is_doctor_admin": isDoctorAdmin,
        "is_active": isActive,
        "added_by": addedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "signup_date": signupDate,
      };
}
