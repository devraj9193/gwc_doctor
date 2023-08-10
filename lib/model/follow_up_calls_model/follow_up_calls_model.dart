class FollowUpCallsModel {
  int? status;
  int? errorCode;
  List<Datum>? data;

  FollowUpCallsModel({
     this.status,
     this.errorCode,
     this.data,
  });

  factory FollowUpCallsModel.fromJson(Map<String, dynamic> json) => FollowUpCallsModel(
    status: json["status"],
    errorCode: json["errorCode"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? teamPatientId;
  String? date;
  String? slotStartTime;
  String? slotEndTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  TeamPatients? teamPatients;

  Datum({
     this.id,
     this.teamPatientId,
     this.date,
     this.slotStartTime,
     this.slotEndTime,
     this.createdAt,
     this.updatedAt,
     this.teamPatients,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    teamPatientId: json["team_patient_id"],
    date: json["date"],
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    teamPatients: TeamPatients.fromJson(json["team_patients"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "team_patient_id": teamPatientId,
    "date": date,
    "slot_start_time": slotStartTime,
    "slot_end_time": slotEndTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "team_patients": teamPatients?.toJson(),
  };
}

class TeamPatients {
  int? id;
  int? teamId;
  int? patientId;
  dynamic programId;
  DateTime? assignedDate;
  String? uploadTime;
  String? status;
  dynamic initialTeam;
  int? isArchieved;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? appointmentDate;
  String? appointmentTime;
  String? updateDate;
  String? updateTime;
  String? manifestUrl;
  String? labelUrl;
  Patient? patient;
  List<Appointment>? appointments;

  TeamPatients({
     this.id,
     this.teamId,
     this.patientId,
    this.programId,
     this.assignedDate,
     this.uploadTime,
     this.status,
    this.initialTeam,
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

  factory TeamPatients.fromJson(Map<String, dynamic> json) => TeamPatients(
    id: json["id"],
    teamId: json["team_id"],
    patientId: json["patient_id"],
    programId: json["program_id"],
    assignedDate: DateTime.parse(json["assigned_date"]),
    uploadTime: json["upload_time"],
    status: json["status"],
    initialTeam: json["initial_team"],
    isArchieved: json["is_archieved"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "assigned_date": "${assignedDate?.year.toString().padLeft(4, '0')}-${assignedDate?.month.toString().padLeft(2, '0')}-${assignedDate?.day.toString().padLeft(2, '0')}",
    "upload_time": uploadTime,
    "status": status,
    "initial_team": initialTeam,
    "is_archieved": isArchieved,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
  int? id;
  int? teamPatientId;
  String? date;
  String? slotStartTime;
  String? slotEndTime;
  int? type;
  String? status;
  dynamic zoomJoinUrl;
  dynamic zoomStartUrl;
  dynamic zoomId;
  dynamic zoomPassword;
  String? kaleyraUserUrl;
  dynamic userSuccessChatRoom;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? appointmentDate;
  String? appointmentStartTime;

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
     this.kaleyraUserUrl,
    this.userSuccessChatRoom,
     this.createdAt,
     this.updatedAt,
     this.appointmentDate,
     this.appointmentStartTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    teamPatientId: json["team_patient_id"],
    date:json["date"],
    slotStartTime: json["slot_start_time"],
    slotEndTime: json["slot_end_time"],
    type: json["type"],
    status: json["status"],
    zoomJoinUrl: json["zoom_join_url"],
    zoomStartUrl: json["zoom_start_url"],
    zoomId: json["zoom_id"],
    zoomPassword: json["zoom_password"],
    kaleyraUserUrl: json["kaleyra_user_url"],
    userSuccessChatRoom: json["user_success_chat_room"],
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
    "kaleyra_user_url": kaleyraUserUrl,
    "user_success_chat_room": userSuccessChatRoom,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "appointment_date": appointmentDate,
    "appointment_start_time": appointmentStartTime,
  };
}

class Patient {
  int? id;
  int? userId;
  String? maritalStatus;
  String? address2;
  String? city;
  String? state;
  String? country;
  int? weight;
  String? status;
  String? shippingDeliveryDate;
  dynamic rejectedReason;
  int? isArchieved;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

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
     this.shippingDeliveryDate,
    this.rejectedReason,
     this.isArchieved,
     this.createdAt,
     this.updatedAt,
     this.user,
  });

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
    shippingDeliveryDate: json["shipping_delivery_date"],
    rejectedReason: json["rejected_reason"],
    isArchieved: json["is_archieved"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "shipping_delivery_date": shippingDeliveryDate,
    "rejected_reason": rejectedReason,
    "is_archieved": isArchieved,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  int? roleId;
  String? name;
  String? fname;
  String? lname;
  String? email;
  dynamic emailVerifiedAt;
  String? countryCode;
  String? phone;
  String? gender;
  String? profile;
  String? address;
  dynamic otp;
  String? deviceToken;
  dynamic webDeviceToken;
  dynamic deviceType;
  dynamic deviceId;
  String? age;
  String? kaleyraUserId;
  dynamic chatId;
  dynamic loginUsername;
  String? pincode;
  int? isDoctorAdmin;
  dynamic underAdminDoctor;
  String? successUserId;
  String? cetUserId;
  String? cetCompleted;
  int? isActive;
  dynamic addedBy;
  dynamic latitude;
  dynamic longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? signupDate;

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
    this.webDeviceToken,
    this.deviceType,
    this.deviceId,
     this.age,
     this.kaleyraUserId,
    this.chatId,
    this.loginUsername,
     this.pincode,
     this.isDoctorAdmin,
    this.underAdminDoctor,
     this.successUserId,
     this.cetUserId,
     this.cetCompleted,
     this.isActive,
    this.addedBy,
    this.latitude,
    this.longitude,
     this.createdAt,
     this.updatedAt,
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
    isActive: json["is_active"],
    addedBy: json["added_by"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["created_at"]),
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
    "is_active": isActive,
    "added_by": addedBy,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "signup_date": signupDate,
  };
}
