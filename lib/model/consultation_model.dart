// To parse this JSON data, do
//
//     final consultationModel = consultationModelFromJson(jsonString);

import 'dart:convert';

ConsultationModel consultationModelFromJson(String str) =>
    ConsultationModel.fromJson(json.decode(str));

String consultationModelToJson(ConsultationModel data) =>
    json.encode(data.toJson());

class ConsultationModel {
  ConsultationModel({
    this.status,
    this.errorCode,
    this.appointmentList,
    this.pendingConsultation,
    this.completedConsultation,
    this.mrPendingConsultation,
    this.documentUpload,
  });

  int? status;
  int? errorCode;
  List<Appointment>? appointmentList;
  int? pendingConsultation;
  int? completedConsultation;
  int? mrPendingConsultation;
  List<DocumentUpload>? documentUpload;

  factory ConsultationModel.fromJson(Map<String, dynamic> json) =>
      ConsultationModel(
        status: json["status"],
        errorCode: json["errorCode"],
        appointmentList: List<Appointment>.from(
            json["appointment_list"].map((x) => Appointment.fromJson(x))),
        pendingConsultation: json["pending_consultation"],
        completedConsultation: json["completed_consultation"],
        mrPendingConsultation: json["mr_pending_consultation"],
        documentUpload: List<DocumentUpload>.from(json["document_upload"].map((x) => DocumentUpload.fromJson(x))),

      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "appointment_list":
            List<dynamic>.from(appointmentList!.map((x) => x.toJson())),
        "pending_consultation": pendingConsultation,
        "completed_consultation": completedConsultation,
        "mr_pending_consultation": mrPendingConsultation,
    "document_upload": List<dynamic>.from(documentUpload!.map((x) => x.toJson())),
      };
}

class TeamPatients {
  TeamPatients({
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
  List<dynamic>? appointments;

  factory TeamPatients.fromJson(Map<String, dynamic> json) => TeamPatients(
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
        "appointments":
            List<dynamic>.from(appointments!.map((x) => x.toJson())),
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
    this.teamPatients,
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
  TeamPatients? teamPatients;

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
        teamPatients: TeamPatients.fromJson(json["team_patients"]),
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
        "team_patients": teamPatients?.toJson(),
      };
}

class DocumentUpload {
  DocumentUpload({
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
    this.appointments,
    this.patient,
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
  List<dynamic>? appointments;
  Patient? patient;

  factory DocumentUpload.fromJson(Map<String, dynamic> json) => DocumentUpload(
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
    appointments: List<dynamic>.from(json["appointments"].map((x) => x)),
    patient: Patient.fromJson(json["patient"]),
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
    "appointments": List<dynamic>.from(appointments!.map((x) => x.toJson())),
    "patient": patient?.toJson(),
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
        "pincode": pincode,
        "is_active": isActive,
        "added_by": addedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "signup_date": signupDate,
      };
}
