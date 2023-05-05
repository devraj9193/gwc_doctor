import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/all_customer_meal_active_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../active_screens/active_customer_details.dart';

class AllCustomersActiveList extends StatefulWidget {
  const AllCustomersActiveList({Key? key}) : super(key: key);

  @override
  State<AllCustomersActiveList> createState() => _AllCustomersActiveListState();
}

class _AllCustomersActiveListState extends State<AllCustomersActiveList> {
  String statusText = "";
  AllCustomerMealActiveListController allCustomerMealActiveListController =
      Get.put(AllCustomerMealActiveListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: allCustomerMealActiveListController.fetchActiveList(),
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
                              builder: (ct) => ActiveCustomerDetails(
                                userName:
                                    data[index].userDetails.patient.user.name ??
                                        "",
                                age:
                                    "${data[index].userDetails.patient.user.age ?? ""} ${data[index].userDetails.patient.user.gender ?? ""}",
                                appointmentDetails:
                                    "${data[index].userDetails.appointmentDate ?? ""} / ${data[index].userDetails.appointmentTime ?? ""}",
                                status: buildStatusText(
                                    data[index].userDetails.status),
                                startDate:
                                    data[index].userProgramStartDate ?? "",
                                presentDay: data[index].userPresentDay ?? '',
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
                                transitionDays: '',
                                prepDays: '',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 3.h,
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
                                        style: AllListText().headingText(),
                                      ),
                      
                                      Text(
                                        "${data[index].userDetails.patient.user.age.toString()} ${data[index].userDetails.patient.user.gender.toString()}",
                                        style: AllListText().subHeadingText(),
                                      ),
                      
                                      Text(
                                        "${data[index].userDetails.appointmentDate.toString()} / ${data[index].userDetails.appointmentTime.toString()}",
                                        style: AllListText().otherText(),
                                      ),
                      
                                      Row(
                                        children: [
                                          Text(
                                            "Status : ",
                                            style: AllListText().otherText(),
                                          ),
                                          Text(
                                            buildStatusText(data[index]
                                                .userDetails
                                                .status
                                                .toString()),
                                            style:
                                                AllListText().subHeadingText(),
                                          ),
                                        ],
                                      ),
                      
                                      Row(
                                        children: [
                                          Text(
                                            "Associated Doctor : ",
                                            style: AllListText().otherText(),
                                          ),
                                          Text(
                                            data[index]
                                                .userDetails
                                                .team
                                                .teamMember[0]
                                                .user
                                                .fname
                                                .toString(),
                                            style:
                                                AllListText().subHeadingText(),
                                          ),
                                        ],
                                      ),
                      
                                      Row(
                                        children: [
                                          Text(
                                            "Start Date : ",
                                            style: AllListText().otherText(),
                                          ),
                                          Text(
                                            data[index]
                                                .userProgramStartDate
                                                .toString(),
                                            style:
                                                AllListText().subHeadingText(),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 0.5.h),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Present Day : ",
                                      //       style: AllListText().otherText(),
                                      //     ),
                                      //     Text(
                                      //       data[index]
                                      //           .userPresentDay
                                      //           .toString(),
                                      //       style:
                                      //           AllListText().subHeadingText(),
                                      //     ),
                                      //   ],
                                      // ),
                      
                                      Row(
                                        children: [
                                          Text(
                                            "Final Diagnosis : ",
                                            style: AllListText().otherText(),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data[index]
                                                  .userFinalDiagnosis
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AllListText()
                                                  .subHeadingText(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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

  saveUserId(String patientId, String teamPatientId, String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("patient_id", patientId);
    preferences.setString("team_patient_id", teamPatientId);
    preferences.setString("user_id", userId);
  }

  String buildStatusText(String status) {
    if (status == "start_program") {
      return "Started Program";
    }
    return statusText;
  }
}
