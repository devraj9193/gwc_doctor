// import 'package:flutter/material.dart';
//
// import '../../repository/uvDesk_repo/uvDesk_repository.dart';
//
// class UvDeskService extends ChangeNotifier{
//   late final uvDeskRepository repository;
//
//   UvDeskService({required this.repository});
//
//
//
//   Future getTicketListService(String customerId) async{
//     return await repository.uvDeskTicketRaiseRepo(customerId);
//   }
// }

import 'package:flutter/cupertino.dart';
import '../../repository/follow_up_calls_repo/follow_up_calls_repo.dart';

class FollowUpCallsService extends ChangeNotifier {
  late final FollowUpCallsRepo followUpCallsRepo;

  FollowUpCallsService({required this.followUpCallsRepo});

  Future getAllCustomerService(String selectedDate) async {
    return await followUpCallsRepo.getFollowUpCallsListRepo(selectedDate);
  }

}
