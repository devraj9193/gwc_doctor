import 'package:doctor_app_new/screens/login_screens/doctor_login.dart';
import 'package:doctor_app_new/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../utils/app_config.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import 'my_profile_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SharedPreferences _pref = AppConfig().preferences!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: dashboardAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 5.h,
                //   child: const Image(
                //     image: AssetImage("assets/images/Gut wellness logo.png"),
                //   ),
                // ),
                // SizedBox(height: 1.h),
                Text(
                  "My Profile",
                  textAlign: TextAlign.center,
                  style: ProfileScreenText().headingText(),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyProfileDetails(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 3.h,
                        backgroundImage: NetworkImage(
                          "${_pref.getString(GwcApi.successMemberProfile)}",
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${_pref.getString(GwcApi.successMemberName)}",
                            style: ProfileScreenText().nameText()),
                        SizedBox(height: 0.6.h),
                        Text("${_pref.getString(GwcApi.successMemberAddress)}",
                            style: ProfileScreenText().otherText()),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                profileTile("assets/images/Group 2753.png", "My Profile", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyProfileDetails(),
                    ),
                  );
                }),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                profileTile("assets/images/Group 2744.png", "Logout", () {
                  dialog(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileTile(String image, String title, func) {
    return GestureDetector(
      onTap: func,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: gBlackColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image(
              image: AssetImage(image),
              height: 4.h,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              title,
              style:ProfileScreenText().subHeadingText(),
            ),
          ),
          GestureDetector(
            onTap: func,
            child: Icon(
              Icons.arrow_forward_ios,
              color: gBlackColor,
              size: 1.8.h,
            ),
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
            border: Border.all(color: lightTextColor, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Log Out ?",
                style: TextStyle(
                  color: newBlackColor,
                  fontFamily: fontBold,
                  fontSize: fontSize11,
                ),
              ),
              SizedBox(height: 2.h),
              Text('Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontBook,
                    color: newBlackColor,
                    fontSize: fontSize10,
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
                          border: Border.all(color: lightTextColor),
                        ),
                        child: Text("Cancel",
                            style: TextStyle(
                              color: newBlackColor,
                              fontFamily: fontMedium,
                              fontSize: fontSize09,
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
                          color: gSecondaryColor,
                          borderRadius: BorderRadius.circular(8),
                         // border: Border.all(color: gMainColor),
                        ),
                        child: Text("Log Out",
                            style: TextStyle(
                              color: whiteTextColor,
                              fontFamily: fontMedium,
                              fontSize: fontSize09,
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
//       SafeArea(
//       child: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 1.h),
//             SizedBox(
//               height: 8.h,
//               child: const Image(
//                 image: AssetImage("assets/images/Gut wellness logo.png"),
//               ),
//             ),
//             SizedBox(height: 1.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 3.w),
//               child: Text(
//                 "My Profile",
//                 style: TextStyle(
//                     fontFamily: "GothamBold",
//                     color: gPrimaryColor,
//                     fontSize: 11.sp),
//               ),
//             ),
//             SizedBox(height: 2.h),
//             profileTile("assets/images/Group 2744.png", "Logout", () {
//               dialog(context);
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   profileTile(String image, String title, func) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 4.w),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: func,
//             child: Row(
//               children: [
//                 Image(
//                   image: AssetImage(image),
//                   height: 4.h,
//                 ),
//                 SizedBox(
//                   width: 4.w,
//                 ),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: kTextColor,
//                     fontFamily: 'GothamBook',
//                     fontSize: 10.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 1,
//             margin: EdgeInsets.symmetric(vertical: 1.h),
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void dialog(BuildContext context) {
//     showDialog(
//       barrierDismissible: false,
//       barrierColor: gWhiteColor.withOpacity(0.8),
//       context: context,
//       builder: (context) => Center(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 5.w),
//           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
//           decoration: BoxDecoration(
//             color: gWhiteColor,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: gMainColor, width: 1),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 "Log Out ?",
//                 style: TextStyle(
//                   color: gTextColor,
//                   fontFamily: "GothamMedium",
//                   fontSize: 11.sp,
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               Text('Are you sure you want to log out?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: "GothamBook",
//                     color: gTextColor,
//                     fontSize: 11.sp,
//                   )),
//               SizedBox(height: 2.5.h),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).pop(false),
//                     child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 9.w, vertical: 1.h),
//                         decoration: BoxDecoration(
//                           color: gWhiteColor,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: gMainColor),
//                         ),
//                         child: Text("Cancel",
//                             style: TextStyle(
//                               color: gPrimaryColor,
//                               fontFamily: "GothamMedium",
//                               fontSize: 9.sp,
//                             ))),
//                   ),
//                   SizedBox(width: 3.w),
//                   GestureDetector(
//                     onTap: () async {
//                       SharedPreferences preferences =
//                           await SharedPreferences.getInstance();
//                       preferences.clear();
//                       preferences.commit();
//                       Get.to(const DoctorLogin());
//                     },
//                     child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 9.w, vertical: 1.h),
//                         decoration: BoxDecoration(
//                           color: gPrimaryColor,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: gMainColor),
//                         ),
//                         child: Text("Log Out",
//                             style: TextStyle(
//                               color: gMainColor,
//                               fontFamily: "GothamMedium",
//                               fontSize: 9.sp,
//                             ))),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
