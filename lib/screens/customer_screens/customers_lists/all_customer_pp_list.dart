import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controller/all_customer_pp_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';
import '../../active_screens/active_customer_details.dart';

class AllCustomerPostProgramList extends StatefulWidget {
  const AllCustomerPostProgramList({Key? key}) : super(key: key);

  @override
  State<AllCustomerPostProgramList> createState() => _AllCustomerPostProgramListState();
}

class _AllCustomerPostProgramListState extends State<AllCustomerPostProgramList> {
  AllCustomerPPController allCustomerPPController =
  Get.put(AllCustomerPPController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: allCustomerPPController.fetchPostProgramList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return buildNoData();
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(height: 2.h),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    // padding: EdgeInsets.symmetric(horizontal: 3.w),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          saveUserDetailsId(
                              data[index].patientId.toString(),
                              data[index].id.toString(),
                              data[index].patient.user.id.toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ct) => ActiveCustomerDetails(
                                userName: data[index].patient.user.name ?? '',
                                age:
                                "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                appointmentDetails:
                                "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                                status: '',
                                startDate: '',
                                presentDay: '',
                                finalDiagnosis: '', preparatoryCurrentDay: data[index]
                                  .userDetails
                                  .patient
                                  .user
                                  .userProgram
                                  .ppCurrentDay ??
                                  "",
                                transitionCurrentDay: data[index]
                                    .userDetails
                                    .patient
                                    .user
                                    .userProgram
                                    .tpCurrentDay ??
                                    "",
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 2.h,
                                  backgroundImage: NetworkImage(data[index]
                                      .patient
                                      .user
                                      .profile
                                      .toString()),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index]
                                            .patient
                                            .user
                                            .name
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: "GothamMedium",
                                            color: gTextColor,
                                            fontSize: 10.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${data[index].patient.user.age.toString()} ${data[index].patient.user.gender.toString()}",
                                        style: TextStyle(
                                            fontFamily: "GothamMedium",
                                            color: gTextColor,
                                            fontSize: 9.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${data[index].appointmentDate.toString()} / ${data[index].appointmentTime.toString()}",
                                        style: TextStyle(
                                            fontFamily: "GothamBook",
                                            color: gTextColor,
                                            fontSize: 8.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Row(
                                        children: [
                                          Text(
                                            "Associated Doctor : ",
                                            style: TextStyle(
                                                fontFamily: "GothamBook",
                                                color: gBlackColor,
                                                fontSize: 8.sp),
                                          ),
                                          Text(
                                            data[index]
                                                .team
                                                .teamMember[0]
                                                .user
                                                .fname
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: "GothamMedium",
                                                color: gPrimaryColor,
                                                fontSize: 8.sp),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 0.5.h),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Status : ",
                                      //       style: TextStyle(
                                      //           fontFamily: "GothamBook",
                                      //           color: gBlackColor,
                                      //           fontSize: 8.sp),
                                      //     ),
                                      //     Text(
                                      //       data[index].status.toString(),
                                      //       style: TextStyle(
                                      //           fontFamily: "GothamMedium",
                                      //           color: gPrimaryColor,
                                      //           fontSize: 8.sp),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (ct) => const PostCustomerDetails(),
                                    //   ),
                                    // );
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/noun-view-1041859.svg"),
                                ),
                              ],
                            ),
                            Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(vertical: 1.5.h),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  saveUserDetailsId(
      String patientId, String teamPatientId, String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("patient_id", patientId);
    preferences.setString("team_patient_id", teamPatientId);
    preferences.setString("user_id", userId);
  }

  saveUserId(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_id", userId);
  }
}
