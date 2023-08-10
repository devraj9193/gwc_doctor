// To parse this JSON data, do
//
//     final loginOtpModel = loginOtpModelFromJson(jsonString);

import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) => LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
  int status;
  User user;
  String accessToken;
  String tokenType;
  String userStatus;
  String userKaleyraId;
  String successTeamKaleyraId;
  String chatId;
  dynamic loginUsername;
  int isDoctorAdmin;
  String associatedSuccessMember;
  String currentUser;
  String uvUserId;
  String uvSuccessId;
  String uvApiAccessToken;

  LoginOtpModel({
    required this.status,
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.userStatus,
    required this.userKaleyraId,
    required this.successTeamKaleyraId,
    required this.chatId,
    this.loginUsername,
    required this.isDoctorAdmin,
    required this.associatedSuccessMember,
    required this.currentUser,
    required this.uvUserId,
    required this.uvSuccessId,
    required this.uvApiAccessToken,
  });

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
    status: json["status"],
    user: User.fromJson(json["user"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    userStatus: json["user_status"],
    userKaleyraId: json["user_kaleyra_id"],
    successTeamKaleyraId: json["success_team_kaleyra_id"],
    chatId: json["chat_id"],
    loginUsername: json["login_username"],
    isDoctorAdmin: json["is_doctor_admin"],
    associatedSuccessMember: json["associated_success_member"],
    currentUser: json["current_user"],
    uvUserId: json["uv_user_id"],
    uvSuccessId: json["uv_success_id"],
    uvApiAccessToken: json["uv_api_access_token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "user": user.toJson(),
    "access_token": accessToken,
    "token_type": tokenType,
    "user_status": userStatus,
    "user_kaleyra_id": userKaleyraId,
    "success_team_kaleyra_id": successTeamKaleyraId,
    "chat_id": chatId,
    "login_username": loginUsername,
    "is_doctor_admin": isDoctorAdmin,
    "associated_success_member": associatedSuccessMember,
    "current_user": currentUser,
    "uv_user_id": uvUserId,
    "uv_success_id": uvSuccessId,
    "uv_api_access_token": uvApiAccessToken,
  };
}

class User {
  int id;
  int roleId;
  String name;
  String fname;
  String lname;
  String email;
  dynamic emailVerifiedAt;
  dynamic countryCode;
  String phone;
  String gender;
  String profile;
  dynamic address;
  dynamic otp;
  String deviceToken;
  String webDeviceToken;
  dynamic deviceType;
  dynamic deviceId;
  String age;
  String kaleyraUserId;
  String chatId;
  dynamic loginUsername;
  dynamic pincode;
  int isDoctorAdmin;
  dynamic underAdminDoctor;
  dynamic successUserId;
  String cetUserId;
  dynamic cetCompleted;
  String uvUserId;
  int isActive;
  dynamic addedBy;
  dynamic latitude;
  dynamic longitude;
  dynamic createdAt;
  DateTime updatedAt;
  dynamic signupDate;

  User({
    required this.id,
    required this.roleId,
    required this.name,
    required this.fname,
    required this.lname,
    required this.email,
    this.emailVerifiedAt,
    this.countryCode,
    required this.phone,
    required this.gender,
    required this.profile,
    this.address,
    this.otp,
    required this.deviceToken,
    required this.webDeviceToken,
    this.deviceType,
    this.deviceId,
    required this.age,
    required this.kaleyraUserId,
    required this.chatId,
    this.loginUsername,
    this.pincode,
    required this.isDoctorAdmin,
    this.underAdminDoctor,
    this.successUserId,
    required this.cetUserId,
    this.cetCompleted,
    required this.uvUserId,
    required this.isActive,
    this.addedBy,
    this.latitude,
    this.longitude,
    this.createdAt,
    required this.updatedAt,
    this.signupDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    roleId: json["role_id"],
    name: json["name"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    countryCode: json["country_code"],
    phone: json["phone"],
    gender: json["gender"],
    profile: json["profile"],
    address: json["address"],
    otp: json["otp"],
    deviceToken: json["device_token"],
    webDeviceToken: json["web_device_token"],
    deviceType: json["device_type"],
    deviceId: json["device_id"],
    age: json["age"],
    kaleyraUserId: json["kaleyra_user_id"],
    chatId: json["chat_id"],
    loginUsername: json["login_username"],
    pincode: json["pincode"],
    isDoctorAdmin: json["is_doctor_admin"],
    underAdminDoctor: json["under_admin_doctor"],
    successUserId: json["success_user_id"],
    cetUserId: json["cet_user_id"],
    cetCompleted: json["cet_completed"],
    uvUserId: json["uv_user_id"],
    isActive: json["is_active"],
    addedBy: json["added_by"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    signupDate: json["signup_date"],
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
    "web_device_token": webDeviceToken,
    "device_type": deviceType,
    "device_id": deviceId,
    "age": age,
    "kaleyra_user_id": kaleyraUserId,
    "chat_id": chatId,
    "login_username": loginUsername,
    "pincode": pincode,
    "is_doctor_admin": isDoctorAdmin,
    "under_admin_doctor": underAdminDoctor,
    "success_user_id": successUserId,
    "cet_user_id": cetUserId,
    "cet_completed": cetCompleted,
    "uv_user_id": uvUserId,
    "is_active": isActive,
    "added_by": addedBy,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "signup_date": signupDate,
  };
}
