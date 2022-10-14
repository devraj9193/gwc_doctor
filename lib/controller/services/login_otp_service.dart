import 'package:flutter/material.dart';

import '../repository/login_otp_repository.dart';

class LoginWithOtpService extends ChangeNotifier{
  late final LoginOtpRepository repository;

  LoginWithOtpService({required this.repository});

  Future loginWithOtpService(String phone, String otp) async{
    return await repository.loginWithOtpRepo(phone, otp);
  }

  Future getOtpService(String phone) async{
    return await repository.getOtpRepo(phone);
  }
}