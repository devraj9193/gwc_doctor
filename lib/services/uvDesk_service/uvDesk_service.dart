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

import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../../repository/uvDesk_repo/uvDesk_repository.dart';

class UvDeskService extends ChangeNotifier {
  late final UvDeskRepo uvDeskRepo;

  UvDeskService({required this.uvDeskRepo});

  Future getOpenTicketListService() async {
    return await uvDeskRepo.getOpenTicketListRepo();
  }

  Future getAnsweredService(String ticketId) async {
    return await uvDeskRepo.getAnsweredListRepo(ticketId);
  }

  Future getResolvedService(String ticketId) async {
    return await uvDeskRepo.getResolvedListRepo(ticketId);
  }

  Future getClosedService(String ticketId) async {
    return await uvDeskRepo.getClosedListRepo(ticketId);
  }

  Future uvDaskTicketRaiseService(Map data, {List<File>? attachments}) async {
    return await uvDeskRepo.uvDeskTicketRaiseRepo(data, attachments: attachments);
  }

  Future uvDaskTicketThreadsService(String ticketId) async {
    return await uvDeskRepo.uvDeskTicketThreadsRepo(ticketId);
  }

  Future uvDaskSendReplyService(
      String ticketId, Map data, {List<File>? attachments}) async {
    return await uvDeskRepo.uvDeskSendReplyRepo(ticketId, data, attachments: attachments);
  }

  Future uvDeskCancelledService(
      String editType, String value, String threadId) async {
    return await uvDeskRepo.uvDeskCancelledRepo(editType, value, threadId);
  }

  Future uvDeskTransferToDoctorService(
      String email, String threadId) async {
    return await uvDeskRepo.uvDeskTransferToDoctorRepo(email, threadId);
  }

  Future uvDeskReassignService(
      String agentId, String threadId) async {
    return await uvDeskRepo.uvDeskReassignRepo(agentId, threadId);
  }

  // Future getTicketDetailsByIdService(String id) async{
  //   return await uvDeskRepo.getTicketDetailsByIdRepo(id);
  // }
  //
  // Future createTicketService(Map data, {List<MultipartFile>? attachments}) async{
  //   return await uvDeskRepo.createTicketRepo(data, attachments: attachments);
  // }
  //
  // Future getTicketsByCustomerIdService(String customerId) async{
  //   return await uvDeskRepo.getTicketsByCustomerIdRepo(customerId);
  // }
}
