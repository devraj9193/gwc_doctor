import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/chat_support/chat_support_method.dart';
import '../../model/customer_call_model.dart';
import '../../model/error_model.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';

class CallChatIcons extends StatefulWidget {
  final int userId;
  final String kaleyraUserId;
  final bool chat;
  const CallChatIcons(
      {Key? key,
      required this.userId,
      required this.kaleyraUserId,
      this.chat = false})
      : super(key: key);

  @override
  State<CallChatIcons> createState() => _CallChatIconsState();
}

class _CallChatIconsState extends State<CallChatIcons> {
  final  _pref = AppConfig().preferences;
  CustomerCallModel? customerCallModel;
  bool showLogoutProgress = false;

  var logoutProgressState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            dialog(
              context,
              widget.userId.toString(),
            );
          },
          child: Image.asset(
            'assets/images/Group 4890.png',
            height: 2.h,
            width: 2.h,
            color: gBlackColor,
          ),
        ),
        SizedBox(width: 4.w),
        widget.chat
            ? const SizedBox()
            : GestureDetector(
                onTap: () async {
                  final kaleyraUserId = _pref?.getString("kaleyraUserId");
                  final res = await getKaleyraAccessToken(kaleyraUserId!);

                  if (res.runtimeType != ErrorModel) {
                    final accessToken =
                        _pref?.getString(GwcApi.kaleyraAccessToken);

                    // chat
                    openKaleyraChat(kaleyraUserId,
                        widget.kaleyraUserId.toString(), accessToken!);
                  } else {
                    final result = res as ErrorModel;
                    print("get Access Token error: ${result.message}");
                    AppConfig().showSnackBar(context, result.message ?? '',
                        isError: true, bottomPadding: 70);
                  }
                  // final qbService =
                  //     Provider.of<QuickBloxService>(context, listen: false);
                  // qbService.openKaleyraChat(kaleyraUserId,
                  //     widget.kaleyraUserId.toString(), kaleyraAccessToken);
                },
                child: Image.asset(
                  'assets/images/Group 4891.png',
                  height: 2.5.h,
                  width: 2.5.h,
                  color: gBlackColor,
                ),
              ),
      ],
    );
  }

  void dialog(BuildContext context, String userId) {
    showDialog(
      barrierDismissible: false,
      barrierColor: gBlackColor.withOpacity(0.3),
      context: context,
      builder: (context) => StatefulBuilder(builder: (_, setstate) {
    logoutProgressState = setstate;
    return  Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: gWhiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: newLightGreyColor, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Call",
                style: DialogTextStyles().headingText(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 15.w),
                height: 1,
                color: lightTextColor,
              ),
              SizedBox(height: 2.h),
              Text(
                'Are you sure you want to call?',
                textAlign: TextAlign.center,
                style: DialogTextStyles().subHeadingText(),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: showLogoutProgress
                    ? buildCircularIndicator()
                    :  Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        customersCall(userId);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: gSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: gSecondaryColor),
                        ),
                        child: Text(
                          "Call",
                          style: DialogTextStyles().logoutText(),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: gWhiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: newLightGreyColor),
                        ),
                        child: Text(
                          "Cancel",
                          style: DialogTextStyles().cancelText(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );}),
    );
  }

  customersCall(String userId) async {
    logoutProgressState(() {
      showLogoutProgress = true;
    });
    var token = _pref?.getString(AppConfig().bearerToken)!;

    final response =
        await http.get(Uri.parse("${GwcApi.callApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    print("CustomerCallResponse:${response.body}");
    print("CustomerCallUrl:${GwcApi.callApiUrl}/$userId");
    print("CustomerCallUserId:$userId");

    Map<String, dynamic> responseData = jsonDecode(response.body);
    customerCallModel = CustomerCallModel.fromJson(responseData);

    if (response.statusCode == 200) {
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   backgroundColor: gPrimaryColor,
      //   // margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      //   // padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      //   content: Text("${customerCallModel?.data}"),
      // ),);
      Get.back();
    } else {
      logoutProgressState(() {
        showLogoutProgress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: gSecondaryColor,
          // margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          // padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          content: Text("${customerCallModel?.data}"),
        ),
      );
      throw Exception();
    }
    logoutProgressState(() {
      showLogoutProgress = false;
    });
  }
}
