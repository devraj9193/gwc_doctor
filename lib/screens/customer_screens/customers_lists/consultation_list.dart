import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../controller/consultation_controller.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../consultation_screen/customer_details_screen.dart';

class ConsultationList extends StatefulWidget {
  const ConsultationList({Key? key}) : super(key: key);

  @override
  State<ConsultationList> createState() => _ConsultationListState();
}

class _ConsultationListState extends State<ConsultationList> {
  String statusText = "";
  ConsultationController consultationController =
      Get.put(ConsultationController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: consultationController.fetchAppointmentList(),
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
                  if (data.length != 0)
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      // padding: EdgeInsets.symmetric(horizontal: 3.w),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 3.h,
                                  backgroundImage: NetworkImage(data[index]
                                      .teamPatients
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
                                            .teamPatients
                                            .patient
                                            .user
                                            .name
                                            .toString(),
                                        style: AllListText().headingText(),
                                      ),
                                      Text(
                                        "${data[index].teamPatients.patient.user.age.toString()} ${data[index].teamPatients.patient.user.gender.toString()}",
                                        style: AllListText().subHeadingText(),
                                      ),
                                      Text(
                                        "${DateFormat('dd MMM yyyy').format(DateTime.parse((data[index].date.toString()))).toString()} / ${getTime(data[index].slotStartTime.toString(), data[index].date.toString())}",
                                        style: AllListText().otherText(),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Status : ",
                                            style: AllListText().otherText(),
                                          ),
                                          Text(
                                            buildStatusText(
                                                data[index].status.toString()),
                                            style:
                                                AllListText().subHeadingText(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    saveUserId(
                                        data[index]
                                            .teamPatients
                                            .patientId
                                            .toString(),
                                        data[index].teamPatientId.toString());
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ct) => CustomerDetailsScreen(
                                          userName: data[index]
                                                  .teamPatients
                                                  .patient
                                                  .user
                                                  .name ??
                                              '',
                                          age:
                                              "${data[index].teamPatients.patient.user.age ?? ""} ${data[index].teamPatients.patient.user.gender ?? ""}",
                                          appointmentDetails:
                                              "${DateFormat('dd MMM yyyy').format(DateTime.parse((data[index].date.toString()))).toString() ?? ""} / ${getTime(data[index].slotStartTime.toString(), data[index].date.toString()) ?? ""}",
                                          status: buildStatusText(
                                              data[index].status),
                                        ),
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/noun-view-1041859.svg"),
                                ),
                                SizedBox(width: 2.w),
                              ],
                            ),
                            Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(vertical: 1.5.h),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ],
                        );
                      }),
                    )
                  else
                    buildNoData(),
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

  getTime(String time, String date) {
    print("isReschedule" + time);
    if (time != null) {
      var splited = time.split(':');
      print("splited:$splited");
      String hour = splited[0];
      String minute = splited[1];
      DateTime timing = DateTime.parse("$date $time");
      String amPm = 'AM';
      if (timing.hour >= 12) {
        amPm = 'PM';
      }
      int second = int.parse(splited[2]);
      return '$hour:$minute $amPm';
    }
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
