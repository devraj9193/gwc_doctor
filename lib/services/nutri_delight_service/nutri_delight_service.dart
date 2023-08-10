import 'package:flutter/material.dart';

import '../../repository/nutri_delight_repo/nutri_delight_repository.dart';

class ProgramService extends ChangeNotifier {
  final ProgramRepository repository;

  ProgramService({required this.repository});

  Future getCombinedMealService(String userId) async {
    return await repository.getCombinedMealRepo(userId);
  }

  Future getProgressService(String userId) async {
    return await repository.getProgressRepo(userId);
  }

  Future getDailyProgressMealService(
      String selectedDay, String detoxOrHealing) async {
    return await repository.getDailyProgressMealRepo(
        selectedDay, detoxOrHealing);
  }

  Future getAllDayTrackerService() async {
    return await repository.getAllDaysTrackerRepo();
  }
}
