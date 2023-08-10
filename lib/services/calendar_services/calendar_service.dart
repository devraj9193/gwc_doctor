import 'package:flutter/material.dart';

import '../../repository/calendar_repo/calendar_repository.dart';

class CalendarListService extends ChangeNotifier {
  final CalendarListRepo repository;

  CalendarListService({required this.repository});

  Future getCalendarListService() async {
    return await repository.getCalendarListRepo();
  }
}
