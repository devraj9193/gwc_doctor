import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_animations/im_animations.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../controller/customer_call_controller.dart';
import '../screens/notification_screens/notification_screen.dart';
import '../utils/constants.dart';

CustomerCallController callController = Get.put(CustomerCallController());

class CommonDecoration {
  static InputDecoration buildInputDecoration(
      String hintText, TextEditingController controller,
      {Widget? suffixIcon}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: "GothamBook", color: gTextColor, fontSize: 10.sp),
        border: InputBorder.none,
        suffixIcon: suffixIcon
        // controller.text.isEmpty
        //     ? Container(
        //         width: 0,
        //       )
        //     : IconButton(
        //         onPressed: () {
        //           controller.clear();
        //         },
        //         icon: const Icon(
        //           Icons.close,
        //           color: kPrimaryColor,
        //         ),
        //       ),
        );
  }

  static InputDecoration buildTextInputDecoration(
      String hintText, TextEditingController controller,
      {Widget? suffixIcon}) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "PoppinsRegular",
          color: Colors.grey,
          fontSize: 10.sp,
        ),
        counterText: "",
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: kPrimaryColor, width: 1.0, style: BorderStyle.solid),
        ),
        suffixIcon: suffixIcon
        // controller.text.isEmpty
        //     ? const SizedBox()
        //     : IconButton(
        //         onPressed: () {
        //           controller.clear();
        //         },
        //         icon: const Icon(
        //           Icons.close,
        //           color: kPrimaryColor,
        //         ),
        //       ),
        );
  }
}

AppBar dashboardAppBar() {
  return AppBar(
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
      Padding(
        padding: EdgeInsets.only(right: 3.w),
        child: InkWell(
          child: const Icon(
            Icons.notifications_none_sharp,
            color: gBlackColor,
          ),
          onTap: () {
            Get.to(() => const NotificationScreen());
          },
        ),
      )
    ],
  );
}

Center buildLoadingBar() {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: gPrimaryColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: gMainColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      child: SizedBox(
        height: 2.5.h,
        width: 5.w,
        child: const CircularProgressIndicator(
          color: gMainColor,
          strokeWidth: 2.5,
        ),
      ),
    ),
  );
}

SnackbarController buildSnackBar(String title, String subTitle) {
  return Get.snackbar(
    title,
    subTitle,
    titleText: Text(
      title,
      style: TextStyle(
        fontFamily: "PoppinsSemiBold",
        color: kWhiteColor,
        fontSize: 13.sp,
      ),
    ),
    messageText: Text(
      subTitle,
      style: TextStyle(
        fontFamily: "PoppinsMedium",
        color: kWhiteColor,
        fontSize: 12.sp,
      ),
    ),
    backgroundColor: kPrimaryColor.withOpacity(0.5),
    snackPosition: SnackPosition.BOTTOM,
    colorText: kWhiteColor,
    margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
    borderRadius: 10,
    duration: const Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.decelerate,
  );
}

AppBar buildAppBar(VoidCallback func) {
  return AppBar(
    backgroundColor: gWhiteColor,
    centerTitle: false,
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Row(
      children: [
        GestureDetector(
          onTap: func,
          child: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: gMainColor,
            size: 2.h,
          ),
        ),
        SizedBox(width: 2.w),
        SizedBox(
          height: 5.h,
          child: const Image(
            image: AssetImage("assets/images/Gut wellness logo.png"),
          ),
        ),
      ],
    ),
  );
}

Padding buildNoData() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.h),
    child: Image(
      image: const AssetImage("assets/images/Group 5294.png"),
      height: 25.h,
    ),
  );
}

Center buildCircularIndicator() {
  return Center(
    child: HeartBeat(
        child: Image.asset(
      'assets/images/progress_logo.png',
      width: 75,
      height: 75,
    )),
  );
}

buildLabelTextField(String name) {
  return RichText(
      text: TextSpan(
          text: name,
          style: TextStyle(
            fontSize: 9.sp,
            color: gPrimaryColor,
            fontFamily: "GothamBook",
          ),
          children: [
        TextSpan(
          text: ' *',
          style: TextStyle(
            fontSize: 9.sp,
            color: gSecondaryColor,
            fontFamily: "GothamBook",
          ),
        )
      ]));
  return Text(
    'Full Name:*',
    style: TextStyle(
      fontSize: 9.sp,
      color: kTextColor,
      fontFamily: "PoppinsSemiBold",
    ),
  );
}

buildThreeBounceIndicator({Color? color}) {
  return Center(
    child: SpinKitThreeBounce(
      color: color ?? gMainColor,
      size: 25,
    ),
  );
}

TextStyle buildTextStyle() {
  return const TextStyle(
    color: gBlackColor,
    fontSize: 12,
    fontFamily: "GothamBook",
  );
}

void dialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: gWhiteColor.withOpacity(0.8),
    context: context,
    builder: (context) => Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: gWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: gMainColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Log Out ?",
              style: TextStyle(
                color: gTextColor,
                fontFamily: "GothamMedium",
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text('Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "GothamBook",
                  color: gTextColor,
                  fontSize: 11.sp,
                )),
            SizedBox(height: 2.5.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: gPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: gMainColor),
                      ),
                      child: Text("Call",
                          style: TextStyle(
                            color: gMainColor,
                            fontFamily: "GothamMedium",
                            fontSize: 9.sp,
                          ))),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: gWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: gMainColor),
                      ),
                      child: Text("Cancel",
                          style: TextStyle(
                            color: gPrimaryColor,
                            fontFamily: "GothamMedium",
                            fontSize: 9.sp,
                          ))),
                ),
                SizedBox(width: 3.w),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void callDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: gWhiteColor.withOpacity(0.8),
    context: context,
    builder: (context) => Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: gWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: gMainColor, width: 1),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Call",
              style: TextStyle(
                color: gPrimaryColor,
                fontFamily: "GothamMedium",
                fontSize: 11.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Are you sure you want to call?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "GothamBook",
                    color: gMainColor,
                    fontSize: 11.sp,
                  )),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    callController.fetchCustomersCall();
                    Get.back();
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: gPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: gMainColor),
                      ),
                      child: Text("Call",
                          style: TextStyle(
                            color: gMainColor,
                            fontFamily: "GothamMedium",
                            fontSize: 9.sp,
                          ))),
                ),
                SizedBox(width: 3.w),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: gWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: gMainColor),
                      ),
                      child: Text("Cancel",
                          style: TextStyle(
                            color: gPrimaryColor,
                            fontFamily: "GothamMedium",
                            fontSize: 9.sp,
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class CommonButton {
  static ElevatedButton submitButton(func, String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: gPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      ),
      onPressed: func,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "PoppinsRegular",
          color: Colors.white,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}

List<String> dailyProgress = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
];
