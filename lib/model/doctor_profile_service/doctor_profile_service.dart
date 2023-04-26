import 'package:flutter/cupertino.dart';

import 'doctor_profile_repo.dart';

class DoctorMemberProfileService extends ChangeNotifier{
  final DoctorMemberProfileRepository repository;

  DoctorMemberProfileService({required this.repository}) : assert(repository != null);

  Future getDoctorMemberProfileService(String accessToken) async{
    return await repository.getDoctorProfileRepo(accessToken);
  }
}