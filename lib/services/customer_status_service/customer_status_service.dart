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
import '../../repository/customer_status_repo.dart/customer_status_repo.dart';

class CustomerStatusService extends ChangeNotifier {
  late final CustomerStatusRepo customerStatusRepo;

  CustomerStatusService({required this.customerStatusRepo});

  // Future getAllCustomerService() async {
  //   return await customerStatusRepo.getAllCustomerListRepo();
  // }
  //
  // Future getClaimedCustomerService() async {
  //   return await customerStatusRepo.getClaimedCustomerListRepo();
  // }

  Future getConsultationPendingService() async {
    return await customerStatusRepo.getConsultationPendingListRepo();
  }

  // Future getShipmentService() async {
  //   return await customerStatusRepo.getShipmentListRepo();
  // }

  Future getMealActiveService() async {
    return await customerStatusRepo.getMealActiveListRepo();
  }

  Future getPostProgramService() async {
    return await customerStatusRepo.getPostProgramListRepo();
  }

  Future getAllConsultationPendingService() async {
    return await customerStatusRepo.getAllConsultationPendingListRepo();
  }

  Future getAllMealActiveService() async {
    return await customerStatusRepo.getAllMealActiveListRepo();
  }

  Future getAllPostProgramService() async {
    return await customerStatusRepo.getAllPostProgramListRepo();
  }

  Future getDirectListService() async {
    return await customerStatusRepo.getDirectListRepo();
  }
}
