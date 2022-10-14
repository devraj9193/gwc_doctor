import 'package:doctor_app_new/login_screens/doctor_login.dart';
import 'package:doctor_app_new/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            SizedBox(
              height: 8.h,
              child: const Image(
                image: AssetImage("assets/images/Gut wellness logo green.png"),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                "My Profile",
                style: TextStyle(
                    fontFamily: "GothamBold",
                    color: gPrimaryColor,
                    fontSize: 11.sp),
              ),
            ),
            SizedBox(height: 2.h),
            profileTile("assets/images/Group 2744.png", "Logout", () {
              dialog(context);
            }),
          ],
        ),
      ),
    );
  }

  profileTile(String image, String title, func) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          InkWell(
            onTap: func,
            child: Row(
              children: [
                Image(
                  image: AssetImage(image),
                  height: 4.h,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: kTextColor,
                    fontFamily: 'GothamBook',
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            color: Colors.grey,
          ),
        ],
      ),
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
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 1.h),
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
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      preferences.commit();
                      Get.to(const DoctorLogin());
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: gPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: gMainColor),
                        ),
                        child: Text("Log Out",
                            style: TextStyle(
                              color: gMainColor,
                              fontFamily: "GothamMedium",
                              fontSize: 9.sp,
                            ))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
