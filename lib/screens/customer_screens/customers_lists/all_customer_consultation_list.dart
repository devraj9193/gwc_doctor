import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/all_customer_consultation_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../consultation_screen/customer_details_screen.dart';

class AllCustomerConsultationList extends StatefulWidget {
  const AllCustomerConsultationList({Key? key}) : super(key: key);

  @override
  State<AllCustomerConsultationList> createState() => _AllCustomerConsultationListState();
}

class _AllCustomerConsultationListState extends State<AllCustomerConsultationList> {
  String statusText = "";
  AllCustomerConsultationController allCustomerConsultationController =
  Get.put(AllCustomerConsultationController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: allCustomerConsultationController.fetchAppointmentList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return buildNoData();
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return showData(data: data);
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
            //   Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   child: Shimmer.fromColors(
            //     baseColor: Colors.red,
            //     highlightColor: Colors.yellow,
            //     child:showData(),
            //   ),
            // );
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

  Widget showData({data}) {
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
              return Column(
                children: [
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                "${data[index].teamPatients.appointmentDate.toString()} / ${data[index].teamPatients.appointmentTime.toString()}",
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
                                    style: AllListText().subHeadingText(),
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
                                        .teamPatients
                                        .team
                                        .teamMember[0]
                                        .user
                                        .fname
                                        .toString(),
                                    style: AllListText().subHeadingText(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              );
            }),
          ),
      ],
    );
  }
}
