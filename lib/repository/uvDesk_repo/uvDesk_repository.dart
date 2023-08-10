// import '../../service/api_service.dart';
//
// class uvDeskRepository{
//   ApiClient apiClient;
//
//   uvDeskRepository({required this.apiClient}) : assert(apiClient != null);
//
//   Future uvDeskTicketRaiseRepo(String description, String title) async{
//     return await apiClient.uvDeskTicketRaiseApi(description, title);
//   }
// }

import 'dart:io';

import '../api_service.dart';

class UvDeskRepo {
  ApiClient apiClient;

  UvDeskRepo({required this.apiClient}) : assert(apiClient != null);

  Future getOpenTicketListRepo() async{
    return await apiClient.getOpenTicketListApi();
  }

  Future getAnsweredListRepo(String ticketId) async{
    return await apiClient.getAnsweredThreadsApi(ticketId);
  }

  Future getResolvedListRepo(String ticketId) async{
    return await apiClient.getResolvedThreadsApi(ticketId);
  }

  Future getClosedListRepo(String ticketId) async{
    return await apiClient.getClosedThreadsApi(ticketId);
  }

  Future uvDeskTicketRaiseRepo(Map data, {List<File>? attachments}) async{
    return await apiClient.uvDeskTicketRaiseApi(data,attachments: attachments);
  }

  Future uvDeskTicketThreadsRepo(String ticketId) async{
    return await apiClient.getTicketThreadsApi(ticketId);
  }

  Future uvDeskSendReplyRepo(String ticketId, Map data, {List<File>? attachments}) async{
    return await apiClient.uvDeskSendReplyApi(ticketId, data, attachments: attachments);
  }

  Future uvDeskCancelledRepo(String editType, String value,String threadId) async{
    return await apiClient.uvDeskCancelledApi(editType, value,threadId);
  }

  Future uvDeskTransferToDoctorRepo(String email,String threadId) async{
    return await apiClient.uvDeskTransferToDoctorApi(email,threadId);
  }

  Future uvDeskReassignRepo(String agentId,String threadId) async{
    return await apiClient.uvDeskReassignApi(agentId,threadId);
  }

  // Future getTicketDetailsByIdRepo(String id) async{
  //   return await apiClient.getTicketDetailsApi(id);
  // }
  //
  // Future createTicketRepo(Map data, {List<MultipartFile>? attachments}) async{
  //   return await apiClient.createTicketApi(data, attachments: attachments);
  // }
  //
  // Future getTicketsByCustomerIdRepo(String customerId) async{
  //   return await apiClient.getTicketListByCustomerIdApi(customerId);
  // }
}