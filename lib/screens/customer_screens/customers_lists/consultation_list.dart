import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../controller/consultation_controller.dart';
import '../../../utils/constants.dart';
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
                                  radius: 2.h,
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
                                        style: TextStyle(
                                            fontFamily: "GothamMedium",
                                            color: gTextColor,
                                            fontSize: 10.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${data[index].teamPatients.patient.user.age.toString()} ${data[index].teamPatients.patient.user.gender.toString()}",
                                        style: TextStyle(
                                            fontFamily: "GothamMedium",
                                            color: gTextColor,
                                            fontSize: 8.sp),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${data[index].teamPatients.appointmentDate.toString()} / ${data[index].teamPatients.appointmentTime.toString()}",
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
                                            buildStatusText(
                                                data[index].status.toString()),
                                            style: TextStyle(
                                                fontFamily: "GothamMedium",
                                                color: gPrimaryColor,
                                                fontSize: 8.sp),
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
                                              "${data[index].teamPatients.appointmentDate ?? ""} / ${data[index].teamPatients.appointmentTime ?? ""}",
                                          status: buildStatusText(
                                              data[index].status),
                                        ),
                                      ),
                                    );
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
    }
    return statusText;
  }
}
