import 'dart:convert';

class GetOtpResponse {
  String? status;
  String? otp;
  String? errorCode;

  GetOtpResponse({this.status, this.otp, this.errorCode});

  GetOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    otp = json['otp'].toString();
    errorCode = json['errorCode'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['otp'] = otp;
    data['errorCode'] = errorCode;
    return data;
  }
}

GetOtpResponse getOtpFromJson(String str) => GetOtpResponse.fromJson(json.decode(str));

String getOtpToJson(GetOtpResponse data) => json.encode(data.toJson());