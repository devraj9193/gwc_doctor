import 'dart:convert';

class LoginOtpModel {
  String? status;
  String? accessToken;
  String? tokenType;
  String? chatId;
  String? loginUsername;
  String? userEvaluationStatus;
  String? isDoctorAdmin;
  String? userKaleyraId;

  LoginOtpModel(
      {this.status,
      this.accessToken,
      this.tokenType,
      this.chatId,
      this.loginUsername,
      this.userEvaluationStatus,
        this.userKaleyraId,
      });

  LoginOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    accessToken = json['access_token'].toString();
    tokenType = json['token_type'].toString();
    chatId = json["chat_id"].toString();
    loginUsername = json["login_username"].toString();
    userEvaluationStatus = json['user_status'].toString();
    isDoctorAdmin = json["is_doctor_admin"].toString();
    userKaleyraId=json["user_kaleyra_id"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status.toString();
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data["chat_id"] = chatId;
    data["login_username"] = loginUsername;
    data['user_status'] = userEvaluationStatus;
    data["is_doctor_admin"] = isDoctorAdmin;
    data["user_kaleyra_id"] = userKaleyraId;
    return data;
  }
}

LoginOtpModel loginOtpFromJson(String str) =>
    LoginOtpModel.fromJson(json.decode(str));

String loginOtpToJson(LoginOtpModel data) => json.encode(data.toJson());
