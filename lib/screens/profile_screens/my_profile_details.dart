import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controller/repository/api_service.dart';
import '../../model/doctor_profile_service/doctor_profile_repo.dart';
import '../../model/doctor_profile_service/doctor_profile_service.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MyProfileDetails extends StatefulWidget {
  const MyProfileDetails({Key? key}) : super(key: key);

  @override
  State<MyProfileDetails> createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {
  final SharedPreferences _pref = AppConfig().preferences!;

  String accessToken = "";
  Future? getProfileDetails;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() {
    accessToken = _pref.getString(AppConfig().bearerToken)!;
    setState(() {});
    print("accessToken: $accessToken");
    getProfileDetails = DoctorMemberProfileService(repository: userRepository)
        .getDoctorMemberProfileService(accessToken);
  }
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
              padding: EdgeInsets.only(left: 3.w,top: 1.h,bottom: 2.h),
              child: Text(
                "My Profile",
                textAlign: TextAlign.center,
                style: ProfileScreenText().headingText(),

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
        future: getProfileDetails,
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
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: whiteTextColor,

                        border: Border.all(width: 1, color: lightTextColor.withOpacity(0.3)),
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
                    top: 38.h,
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
                          border: Border.all(width: 1, color: lightTextColor.withOpacity(0.3))),
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
                style: ProfileScreenText().nameText()

            ),
            Expanded(
              child: Text(
                title,
                  style: ProfileScreenText().otherText()

              ),
            ),
          ],
        ),
        Container(
          height: 1,
          margin: EdgeInsets.symmetric(vertical: 2.h),
          color: lightTextColor.withOpacity(0.3),
        ),
      ],
    );
  }

  final DoctorMemberProfileRepository userRepository =
  DoctorMemberProfileRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}
