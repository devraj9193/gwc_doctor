import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controller/user_profile_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'package:get/get.dart';

class MyProfileDetails extends StatefulWidget {
  const MyProfileDetails({Key? key}) : super(key: key);

  @override
  State<MyProfileDetails> createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {
  UserProfileController userProfileController =
      Get.put(UserProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: buildAppBar(() {
          Navigator.pop(context);
        }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w,top: 1.h),
              child: Text(
                "My Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "GothamBold",
                    color: gPrimaryColor,
                    fontSize: 11.sp),
              ),
            ),
            Expanded(
              child: buildUserDetails(),
            ),
          ],
        ),
      ),
    );
  }

  buildUserDetails() {
    return FutureBuilder(
        future: userProfileController.fetchUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return buildNoData();
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return LayoutBuilder(builder: (context, constraints) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.withOpacity(0.5))
                        ],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(data.data.profile.toString()),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 33.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 66.h,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                          color: gWhiteColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          border: Border.all(width: 1, color: gMainColor)),
                      child: Column(
                        children: [
                          SizedBox(height: 3.h),
                          profileTile("Name : ", data.data.name ?? ""),
                          profileTile("Age : ", data.data.age ?? ""),
                          profileTile("Gender : ", data.data.gender ?? ""),
                          profileTile("Email : ", data.data.email ?? ""),
                          profileTile(
                              "Mobile Number : ", data.data.phone ?? ""),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: buildCircularIndicator(),
          );
        });
  }

  profileTile(String heading, String title) {
    return Column(
      children: [
        Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              heading,
              style: TextStyle(
                color: gBlackColor,
                fontFamily: 'GothamMedium',
                fontSize: 10.sp,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: gBlackColor,
                  fontFamily: 'GothamBook',
                  fontSize: 9.sp,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          margin: EdgeInsets.symmetric(vertical: 2.h),
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }
}
