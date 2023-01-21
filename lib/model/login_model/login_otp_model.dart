import 'dart:convert';

class LoginOtpModel {
  String? status;
  String? accessToken;
  String? tokenType;
  String? chatId;
  String? loginUsername;
  String? userEvaluationStatus;

  LoginOtpModel({this.status, this.accessToken, this.tokenType,this.chatId,this.loginUsername, this.userEvaluationStatus});

  LoginOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    accessToken = json['access_token'].toString();
    tokenType = json['token_type'].toString();
    chatId = json["chat_id"].toString();
    loginUsername = json["login_username"].toString();
    userEvaluationStatus = json['user_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status.toString();
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data["chat_id"] = chatId;
    data["login_username"] = loginUsername;
    data['user_status'] = userEvaluationStatus;
    return data;
  }
}

LoginOtpModel loginOtpFromJson(String str) => LoginOtpModel.fromJson(json.decode(str));

String loginOtpToJson(LoginOtpModel data) => json.encode(data.toJson());