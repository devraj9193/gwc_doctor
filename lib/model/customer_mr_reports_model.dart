// To parse this JSON data, do
//
//     final mrReportsModel = mrReportsModelFromJson(jsonString);

import 'dart:convert';

MrReportsModel mrReportsModelFromJson(String str) =>
    MrReportsModel.fromJson(json.decode(str));

String mrReportsModelToJson(MrReportsModel data) => json.encode(data.toJson());

class MrReportsModel {
  MrReportsModel({
    this.status,
    this.errorCode,
    this.data,
    this.reports,
    this.afterReports,
    this.mrReport,
    this.caseStudyReport,
  });

  int? status;
  int? errorCode;
  Data? data;
  List<Report>? reports;
  List<Report>? afterReports;
  UserReport? mrReport;
  UserReport? caseStudyReport;

  factory MrReportsModel.fromJson(Map<String, dynamic> json) => MrReportsModel(
        status: json["status"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
        reports:
            List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
        afterReports: List<Report>.from(
            json["after_reports"].map((x) => Report.fromJson(x))),
        mrReport: UserReport.fromJson(json["mr_report"] ?? {}),
        caseStudyReport: UserReport.fromJson(json["case_study_report"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errorCode": errorCode,
        "data": data?.toJson(),
        "reports": List<dynamic>.from(reports!.map((x) => x.toJson())),
        "after_reports": List<dynamic>.from(reports!.map((x) => x.toJson())),
        "mr_report": mrReport?.toJson(),
        "case_study_report": caseStudyReport?.toJson(),
      };
}

class Report {
  Report({
    this.id,
    this.doctorId,
    this.patientId,
    this.appointmentId,
    this.report,
    this.reportType,
    this.type,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? doctorId;
  String? patientId;
  String? appointmentId;
  String? report;
  String? reportType;
  String? type;
  String? isArchieved;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        id: json["id"],
        doctorId: json["doctor_id"].toString(),
        patientId: json["patient_id"].toString(),
        appointmentId: json["appointment_id"].toString(),
        report: json["report"].toString(),
        reportType: json["report_type"].toString(),
        type: json["type"].toString(),
        isArchieved: json["is_archieved"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "patient_id": patientId,
        "appointment_id": appointmentId,
        "report": report,
        "report_type": reportType,
        "type": type,
        "is_archieved": isArchieved,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        appointments: List<Appointment>.from(
            json["appointments"].map((x) => Appointment.fromJson(x))),
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
        teamPatientId: json["team_patient_id"].toString(),
        date: json["date"].toString(),
        slotStartTime: json["slot_start_time"].toString(),
        slotEndTime: json["slot_end_time"].toString(),
        type: json["type"].toString(),
        status: json["status"].toString(),
        zoomJoinUrl: json["zoom_join_url"].toString(),
        zoomStartUrl: json["zoom_start_url"].toString(),
        zoomId: json["zoom_id"].toString(),
        zoomPassword: json["zoom_password"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
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
        status: json["status"].toString(),
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
        pincode: json["pincode"].toString(),
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
        "pincode": pincode,
        "is_active": isActive,
        "added_by": addedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "signup_date": signupDate,
      };
}

class UserReport {
  UserReport({
    this.id,
    this.doctorId,
    this.patientId,
    this.appointmentId,
    this.report,
    this.reportType,
    this.isArchieved,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? doctorId;
  String? patientId;
  String? appointmentId;
  String? report;
  String? reportType;
  String? isArchieved;
  String? createdAt;
  String? updatedAt;

  factory UserReport.fromJson(Map<String, dynamic> json) => UserReport(
        id: json["id"],
        doctorId: json["doctor_id"].toString(),
        patientId: json["patient_id"].toString(),
        appointmentId: json["appointment_id"].toString(),
        report: json["report"].toString(),
        reportType: json["report_type"].toString(),
        isArchieved: json["is_archieved"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "patient_id": patientId,
        "appointment_id": appointmentId,
        "report": report,
        "report_type": reportType,
        "is_archieved": isArchieved,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
