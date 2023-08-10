import 'dart:io';

import 'package:doctor_app_new/screens/customer_help_screens/ticket_pop_up_menu.dart';
import 'package:doctor_app_new/utils/doctor_details_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../model/error_model.dart';
import '../../model/uvDesk_model/get_ticket_threads_list_model.dart';
import '../../model/uvDesk_model/sent_reply_model.dart';
import '../../repository/api_service.dart';
import '../../repository/uvDesk_repo/uvDesk_repository.dart';
import '../../services/uvDesk_service/uvDesk_service.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';

import '../../widgets/widgets.dart';

class TicketChatScreen extends StatefulWidget {
  final String userName;
  final String thumpNail;
  final String ticketId;
  final String subject;
  final String incrementId;
  const TicketChatScreen({
    Key? key,
    required this.userName,
    required this.thumpNail,
    required this.ticketId,
    required this.subject, required this.incrementId,
  }) : super(key: key);

  @override
  State<TicketChatScreen> createState() => _TicketChatScreenState();
}

class _TicketChatScreenState extends State<TicketChatScreen>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController commentController = TextEditingController();
  bool showProgress = false;
  bool isLoading = false;
  ThreadsListModel? threadsListModel;
  List<Thread>? threadList;
  final _prefs = AppConfig().preferences;

  late final UvDeskService _uvDeskService =
      UvDeskService(uvDeskRepo: repository);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    commentController.addListener(() {
      setState(() {});
    });
    getThreadsList();
  }

  getThreadsList() async {
    setState(() {
      showProgress = true;
    });
    callProgressStateOnBuild(true);
    final result =
        await _uvDeskService.uvDaskTicketThreadsService(widget.ticketId);
    print("result: $result");

    if (result.runtimeType == ThreadsListModel) {
      print("Threads List");
      ThreadsListModel model = result as ThreadsListModel;
      threadsListModel = model;
      threadList = model.ticket.threads;
      print("threads List : $threadList");
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.h, left: 2.w, right: 4.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.5.h),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: gSecondaryColor,
                      ),
                    ),
                  ),
                  widget.thumpNail.isEmpty
                      ? CircleAvatar(
                          radius: 2.h,
                          backgroundColor: kNumberCircleRed,
                          child: Text(
                            getInitials(widget.userName, 2),
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontFamily: "GothamBold",
                              color: gWhiteColor,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 2.h,
                          backgroundImage: NetworkImage(widget.thumpNail),
                        ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: AllListText().headingText(),
                        ),
                        Text(
                          widget.ticketId,
                          style: AllListText().subHeadingText(),
                        ),
                        Text(
                          widget.subject,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AllListText().otherText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: gChatListBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RawScrollbar(
                        thumbVisibility: false,
                        thickness: 3,
                        controller: _scrollController,
                        radius: const Radius.circular(3),
                        thumbColor: gMainColor,
                        child: showProgress
                            ? buildCircularIndicator()
                            : threadsListModel!.ticket.threads.isEmpty
                                ? Center(
                                    child: Text(
                                      "Thread List Is Empty",
                                      style: AllListText().headingText(),
                                    ),
                                  )
                                : buildMessageList(threadsListModel!.ticket.threads),
                        // StreamBuilder(
                        //   stream: _uvDeskService.stream.asBroadcastStream(),
                        //   builder: (_, snapshot) {
                        //     print("snap.data: ${snapshot.data}");
                        //     if (snapshot.hasData) {
                        //       return buildMessageList();
                        //     } else if (snapshot.hasError) {
                        //       return Center(
                        //         child: Text(snapshot.error.toString()),
                        //       );
                        //     }
                        //     return const Center(
                        //       child: CircularProgressIndicator(),
                        //     );
                        //   },
                        // ),
                      ),
                    ),
                    _buildEnterMessageRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterMessageRow() {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 3.w, top: 0.5.h),
                  // padding: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                    color: gWhiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Form(
                    key: _scaffoldKey,
                    child: TextFormField(
                      cursorColor: gSecondaryColor,
                      controller: commentController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // hintText: "Say Something ...",
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          color: gMainColor,
                          fontSize: 10.sp,
                          fontFamily: "GothamBook",
                        ),
                        border: InputBorder.none,
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.sentiment_satisfied_alt_sharp,
                            color: gBlackColor,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.attach_file_sharp,
                            color: gBlackColor,
                          ),
                        ),
                      ),
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 10.sp),
                      maxLines: 3,
                      minLines: 1,
                      textInputAction: TextInputAction.none,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              commentController.text.toString().isEmpty
                  ? TicketPopUpMenu(ticketId: widget.ticketId, incrementId: widget.incrementId,)
                  : GestureDetector(
                      onTap: () {
                        ticketRaise();
                        // final message = Message(
                        //     text: commentController.text.toString(),
                        //     date: DateTime.now(),
                        //     sendMe: true,
                        //     image:
                        //         "assets/images/closeup-content-attractive-indian-business-lady.png");
                        setState(() {
                          // messages.add(message);
                        });
                        commentController.clear();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 2.w),
                        padding: const EdgeInsets.only(
                            left: 8, right: 5, top: 5, bottom: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              blurRadius: 10,
                              offset: const Offset(2, 5),
                            ),
                          ],
                          color: gSecondaryColor,
                        ),
                        child: Icon(
                          Icons.send,
                          color: gWhiteColor,
                          size: 2.5.h,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  buildMessageList(List<Thread> threads) {
    return GroupedListView<Thread, DateTime>(
      elements: threads,
      order: GroupedListOrder.DESC,
      reverse: false,
      floatingHeader: true,
      useStickyGroupSeparators: true,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      groupBy: (Thread message) {
        // final f = DateFormat(message.formatedCreatedAt.toString());
        // DateTime d = DateTime.parse(message.formatedCreatedAt.toString());
        return DateTime(2023, 7, 17);
      },
      // padding: EdgeInsets.symmetric(horizontal: 0.w),
      groupHeaderBuilder: (Thread message) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, bottom: 7),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: const BoxDecoration(
              color: Color(0xffd9e3f7),
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
            ),
            child: Text(
              "Today",
              // _buildHeaderDate(int.parse(message.formatedCreatedAt.toString())),
              style: TextStyle(
                fontFamily: "GothamBook",
                color: gBlackColor,
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
      itemBuilder: (context, Thread message) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     child: message.isIncoming
          //         ? _generateAvatarFromName(message.senderName)
          //         : null),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment:
                    message.user.id == "amithammi62@gmail.com"
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // overflow: Overflow.visible,
                    // clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 2.w, right: 2.w, bottom: 1.h, top: 1.h),
                        constraints: BoxConstraints(maxWidth: 70.w),
                        margin: message.user.email == "amithammi62@gmail.com"
                            ? EdgeInsets.only(
                                top: 0.5.h, bottom: 0.5.h, left:20.w)
                            : EdgeInsets.only(
                                top: 0.5.h, bottom: 0.5.h, right: 20.w),
                        // padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                        decoration: BoxDecoration(
                          color: (message.user.email !=
                                      "amithammi62@gmail.com")
                              ? gChatMeColor
                              : (message.user.email !=
                                          "amithammi62@gmail.com" )
                                  ? kNumberCircleRed
                                  : gWhiteColor,
                          boxShadow:
                              message.user.email == "amithammi62@gmail.com"
                                  ? [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(2, 4),
                                        blurRadius: 10,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(2, 4),
                                        blurRadius: 10,
                                      ),
                                    ],
                          borderRadius: BorderRadius.circular(7),
                          // BorderRadius.only(
                          //     topLeft: const Radius.circular(18),
                          //     topRight: const Radius.circular(18),
                          //     bottomLeft: message.isIncoming
                          //         ? const Radius.circular(0)
                          //         : const Radius.circular(18),
                          //     bottomRight: message.isIncoming
                          //         ? const Radius.circular(18)
                          //         : const Radius.circular(0),),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                message.user.name,
                                style: AllListText().subHeadingText(),
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Align(
                              alignment: Alignment.topLeft,
                              child: HtmlWidget(message.message),
                            ),
                            SizedBox(height: 0.5.h),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                message.createdAt,
                                style: AllListText().otherText(),
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(top: 0.5.h),
                            //     child: Row(
                            //       mainAxisSize: MainAxisSize.min,
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: _buildNameTimeHeader(message),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      controller: _scrollController,
    );
  }

  String _buildHeaderDate(int? timeStamp) {
    String completedDate = "";
    DateFormat dayFormat = DateFormat("d MMMM");
    DateFormat lastYearFormat = DateFormat("dd.MM.yy");

    DateTime now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    var yesterday = DateTime(now.year, now.month, now.day - 1);

    timeStamp ??= 0;
    DateTime messageTime =
        DateTime.fromMicrosecondsSinceEpoch(timeStamp * 1000);
    DateTime messageDate =
        DateTime(messageTime.year, messageTime.month, messageTime.day);

    if (today == messageDate) {
      completedDate = "Today";
    } else if (yesterday == messageDate) {
      completedDate = "Yesterday";
    } else if (now.year == messageTime.year) {
      completedDate = dayFormat.format(messageTime);
    } else {
      completedDate = lastYearFormat.format(messageTime);
    }

    return completedDate;
  }

  // List<Widget> _buildNameTimeHeader(message) {
  //   return <Widget>[
  //     // const Padding(padding: EdgeInsets.only(left: 16)),
  //     // _buildSenderName(message),
  //     // const Padding(padding: EdgeInsets.only(left: 7)),
  //     // const Expanded(child: SizedBox.shrink()),
  //     //  const Padding(padding: EdgeInsets.only(left: 3)),
  //     _buildDateSent(message),
  //     Padding(padding: EdgeInsets.only(left: 1.w)),
  //     message.isIncoming
  //         ? const SizedBox.shrink()
  //         : _buildMessageStatus(message),
  //   ];
  // }
  //
  // Widget _buildMessageStatus(message) {
  //   var deliveredIds = message.qbMessage.deliveredIds;
  //   var readIds = message.qbMessage.readIds;
  //   // if (_dialogType == QBChatDialogTypes.PUBLIC_CHAT) {
  //   //   return SizedBox.shrink();
  //   // }
  //   if (readIds != null && readIds.length > 1) {
  //     return const Icon(
  //       Icons.done_all,
  //       color: Colors.blue,
  //       size: 14,
  //     );
  //   } else if (deliveredIds != null && deliveredIds.length > 1) {
  //     return const Icon(Icons.done_all, color: gGreyColor, size: 14);
  //   } else {
  //     return const Icon(Icons.done, color: gGreyColor, size: 14);
  //   }
  // }
  //
  // Widget _buildDateSent(message) {
  //   // print("DateTime:${message.qbMessage.dateSent!}");
  //   return Text(
  //     _buildTime(message.qbMessage.dateSent!),
  //     maxLines: 1,
  //     style: TextStyle(
  //       fontSize: 7.sp,
  //       color: gTextColor,
  //       fontFamily: "GothamBook",
  //     ),
  //   );
  // }

  String _buildTime(int timeStamp) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timeStamp * 1000);
    String amPm = 'AM';
    if (dateTime.hour >= 12) {
      amPm = 'PM';
    }

    String hour = dateTime.hour.toString();
    if (dateTime.hour > 12) {
      hour = (dateTime.hour - 12).toString();
    }

    String minute = dateTime.minute.toString();
    if (dateTime.minute < 10) {
      minute = '0${dateTime.minute}';
    }
    return '$hour:$minute $amPm';
  }

  Widget _generateAvatarFromName(String? name) {
    name ??= "No name";
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          color: gMainColor.withOpacity(0.18),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text(
          name.substring(0, 1).toUpperCase(),
          style: const TextStyle(
              color: gPrimaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'GothamMedium'),
        ),
      ),
    );
  }

  static String getInitials(String string, int limitTo) {
    var buffer = StringBuffer();
    var wordList = string.trim().split(' ');

    if (string.isEmpty) {
      return string;
    }

    if (wordList.length <= 1) {
      return string.characters.first;
    }

    if (limitTo > wordList.length) {
      for (var i = 0; i < wordList.length; i++) {
        buffer.write(wordList[i][0]);
      }
      return buffer.toString();
    }

    // Handle all other cases
    for (var i = 0; i < (limitTo); i++) {
      buffer.write(wordList[i][0]);
    }
    return buffer.toString();
  }

  final UvDeskRepo repository = UvDeskRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  List<File> fileFormatList = [];

  ticketRaise() async {
    setState(() {
      isLoading = true;
    });
    print("---------Ticket Raise---------");

    Map m = {
      'message': commentController.text,
      'threadType': "reply",
      'actAsType': "agent",
      "status_id": "1",
      'actAsEmail': _prefs!.getString(DoctorDetailsStorage.doctorDetailsEmail),
      // 'status': (TicketStatusType.Answered.index+1).toString()
    };

    final result = await _uvDeskService.uvDaskSendReplyService(
        widget.ticketId, m,
        attachments: fileFormatList,
    );

    if (result.runtimeType == SentReplyModel) {
      SentReplyModel model = result as SentReplyModel;
      setState(() {
        isLoading = false;
      });
      // GwcApi().showSnackBar(context, model.message!, isError: true);
      commentController.clear();
    } else {
      setState(() {
        isLoading = false;
      });
      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: false);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool sendMe;
  final String image;

  Message(
      {required this.text,
      required this.date,
      required this.sendMe,
      required this.image});
}
