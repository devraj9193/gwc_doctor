import 'package:flutter/material.dart';

import '../post_program_repo/post_program_repository.dart';

class PostProgramService extends ChangeNotifier{
  final PostProgramRepository repository;

  PostProgramService({required this.repository}) : assert(repository != null);

  Future startPostProgramService() async{
    return await repository.startPostProgramRepo();
  }
  Future getPPMealsOnStagesService(int stage, String day,) async{
    return await repository.getPPMealsOnStagesRepo(stage, day);
  }

  /// not using
  Future getProtocolDayDetailsService({String? dayNumber}) async{
    return await repository.getProtocolDayDetailsRepo(dayNumber: dayNumber);
  }

  /// new
  Future getPPDayDetailsService({String? dayNumber}) async{
    return await repository.getPPDayDetailsRepo(dayNumber: dayNumber);
  }
  /// new
  Future getPPDaySummaryService(String dayNumber) async{
    return await repository.getPPDaySummaryRepo(dayNumber);
  }
  /// new
  Future getPPDayCalenderService() async{
    return await repository.getPPDayCalenderRepo();
  }

}