import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/all_customer_pp_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';
import '../../post_programs_screens/new_post_program/pp_levels_demo.dart';

class AllCustomersMaintenanceGuideList extends StatefulWidget {
  const AllCustomersMaintenanceGuideList({Key? key}) : super(key: key);

  @override
  State<AllCustomersMaintenanceGuideList> createState() =>
      _AllCustomersMaintenanceGuideListState();
}

class _AllCustomersMaintenanceGuideListState
    extends State<AllCustomersMaintenanceGuideList> {
  AllCustomerPPController allCustomerPPController =
      Get.put(AllCustomerPPController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: allCustomerPPController.fetchMaintenanceGuideList(),
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
                    physics: const ScrollPhysics(),
                    //  padding: EdgeInsets.symmetric(horizontal: 3.w),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ct) => const PPLevelsDemo(),
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
                                // PopupMenuButton(
                                //   offset: const Offset(0, 30),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(5)),
                                //   itemBuilder: (context) => [
                                //     PopupMenuItem(
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           SizedBox(height: 1.h),
                                //           GestureDetector(
                                //             onTap: () {
                                //               saveUserId(
                                //                 data[index]
                                //                     .patient
                                //                     .user
                                //                     .id
                                //                     .toString(),
                                //               );
                                //               Navigator.of(context).push(
                                //                 MaterialPageRoute(
                                //                   builder: (ct) =>
                                //                       const PostCustomerDetails(),
                                //                 ),
                                //               );
                                //             },
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Text(
                                //                   "View",
                                //                   style: TextStyle(
                                //                       fontFamily: "GothamBook",
                                //                       color: gTextColor,
                                //                       fontSize: 8.sp),
                                //                 ),
                                //                 SizedBox(width: 10.w),
                                //                 SvgPicture.asset(
                                //                     "assets/images/noun-view-1041859.svg")
                                //               ],
                                //             ),
                                //           ),
                                //           Container(
                                //             margin: EdgeInsets.symmetric(
                                //                 vertical: 1.h),
                                //             height: 1,
                                //             color: gGreyColor.withOpacity(0.3),
                                //           ),
                                //           GestureDetector(
                                //             onTap: () {
                                //               saveUserId(
                                //                 data[index]
                                //                     .patient
                                //                     .user
                                //                     .id
                                //                     .toString(),
                                //               );
                                //               Navigator.of(context).push(
                                //                 MaterialPageRoute(
                                //                   builder: (ct) =>
                                //                       const PostProgramProgress(),
                                //                 ),
                                //               );
                                //             },
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Text(
                                //                   "Progress",
                                //                   style: TextStyle(
                                //                       fontFamily: "GothamBook",
                                //                       color: gTextColor,
                                //                       fontSize: 8.sp),
                                //                 ),
                                //                 SizedBox(width: 10.w),
                                //                 Image(
                                //                   image: const AssetImage(
                                //                       "assets/images/Group 4895.png"),
                                //                   height: 2.h,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           Container(
                                //             margin: EdgeInsets.symmetric(
                                //                 vertical: 1.h),
                                //             height: 1,
                                //             color: gGreyColor.withOpacity(0.3),
                                //           ),
                                //           GestureDetector(
                                //             onTap: () {
                                //               saveUserId(
                                //                 data[index]
                                //                     .patient
                                //                     .user
                                //                     .id
                                //                     .toString(),
                                //               );
                                //               getChatGroupId(
                                //                   data[index]
                                //                       .patient
                                //                       .user
                                //                       .name
                                //                       .toString(),
                                //                   data[index]
                                //                       .patient
                                //                       .user
                                //                       .age
                                //                       .toString(),
                                //                   data[index]
                                //                       .patient
                                //                       .user
                                //                       .gender
                                //                       .toString());
                                //             },
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Text(
                                //                   "Message",
                                //                   style: TextStyle(
                                //                       fontFamily: "GothamBook",
                                //                       color: gTextColor,
                                //                       fontSize: 8.sp),
                                //                 ),
                                //                 SizedBox(width: 10.w),
                                //                 Image(
                                //                   image: const AssetImage(
                                //                       "assets/images/Group 4891.png"),
                                //                   height: 2.h,
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //           SizedBox(height: 0.5.h),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                //   child: Icon(
                                //     Icons.more_vert,
                                //     color: gGreyColor.withOpacity(0.5),
                                //   ),
                                // ),
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
