import 'package:doctor_app_new/screens/customer_help_screens/resolved_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../model/error_model.dart';
import '../../model/uvDesk_model/get_ticket_list_model.dart';
import '../../repository/api_service.dart';
import '../../repository/uvDesk_repo/uvDesk_repository.dart';
import '../../services/uvDesk_service/uvDesk_service.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import 'answered_list.dart';
import 'closed_list.dart';
import 'open_list.dart';
import 'raise_a_ticket.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({Key? key}) : super(key: key);

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen>
    with SingleTickerProviderStateMixin {
  bool showProgress = false;
  GetTicketListModel? getTicketListModel;

  late final UvDeskService _uvDeskService =
      UvDeskService(uvDeskRepo: repository);

  final ScrollController _scrollController = ScrollController();

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    getTickets();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  getTickets() async {
    setState(() {
      showProgress = true;
    });
    callProgressStateOnBuild(true);
    final result = await _uvDeskService.getOpenTicketListService();
    print("result: $result");

    if (result.runtimeType == GetTicketListModel) {
      print("Ticket List");
      GetTicketListModel model = result as GetTicketListModel;

      getTicketListModel = model;
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    setState(() {
      showProgress = false;
    });
    print(result);
  }

  callProgressStateOnBuild(bool value) {
    Future.delayed(Duration.zero).whenComplete(() {
      setState(() {
        showProgress = value;
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        backgroundColor: gWhiteColor,
        title: SizedBox(
          height: 5.h,
          child: const Image(
            image: AssetImage("assets/images/Gut wellness logo.png"),
          ),
        ),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.add,
              color: gHintTextColor,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RaiseATicket()))
                  .then((value) {
                if (true) {
                  setState(() {});
                }
              });
            },
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            labelColor: tapSelectedColor,
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            unselectedLabelColor: tapUnSelectedColor,
            labelStyle: TabBarText().selectedText(),
            unselectedLabelStyle: TabBarText().unSelectedText(),
            isScrollable: true,
            indicatorColor: tapIndicatorColor,
            labelPadding:
                EdgeInsets.only(right: 10.w, left: 2.w, top: 1.h, bottom: 1.h),
            indicatorPadding: EdgeInsets.only(right: 5.w),
            tabs: const [
              Text('Open'),
              Text('Answered'),
              Text('Resolved'),
              Text('Closed'),
            ],
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 0.w, bottom: 1.h),
            color: gGreyColor.withOpacity(0.3),
            width: double.maxFinite,
          ),
          Expanded(
            child:  TabBarView(
                    controller: tabController,
                    children: const [
                      OpenList(),
                      AnsweredList(),
                      ResolvedList(),
                      ClosedList(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // buildAll() {
  //   List<Tickets> tickets = getTicketListModel?.tickets ?? [];
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     controller: _scrollController,
  //     itemCount: tickets.length,
  //     itemBuilder: (context, index) {
  //       Tickets currentTicket = tickets[index];
  //       return Column(
  //         children: [
  //           Container(
  //             padding: EdgeInsets.symmetric(
  //                 horizontal: 3.w, vertical: 1.h),
  //             margin: EdgeInsets.symmetric(
  //                 horizontal: 3.w, vertical: 1.h),
  //             decoration: BoxDecoration(
  //               color: gWhiteColor,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: InkWell(
  //               onTap: () {
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                     builder: (context) => TicketChatScreen(
  //                       userName: currentTicket.customer.name,
  //                       thumpNail: currentTicket.customer.smallThumbnail,
  //                       ticketId: currentTicket.id.toString(),
  //                       subject: currentTicket.subject,
  //                       incrementId: currentTicket.id.toString(),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         currentTicket.id.toString(),
  //                         style: AllListText().otherText(),
  //                       ),
  //                       Text(
  //                         currentTicket.formatedCreatedAt,
  //                         style: AllListText().otherText(),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 0.3.h),
  //                   (currentTicket.subject.isNotEmpty)
  //                       ? Text(
  //                           currentTicket.subject,
  //                           style: AllListText().headingText(),
  //                         )
  //                       : const SizedBox(),
  //                   // SizedBox(height: 0.3.h),
  //                   // Row(
  //                   //   crossAxisAlignment: CrossAxisAlignment.start,
  //                   //   children: [
  //                   //     Text(
  //                   //       "Replied By : ",
  //                   //       style: AllListText().otherText(),
  //                   //     ),
  //                   //     Expanded(
  //                   //       child: Text(
  //                   //         currentTicket.lastThreadUserType ?? "",
  //                   //         style: AllListText().subHeadingText(),
  //                   //       ),
  //                   //     ),
  //                   //   ],
  //                   // ),
  //                   // SizedBox(height: 0.3.h),
  //                   // Text(
  //                   //   currentTicket.lastReplyAgentTime ?? '',
  //                   //   style: AllListText().otherText(),
  //                   // ),
  //                   SizedBox(height: 0.5.h),
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: Row(
  //                           children: [
  //                             currentTicket
  //                                 .customer.smallThumbnail.isEmpty
  //                                 ? CircleAvatar(
  //                               radius: 1.h,
  //                               backgroundColor:
  //                               kNumberCircleRed,
  //                               child: Text(
  //                                 getInitials(
  //                                     currentTicket
  //                                         .customer.name,
  //                                     2),
  //                                 style: TextStyle(
  //                                   fontSize: 7.sp,
  //                                   fontFamily: "GothamMedium",
  //                                   color: gWhiteColor,
  //                                 ),
  //                               ),
  //                             )
  //                                 : CircleAvatar(
  //                               radius: 1.h,
  //                               backgroundImage: NetworkImage(
  //                                 currentTicket
  //                                     .customer.smallThumbnail,
  //                               ),
  //                             ),
  //                             SizedBox(width: 1.w),
  //                             Text(
  //                               currentTicket.customer.name,
  //                               style: AllListText().subHeadingText(),
  //                               maxLines: 2,
  //                               softWrap: true,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             SizedBox(width: 3.w),
  //                             currentTicket.status.code == "open"
  //                                 ? Image(
  //                               image: const AssetImage(
  //                                   "assets/images/open-source.png"),
  //                               height: 2.h,
  //                             )
  //                                 : currentTicket.status.code ==
  //                                 "resolved"
  //                                 ? Image(
  //                               image: const AssetImage(
  //                                   "assets/images/resolved.png"),
  //                               height: 2.h,
  //                             )
  //                                 : currentTicket.status.code ==
  //                                 "closed"
  //                                 ? Image(
  //                               image: const AssetImage(
  //                                   "assets/images/check-list.png"),
  //                               height: 2.h,
  //                             )
  //                                 : const SizedBox(),
  //                             SizedBox(width: 1.w),
  //                             Text(
  //                               currentTicket.status.code ?? '',
  //                               style: AllListText().otherText(),
  //                             ),
  //                             SizedBox(width: 2.w),
  //                             Icon(
  //                               Icons.circle,
  //                               size: 12,
  //                               color: currentTicket.priority.code ==
  //                                   "low"
  //                                   ? kBottomSheetHeadGreen
  //                                   : currentTicket.priority.code ==
  //                                   "high"
  //                                   ? kNumberCircleRed
  //                                   : gWhiteColor,
  //                               // AppConfig.fromHex(
  //                               //     currentTicket.priority!.color ?? ''),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       currentTicket.isCustomerView
  //                           ? Icon(Icons.check_circle,
  //                           color: gPrimaryColor, size: 2.h)
  //                           : Icon(Icons.check,
  //                           color: gGreyColor, size: 2.h)
  //                     ],
  //                   ),
  //
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Container(
  //             height: 1,
  //             color: Colors.grey.withOpacity(0.3),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // buildResolved() {
  //   List<Tickets> tickets = getTicketListModel?.tickets ?? [];
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     controller: _scrollController,
  //     itemCount: tickets.length,
  //     itemBuilder: (context, index) {
  //       Tickets currentTicket = tickets[index];
  //       return currentTicket.status?.name == "Resolved"
  //           ? InkWell(
  //               onTap: () {
  //                 // _onPressTicket(currentTicket.incrementId ?? 1);
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       currentTicket.customer?.name ?? '',
  //                       style: AllListText().headingText(),
  //                       maxLines: 2,
  //                       softWrap: true,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     (currentTicket.subject != null)
  //                         ? Text(
  //                             currentTicket.subject ?? '',
  //                             style: AllListText().subHeadingText(),
  //                           )
  //                         : const SizedBox(),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           currentTicket.formatedCreatedAt ?? '',
  //                           style: AllListText().otherText(),
  //                         ),
  //                         Row(
  //                           children: [
  //                             Icon(
  //                               Icons.circle,
  //                               size: 12,
  //                               color: currentTicket.priority?.name == "Low"
  //                                   ? kBottomSheetHeadGreen
  //                                   : currentTicket.priority?.name == "High"
  //                                       ? kNumberCircleRed
  //                                       : gWhiteColor,
  //                               // AppConfig.fromHex(
  //                               //     currentTicket.priority!.color ?? ''),
  //                             ),
  //                             // SizedBox(width: 1.w),
  //                             // Icon(
  //                             //   (currentTicket.isStarred != null ||
  //                             //           currentTicket.isStarred == 'true')
  //                             //       ? Icons.star_outlined
  //                             //       : Icons.star_border,
  //                             //   size: 24,
  //                             //   color: (currentTicket.isStarred != null ||
  //                             //           currentTicket.isStarred == 'true')
  //                             //       ? Colors.yellow
  //                             //       : Colors.grey,
  //                             // ),
  //                             // Icon(
  //                             //   Utils.getSourceIcon(currentTicket.source),
  //                             //   size: 24,
  //                             //   color: Colors.grey,
  //                             // )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Replied By : ",
  //                           style: AllListText().otherText(),
  //                         ),
  //                         Expanded(
  //                           child: Text(
  //                             currentTicket.lastThreadUserType ?? "",
  //                             style: AllListText().subHeadingText(),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Text(
  //                       currentTicket.lastReplyAgentTime ?? '',
  //                       style: AllListText().otherText(),
  //                     ),
  //                     Container(
  //                       height: 1,
  //                       margin: EdgeInsets.symmetric(vertical: 1.5.h),
  //                       color: Colors.grey.withOpacity(0.3),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           : const SizedBox();
  //     },
  //   );
  // }
  //
  // buildClosed() {
  //   List<Tickets> tickets = getTicketListModel?.tickets ?? [];
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     controller: _scrollController,
  //     itemCount: tickets.length,
  //     itemBuilder: (context, index) {
  //       Tickets currentTicket = tickets[index];
  //       return currentTicket.status?.name == "Closed"
  //           ? InkWell(
  //               onTap: () {
  //                 // _onPressTicket(currentTicket.incrementId ?? 1);
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       currentTicket.customer?.name ?? '',
  //                       style: AllListText().headingText(),
  //                       maxLines: 2,
  //                       softWrap: true,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     (currentTicket.subject != null)
  //                         ? Text(
  //                             currentTicket.subject ?? '',
  //                             style: AllListText().subHeadingText(),
  //                           )
  //                         : const SizedBox(),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           currentTicket.formatedCreatedAt ?? '',
  //                           style: AllListText().otherText(),
  //                         ),
  //                         Row(
  //                           children: [
  //                             Icon(
  //                               Icons.circle,
  //                               size: 12,
  //                               color: currentTicket.priority?.name == "Low"
  //                                   ? kBottomSheetHeadGreen
  //                                   : currentTicket.priority?.name == "High"
  //                                       ? kNumberCircleRed
  //                                       : gWhiteColor,
  //                               // AppConfig.fromHex(
  //                               //     currentTicket.priority!.color ?? ''),
  //                             ),
  //                             // SizedBox(width: 1.w),
  //                             // Icon(
  //                             //   (currentTicket.isStarred != null ||
  //                             //           currentTicket.isStarred == 'true')
  //                             //       ? Icons.star_outlined
  //                             //       : Icons.star_border,
  //                             //   size: 24,
  //                             //   color: (currentTicket.isStarred != null ||
  //                             //           currentTicket.isStarred == 'true')
  //                             //       ? Colors.yellow
  //                             //       : Colors.grey,
  //                             // ),
  //                             // Icon(
  //                             //   Utils.getSourceIcon(currentTicket.source),
  //                             //   size: 24,
  //                             //   color: Colors.grey,
  //                             // )
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Replied By : ",
  //                           style: AllListText().otherText(),
  //                         ),
  //                         Expanded(
  //                           child: Text(
  //                             currentTicket.lastThreadUserType ?? "",
  //                             style: AllListText().subHeadingText(),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Text(
  //                       currentTicket.lastReplyAgentTime ?? '',
  //                       style: AllListText().otherText(),
  //                     ),
  //                     Container(
  //                       height: 1,
  //                       margin: EdgeInsets.symmetric(vertical: 1.5.h),
  //                       color: Colors.grey.withOpacity(0.3),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           : const SizedBox();
  //     },
  //   );
  // }

  final UvDeskRepo repository = UvDeskRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}
