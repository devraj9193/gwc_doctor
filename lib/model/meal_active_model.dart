// To parse this JSON data, do
//
//     final mealActiveModel = mealActiveModelFromJson(jsonString);

import 'dart:convert';

MealActiveModel mealActiveModelFromJson(String str) => MealActiveModel.fromJson(json.decode(str));

String mealActiveModelToJson(MealActiveModel data) => json.encode(data.toJson());

class MealActiveModel {
  MealActiveModel({
    this.status,
    this.errorCode,
    this.mealPlanList,
    this.activeDetails,
    this.getTeam,
  });

  int? status;
  int? errorCode;
  List<MealPlanList>? mealPlanList;
  List<ActiveDetail>? activeDetails;
  GetTeam? getTeam;

  factory MealActiveModel.fromJson(Map<String, dynamic> json) => MealActiveModel(
    status: json["status"],
    errorCode: json["errorCode"],
    mealPlanList: List<MealPlanList>.from(json["meal_plan_list"].map((x) => MealPlanList.fromJson(x))),
    activeDetails: List<ActiveDetail>.from(json["active_details"].map((x) => ActiveDetail.fromJson(x))),
    getTeam: GetTeam.fromJson(json["get_team"]),
   );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "meal_plan_list": List<dynamic>.from(mealPlanList!.map((x) => x.toJson())),
   "active_details": List<dynamic>.from(activeDetails!.map((x) => x.toJson())),
    "get_team": getTeam?.toJson(),
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
  List<Appointment>? appointments;

  factory ActiveDetailsWeb.fromJson(Map<String, dynamic> json) => ActiveDetailsWeb(
    id: json["id"],
    teamId: json["team_id"],
    patientId: json["patient_id"],
    programId: json["program_id"],
    assignedDate: json["assigned_date"],
    uploadTime: json["upload_time"],
    status: json["status"],
    isArchieved: json["is_archieved"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    appointmentDate: json["appointment_date"],
    appointmentTime: json["appointment_time"],
    updateDate: json["update_date"],
    updateTime: json["update_time"],
    manifestUrl: json["manifest_url"],
    labelUrl: json["label_url"],
    patient: Patient.fromJson(json["patient"]),
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
  DateTime? date;
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
    teamPatientId: json["team_patient_id"],
    date: DateTime.parse(json["date"]),
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    type: json["type"],
    status: json["status"],
    zoomJoinUrl: json["zoom_join_url"],
    zoomStartUrl: json["zoom_start_url"],
    zoomId: json["zoom_id"],
    zoomPassword: json["zoom_password"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    appointmentDate: json["appointment_date"],
    appointmentStartTime: json["appointment_start_time"],
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
    userId: json["user_id"],
    maritalStatus: json["marital_status"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    weight: json["weight"],
    status:json["status"],
    isArchieved: json["is_archieved"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    deviceType: json["device_type"],
    deviceId: json["device_id"],
    age: json["age"],
    chatId: json["chat_id"],
    loginUsername: json["login_username"],
    pincode: json["pincode"],
    isActive: json["is_active"],
    addedBy: json["added_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    teamId: json["team_id"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    userFinalDiagnosis: json["user_final_diagnosis"],
  );

  Map<String, dynamic> toJson() => {
    "user_details": userDetails?.toJson(),
    "user_final_diagnosis": userFinalDiagnosis,
  };
}

