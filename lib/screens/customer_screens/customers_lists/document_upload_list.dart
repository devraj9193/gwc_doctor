import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/consultation_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../consultation_screen/customer_details_screen.dart';

class DocumentUploadList extends StatefulWidget {
  const DocumentUploadList({Key? key}) : super(key: key);

  @override
  State<DocumentUploadList> createState() => _DocumentUploadListState();
}

class _DocumentUploadListState extends State<DocumentUploadList> {
  String statusText = "";
  ConsultationController consultationController =
      Get.put(ConsultationController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: consultationController.fetchDocumentUploadList(),
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
                  data.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          //  padding: EdgeInsets.symmetric(horizontal: 3.w),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                saveUserId(data[index].patientId.toString(),
                                    data[index].id.toString());
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ct) => CustomerDetailsScreen(
                                      userName:
                                          data[index].patient.user.name ?? '',
                                      age:
                                          "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                      appointmentDetails:
                                          "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                                      status:
                                          buildStatusText(data[index].status),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 3.h,
                                        backgroundImage: NetworkImage(
                                            data[index]
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
                                              style: AllListText().headingText(),
                                            ),
                            
                                            Text(
                                              "${data[index].patient.user.age.toString()} ${data[index].patient.user.gender.toString()}",
                                              style: AllListText().subHeadingText(),
                                            ),
                            
                                            Text(
                                              "${data[index].appointmentDate.toString()} / ${data[index].appointmentTime.toString()}",
                                              style:AllListText().otherText(),
                                            ),
                            
                                            Row(
                                              children: [
                                                Text(
                                                  "Status : ",
                                                  style: AllListText().otherText(),
                                                ),
                                                Text(
                                                  buildStatusText(data[index]
                                                      .status
                                                      .toString()),
                                                  style: AllListText().subHeadingText(),
                                                ),
                                              ],
                                            ),
                            
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        "Time left for MR Upload : ",
                                                    style: AllListText().otherText(),
                                                  ),
                                                  TextSpan(
                                                    text: data[index]
                                                        .uploadTime
                                                        .toString(),
                                                    style: AllListText().subHeadingText(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Icon(
                                      //   Icons.more_vert,
                                      //   color: gGreyColor.withOpacity(0.5),
                                      // ),
                                      // PopupMenuButton(
                                      //   offset: const Offset(0, 30),
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(5)),
                                      //   itemBuilder: (context) => [
                                      //     PopupMenuItem(
                                      //       child: Column(
                                      //         crossAxisAlignment: CrossAxisAlignment.start,
                                      //         children: [
                                      //           SizedBox(height: 1.h),
                                      //           GestureDetector(
                                      //             onTap: () {},
                                      //             child: Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment.spaceBetween,
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
                                      //             margin: EdgeInsets.symmetric(vertical: 1.h),
                                      //             height: 1,
                                      //             color: gGreyColor.withOpacity(0.3),
                                      //           ),
                                      //           GestureDetector(
                                      //             onTap: () {
                                      //               Navigator.of(context).push(
                                      //                 MaterialPageRoute(
                                      //                   builder: (ct) =>
                                      //                       const MessageScreen(),
                                      //                 ),
                                      //               );
                                      //             },
                                      //             child: Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment.spaceBetween,
                                      //               children: [
                                      //                 Text(
                                      //                   "Reports",
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
                                    margin:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      : buildNoData(),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  saveUserId(String patientId, String teamPatientId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("patient_id", patientId);
    preferences.setString("team_patient_id", teamPatientId);
  }

  String buildStatusText(String status) {
    print("status status: $status");

    if (status == "consultation_done") {
      return "Consultation Done";
    } else if (status == "consultation_accepted") {
      return "Consultation Accepted";
    } else if (status == "consultation_rejected") {
      return "Consultation Rejected";
    } else if (status == "consultation_waiting") {
      return "Consultation Waiting";
    } else if (status == "pending") {
      return "Consultation Pending";
    } else if (status == "wait") {
      return "Requested for Reports";
    } else if (status == "accepted") {
      return "Consultation Accepted";
    } else if (status == "rejected") {
      return "Consultation Rejected";
    } else if (status == "evaluation_done") {
      return "Evaluation Done";
    } else if (status == "declined") {
      return "Declined";
    } else if (status == "check_user_reports") {
      return "Check User Reports";
    }
    return statusText;
  }
}
