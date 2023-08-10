import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../model/error_model.dart';
import '../../model/uvDesk_model/sent_reply_model.dart';
import '../../repository/api_service.dart';
import '../../repository/uvDesk_repo/uvDesk_repository.dart';
import '../../services/uvDesk_service/uvDesk_service.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';

class TicketPopUpMenu extends StatefulWidget {
  final String ticketId;
  final String incrementId;
  const TicketPopUpMenu({
    Key? key,
    required this.ticketId, required this.incrementId,
  }) : super(key: key);

  @override
  State<TicketPopUpMenu> createState() => _TicketPopUpMenuState();
}

class _TicketPopUpMenuState extends State<TicketPopUpMenu> {
  bool showLogoutProgress = false;

  var logoutProgressState;

  late final UvDeskService _uvDeskService =
  UvDeskService(uvDeskRepo: repository);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: null,
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 1.h),
              GestureDetector(
                onTap: () {
                  sendDialog("1797343", "", widget.incrementId, false);
                },
                child: Text(
                  "Reassign",
                  style: AllListText().subHeadingText(),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 0.5.h),
              //   height: 1,
              //   // color: gGreyColor.withOpacity(0.3),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     sendDialog("ios@fembuddy.com", "", widget.ticketId, false);
              //   },
              //   child: Text(
              //     "Transfer to Doctor",
              //     style: AllListText().subHeadingText(),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 0.5.h),
              //   height: 1,
              //   // color: gGreyColor.withOpacity(0.3),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     sendDialog("status", "3", widget.ticketId, true);
              //   },
              //   child: Text(
              //     "Mark as Resolved",
              //     style: AllListText().subHeadingText(),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 0.5.h),
              //   height: 1,
              //   // color: gGreyColor.withOpacity(0.3),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     sendDialog("status", "4", widget.ticketId, true);
              //   },
              //   child: Text(
              //     "Close the Ticket",
              //     style: AllListText().subHeadingText(),
              //   ),
              // ),
              // SizedBox(height: 0.5.h),
            ],
          ),
        ),
      ],
      child: Container(
        margin: EdgeInsets.only(right: 2.w),
        padding: const EdgeInsets.all(9),
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
        child: const Icon(
          Icons.more_vert_sharp,
          color: gBlackColor,
        ),
      ),
    );
  }

  sendDialog(String editType, String value, String threadId, bool isCancelled) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (_, setstate) {
        logoutProgressState = setstate;
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0.sp),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 1.h),
          content: Container(
            // margin: EdgeInsets.symmetric(horizontal: 5.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: gWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightTextColor, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Are you sure?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: fontBold,
                      color: newBlackColor,
                      fontSize: fontSize11),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  height: 1,
                  color: lightTextColor,
                ),
                SizedBox(height: 1.h),
                showLogoutProgress
                    ? buildCircularIndicator()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: isCancelled
                          ? () {
                        sendCancelledResolved(
                            editType, value, widget.ticketId);
                      }
                          : () {
                        sendReassign(editType, widget.ticketId);
                        // sendTransferToDoctor(
                        //     editType, widget.ticketId);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: gSecondaryColor,
                          borderRadius: BorderRadius.circular(5),
                          // border: Border.all(color: gMainColor),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: whiteTextColor,
                            fontFamily: fontMedium,
                            fontSize: fontSize09,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: gWhiteColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: lightTextColor),
                          ),
                          child: Text("No",
                              style: TextStyle(
                                color: newBlackColor,
                                fontFamily: fontMedium,
                                fontSize: fontSize09,
                              ))),
                    ),
                  ],
                ),
                SizedBox(height: 1.h)
              ],
            ),
          ),
        );
      }),
    );
  }

  final UvDeskRepo repository = UvDeskRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  sendCancelledResolved(String editType, String value, String threadId) async {
    logoutProgressState(() {
      showLogoutProgress = true;
    });
    print("---------Cancelled Or Resolved---------");

    final result =
    await _uvDeskService.uvDeskCancelledService(editType, value, threadId);

    if (result.runtimeType == SentReplyModel) {
      SentReplyModel model = result as SentReplyModel;
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      Navigator.pop(context);
      AppConfig().showSnackBar(context, model.message!, isError: true);
    } else {
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: false);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
    logoutProgressState(() {
      showLogoutProgress = true;
    });
  }

  sendReassign(String agentId, String threadId) async {
    logoutProgressState(() {
      showLogoutProgress = true;
    });
    print("---------Reassign---------");

    final result =
    await _uvDeskService.uvDeskReassignService(agentId, threadId);

    if (result.runtimeType == SentReplyModel) {
      SentReplyModel model = result as SentReplyModel;
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      Navigator.pop(context);
      AppConfig().showSnackBar(context, model.message!, isError: true);
    } else {
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: false);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
    logoutProgressState(() {
      showLogoutProgress = true;
    });
  }

  sendTransferToDoctor(String email, String threadId) async {
    logoutProgressState(() {
      showLogoutProgress = true;
    });
    print("---------Transfer To Doctor---------");

    final result =
    await _uvDeskService.uvDeskTransferToDoctorService(email, threadId);

    if (result.runtimeType == SentReplyModel) {
      SentReplyModel model = result as SentReplyModel;
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      Navigator.pop(context);
      AppConfig().showSnackBar(context, model.message!, isError: true);
    } else {
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: false);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
    logoutProgressState(() {
      showLogoutProgress = true;
    });
  }
}
