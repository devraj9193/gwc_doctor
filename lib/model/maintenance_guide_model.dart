// To parse this JSON data, do
//
//     final maintenanceGuideModel = maintenanceGuideModelFromJson(jsonString);

import 'dart:convert';

MaintenanceGuideModel maintenanceGuideModelFromJson(String str) => MaintenanceGuideModel.fromJson(json.decode(str));

String maintenanceGuideModelToJson(MaintenanceGuideModel data) => json.encode(data.toJson());

class MaintenanceGuideModel {
  MaintenanceGuideModel({
    this.status,
    this.errorCode,
    this.postProgramList,
    this.gutMaintenanceGuide,
  });

  int? status;
  int? errorCode;
  List<GutMaintenanceGuide>? postProgramList;
  List<GutMaintenanceGuide>? gutMaintenanceGuide;

  factory MaintenanceGuideModel.fromJson(Map<String, dynamic> json) => MaintenanceGuideModel(
    status: json["status"],
    errorCode: json["errorCode"],
    postProgramList: List<GutMaintenanceGuide>.from(json["post_program_list"].map((x) => GutMaintenanceGuide.fromJson(x))),
    gutMaintenanceGuide: List<GutMaintenanceGuide>.from(json["gut_maintenance_guide"].map((x) => GutMaintenanceGuide.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "post_program_list": List<dynamic>.from(postProgramList!.map((x) => x.toJson())),
    "gut_maintenance_guide": List<dynamic>.from(gutMaintenanceGuide!.map((x) => x.toJson())),
  };
}

class GutMaintenanceGuide {
  GutMaintenanceGuide({
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
  List<dynamic>? appointments;

  factory GutMaintenanceGuide.fromJson(Map<String, dynamic> json) => GutMaintenanceGuide(
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
    appointmentDate: json["appointment_date"].toString(),
    appointmentTime: json["appointment_time"].toString(),
    updateDate: json["update_date"],
    updateTime: json["update_time"],
    manifestUrl: json["manifest_url"],
    labelUrl: json["label_url"],
    patient: Patient.fromJson(json["patient"]),
    team: Team.fromJson(json["team"]),
    appointments: List<dynamic>.from(json["appointments"].map((x) => x)),
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
  String? createdAt;
  String? updatedAt;
  String? appointmentDate;
  String? appointmentStartTime;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    teamPatientId: json["team_patient_id"],
    date: json["date"],
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    type: json["type"],
    status: json["status"],
    zoomJoinUrl: json["zoom_join_url"],
    zoomStartUrl: json["zoom_start_url"],
    zoomId: json["zoom_id"],
    zoomPassword: json["zoom_password"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    status: json["status"],
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
    "gender": gender,
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
    teamName: json["team_name"],
    shiftId: json["shift_id"],
    slotsPerDay: json["slots_per_day"],
    isArchieved: json["is_archieved"],
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
    teamId: json["team_id"],
    userId: json["user_id"],
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
