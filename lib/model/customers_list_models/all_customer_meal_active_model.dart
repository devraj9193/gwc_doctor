// To parse this JSON data, do
//
//     final mealActiveModel = mealActiveModelFromJson(jsonString);

import 'dart:convert';

import 'meal_active_model.dart';

AllCustomerMealActiveModel mealActiveModelFromJson(String str) => AllCustomerMealActiveModel.fromJson(json.decode(str));

String allCustomerMealActiveModelToJson(AllCustomerMealActiveModel data) => json.encode(data.toJson());

class AllCustomerMealActiveModel {
  AllCustomerMealActiveModel({
    this.status,
    this.errorCode,
    this.mealPlanList,
    this.activeDetails,
  });

  int? status;
  int? errorCode;
  List<MealPlanList>? mealPlanList;
  List<ActiveDetail>? activeDetails;

  factory AllCustomerMealActiveModel.fromJson(Map<String, dynamic> json) => AllCustomerMealActiveModel(
    status: json["status"],
    errorCode: json["errorCode"],
    mealPlanList: List<MealPlanList>.from(json["meal_plan_list"].map((x) => MealPlanList.fromJson(x))),
    activeDetails: List<ActiveDetail>.from(json["active_details"].map((x) => ActiveDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "meal_plan_list": List<dynamic>.from(mealPlanList!.map((x) => x.toJson())),
    "active_details": List<dynamic>.from(activeDetails!.map((x) => x.toJson())),
  };
}

class ActiveDetail {
  ActiveDetail({
    this.userDetails,
    this.userProgramStartDate,
    this.userPresentDay,
    this.userFinalDiagnosis,
  });

  ActiveDetailsWeb? userDetails;
  String? userProgramStartDate;
  String? userPresentDay;
  String? userFinalDiagnosis;

  factory ActiveDetail.fromJson(Map<String, dynamic> json) => ActiveDetail(
    userDetails: ActiveDetailsWeb.fromJson(json["user_details"]),
    userProgramStartDate: json["user_program_start_date"].toString(),
    userPresentDay: json["user_present_day"].toString(),
    userFinalDiagnosis: json["user_final_diagnosis"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user_details": userDetails?.toJson(),
    "user_program_start_date": userProgramStartDate,
    "user_present_day": userPresentDay,
    "user_final_diagnosis": userFinalDiagnosis,
  };
}

class ActiveDetailsWeb {
  ActiveDetailsWeb({
    this.id,
    this.teamId,
    this.patientId,
    this.programId,
    this.assignedDate,
    this.uploadTime,
    this.status,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
    this.appointmentDate,
    this.appointmentTime,
    this.updateDate,
    this.updateTime,
    this.manifestUrl,
    this.labelUrl,
    this.patient,
    this.team,
    this.appointments,
  });

  int? id;
  String? teamId;
  String? patientId;
  String? programId;
  String? assignedDate;
  String? uploadTime;
  String? status;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;
  String? appointmentDate;
  String? appointmentTime;
  String? updateDate;
  String? updateTime;
  String? manifestUrl;
  String? labelUrl;
  Patient? patient;
  Team? team;
  List<Appointment>? appointments;

  factory ActiveDetailsWeb.fromJson(Map<String, dynamic> json) => ActiveDetailsWeb(
    id: json["id"],
    teamId: json["team_id"].toString(),
    patientId: json["patient_id"].toString(),
    programId: json["program_id"].toString(),
    assignedDate: json["assigned_date"].toString(),
    uploadTime: json["upload_time"].toString(),
    status: json["status"].toString(),
    isArchieved: json["is_archieved"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    appointmentDate: json["appointment_date"].toString(),
    appointmentTime: json["appointment_time"].toString(),
    updateDate: json["update_date"].toString(),
    updateTime: json["update_time"].toString(),
    manifestUrl: json["manifest_url"].toString(),
    labelUrl: json["label_url"].toString(),
    patient: Patient.fromJson(json["patient"]),
    team: Team.fromJson(json["team"]),
    appointments: List<Appointment>.from(json["appointments"].map((x) => Appointment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_id": teamId,
    "patient_id": patientId,
    "program_id": programId,
    "assigned_date": assignedDate,
    "upload_time": uploadTime,
    "status": status,
    "is_archieved": isArchieved,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "appointment_date": appointmentDate,
    "appointment_time": appointmentTime,
    "update_date": updateDate,
    "update_time": updateTime,
    "manifest_url": manifestUrl,
    "label_url": labelUrl,
    "patient": patient?.toJson(),
    "team": team?.toJson(),
    "appointments": List<dynamic>.from(appointments!.map((x) => x.toJson())),
  };
}

class Appointment {
  Appointment({
    this.id,
    this.teamPatientId,
    this.date,
    this.slotStartTime,
    this.slotEndTime,
    this.type,
    this.status,
    this.zoomJoinUrl,
    this.zoomStartUrl,
    this.zoomId,
    this.zoomPassword,
    this.createdAt,
    this.updatedAt,
    this.appointmentDate,
    this.appointmentStartTime,
  });

  int? id;
  String? teamPatientId;
  String? date;
  String? slotStartTime;
  String? slotEndTime;
  String? type;
  String? status;
  String? zoomJoinUrl;
  String? zoomStartUrl;
  String? zoomId;
  String? zoomPassword;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? appointmentDate;
  String? appointmentStartTime;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    teamPatientId: json["team_patient_id"].toString(),
    date: json["date"],
    slotStartTime: json["slot_start_time"].toString(),
    slotEndTime: json["slot_end_time"].toString(),
    type: json["type"].toString(),
    status: json["status"].toString(),
    zoomJoinUrl: json["zoom_join_url"].toString(),
    zoomStartUrl: json["zoom_start_url"].toString(),
    zoomId: json["zoom_id"].toString(),
    zoomPassword: json["zoom_password"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    appointmentDate: json["appointment_date"].toString(),
    appointmentStartTime: json["appointment_start_time"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_patient_id": teamPatientId,
    "date": date,
    "slot_start_time": slotStartTime,
    "slot_end_time": slotEndTime,
    "type": type,
    "status": status,
    "zoom_join_url": zoomJoinUrl,
    "zoom_start_url": zoomStartUrl,
    "zoom_id": zoomId,
    "zoom_password": zoomPassword,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "appointment_date": appointmentDate,
    "appointment_start_time": appointmentStartTime,
  };
}

class Patient {
  Patient({
    this.id,
    this.userId,
    this.maritalStatus,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.weight,
    this.status,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  String? userId;
  String? maritalStatus;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? weight;
  String? status;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;
  User? user;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    userId: json["user_id"].toString(),
    maritalStatus: json["marital_status"].toString(),
    address2: json["address2"].toString(),
    city: json["city"].toString(),
    state: json["state"].toString(),
    country: json["country"].toString(),
    weight: json["weight"].toString(),
    status:json["status"].toString(),
    isArchieved: json["is_archieved"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "marital_status": maritalStatus,
    "address2": address2,
    "city": city,
    "state": state,
    "country": country,
    "weight": weight,
    "status": status,
    "is_archieved": isArchieved,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toJson(),
  };
}

class User {
  User({
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
    this.chatId,
    this.loginUsername,
    this.pincode,
    this.isActive,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.signupDate,
    this.userProgram,
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
  String? chatId;
  String? loginUsername;
  String? pincode;
  String? isActive;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  String? signupDate;
  UserProgram? userProgram;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    chatId: json["chat_id"].toString(),
    loginUsername: json["login_username"].toString(),
    pincode: json["pincode"].toString(),
    isActive: json["is_active"].toString(),
    addedBy: json["added_by"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    signupDate: json["signup_date"].toString(),
    userProgram: (json["user_program"] != null) ? UserProgram.fromJson(json["user_program"]) : null,
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
    "gender":gender,
    "profile": profile,
    "address": address,
    "otp": otp,
    "device_token": deviceToken,
    "device_type": deviceType,
    "device_id": deviceId,
    "age": age,
    "chat_id": chatId,
    "login_username": loginUsername,
    "pincode": pincode,
    "is_active": isActive,
    "added_by": addedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "signup_date": signupDate,
    "user_program": userProgram?.toJson(),
  };
}

class GetTeam {
  GetTeam({
    this.id,
    this.teamId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? teamId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  factory GetTeam.fromJson(Map<String, dynamic> json) => GetTeam(
    id: json["id"],
    teamId: json["team_id"].toString(),
    userId: json["user_id"].toString(),
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_id": teamId,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class MealPlanList {
  MealPlanList({
    this.userDetails,
    this.userFinalDiagnosis,
  });

  ActiveDetailsWeb? userDetails;
  String? userFinalDiagnosis;

  factory MealPlanList.fromJson(Map<String, dynamic> json) => MealPlanList(
    userDetails: ActiveDetailsWeb.fromJson(json["user_details"]),
    userFinalDiagnosis: json["user_final_diagnosis"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "user_details": userDetails?.toJson(),
    "user_final_diagnosis": userFinalDiagnosis,
  };
}

class Team {
  Team({
    required this.id,
    required this.teamName,
    required this.shiftId,
    required this.slotsPerDay,
    required this.isArchieved,
    required this.createdAt,
    required this.updatedAt,
    required this.teamMember,
  });

  int id;
  String teamName;
  String shiftId;
  String slotsPerDay;
  String isArchieved;
  DateTime createdAt;
  DateTime updatedAt;
  List<TeamMember> teamMember;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    teamName: json["team_name"].toString(),
    shiftId: json["shift_id"].toString(),
    slotsPerDay: json["slots_per_day"].toString(),
    isArchieved: json["is_archieved"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    teamMember: List<TeamMember>.from(json["team_member"].map((x) => TeamMember.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_name": teamName,
    "shift_id": shiftId,
    "slots_per_day": slotsPerDay,
    "is_archieved": isArchieved,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "team_member": List<dynamic>.from(teamMember.map((x) => x.toJson())),
  };
}

class TeamMember {
  TeamMember({
    required this.id,
    required this.teamId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  String teamId;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
    id: json["id"],
    teamId: json["team_id"].toString(),
    userId: json["user_id"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_id": teamId,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}