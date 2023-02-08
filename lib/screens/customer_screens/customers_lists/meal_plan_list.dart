import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controller/meal_active_list_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';
import '../../meal_plans_screens/meal_customer_details.dart';

class CustomersMealPlanList extends StatefulWidget {
  const CustomersMealPlanList({Key? key}) : super(key: key);

  @override
  State<CustomersMealPlanList> createState() => _CustomersMealPlanListState();
}

class _CustomersMealPlanListState extends State<CustomersMealPlanList> {
  String statusText = "";
  MealActiveListController mealActiveListController =
      Get.put(MealActiveListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: mealActiveListController.fetchMealPlanList(),
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
                          saveUserId(
                              data[index].userDetails.patientId.toString(),
                              data[index].userDetails.id.toString(),
                              data[index]
                                  .userDetails
                                  .patient
                                  .user
                                  .id
                                  .toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ct) => MealsCustomerDetails(
                                userName:
                                    data[index].userDetails.patient.user.name ??
                                        '',
                                age:
                                    "${data[index].userDetails.patient.user.age ?? ""} ${data[index].userDetails.patient.user.gender ?? ""}",
                                appointmentDetails:
                                    "${data[index].userDetails.appointmentDate ?? ""} / ${data[index].userDetails.appointmentTime ?? ""}",
                                status: buildStatusText(
                                    data[index].userDetails.status),
                                finalDiagnosis:
                                    data[index].userFinalDiagnosis ?? '',
                                preparatoryCurrentDay: data[index]
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
                                      .userDetails
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
                                            .userDetails
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
                                        "${data[index].userDetails.patient.user.age.toString()} ${data[index].userDetails.patient.user.gender.toString()}",
                                        style: TextStyle(
                                            fontFamily: "GothamMedium",
                                            color: gTextColor,
                                            fontSize: 8.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${data[index].userDetails.appointmentDate.toString()} / ${data[index].userDetails.appointmentTime.toString()}",
                                        style: TextStyle(
                                            fontFamily: "GothamBook",
                                            color: gTextColor,
                                            fontSize: 8.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Row(
                                        children: [
                                          Text(
                                            "Status : ",
                                            style: TextStyle(
                                                fontFamily: "GothamBook",
                                                color: gBlackColor,
                                                fontSize: 8.sp),
                                          ),
                                          Text(
                                            buildStatusText(data[index]
                                                .userDetails
                                                .status
                                                .toString()),
                                            style: TextStyle(
                                                fontFamily: "GothamMedium",
                                                color: gPrimaryColor,
                                                fontSize: 8.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Row(
                                        children: [
                                          Text(
                                            "Final Diagnosis : ",
                                            style: TextStyle(
                                                fontFamily: "GothamBook",
                                                color: gBlackColor,
                                                fontSize: 8.sp),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data[index]
                                                  .userFinalDiagnosis
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily: "GothamMedium",
                                                  color: gPrimaryColor,
                                                  fontSize: 8.sp),
                                            ),
                                          ),
                                          Text(
                                            "See more",
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: gPrimaryColor,
                                              fontFamily: "GothamBook",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 0.5.h),
                                      (data[index]
                                                      .userDetails
                                                      .patient
                                                      .user
                                                      .userProgram
                                                      .prepDays ==
                                                  data[index]
                                                      .userDetails
                                                      .patient
                                                      .user
                                                      .userProgram
                                                      .ppCurrentDay) &&
                                              (data[index]
                                                      .userDetails
                                                      .patient
                                                      .user
                                                      .userProgram
                                                      .prepDays !=
                                                  null) &&
                                              (data[index]
                                                      .userDetails
                                                      .patient
                                                      .user
                                                      .userProgram
                                                      .ppCurrentDay !=
                                                  null)
                                          ? Text(
                                              "Preparatory Plan Completed by user",
                                              style: TextStyle(
                                                  fontFamily: "GothamMedium",
                                                  color: gSecondaryColor,
                                                  fontSize: 8.sp),
                                            )
                                          : const SizedBox(),
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
                                //
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
                                //               Navigator.of(context).push(
                                //                 MaterialPageRoute(
                                //                   builder: (ct) =>
                                //                       const DayPlanDetails(),
                                //                 ),
                                //               );
                                //             },
                                //             child: Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Text(
                                //                   "Meal Plan",
                                //                   style: TextStyle(
                                //                       fontFamily: "GothamBook",
                                //                       color: gTextColor,
                                //                       fontSize: 8.sp),
                                //                 ),
                                //                 Image(
                                //                   image: const AssetImage(
                                //                       "assets/images/Group 3848.png"),
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

  saveUserId(String patientId, String teamPatientId, String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("patient_id", patientId);
    preferences.setString("team_patient_id", teamPatientId);
    preferences.setString("user_id", userId);
  }

  String buildStatusText(String status) {
    if (status == "report_upload") {
      return "MR Upload";
    } else if (status == "check_user_reports") {
      return "Check User Reports";
    } else if (status == "meal_plan_completed") {
      return "Meal Plan Completed";
    } else if (status == "shipping_paused") {
      return "Shipping Paused";
    } else if (status == "shipping_packed") {
      return "Shipping Packed";
    } else if (status == "shipping_approved") {
      return "Shipping Approved";
    } else if (status == "shipping_delivered") {
      return "Shipping Delivered";
    }
    return statusText;
  }
}
