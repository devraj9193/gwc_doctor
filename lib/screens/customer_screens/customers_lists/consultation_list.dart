import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../model/customers_list_models/consultation_list_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../../services/customer_status_service/customer_status_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../nutri_delight_screens/nutri_delight_screen.dart';

class ConsultationList extends StatefulWidget {
  const ConsultationList({Key? key}) : super(key: key);

  @override
  State<ConsultationList> createState() => _ConsultationListState();
}

class _ConsultationListState extends State<ConsultationList> {
  String statusText = "";
  final searchController = TextEditingController();

  bool showProgress = false;
  ConsultationModel? consultationModel;
  List<Appointment> searchResults = [];
  final ScrollController _scrollController = ScrollController();

  late final CustomerStatusService customerStatusService =
      CustomerStatusService(customerStatusRepo: repository);

    @override
  void initState() {
    super.initState();
    getClaimedCustomerList();
  }

  getClaimedCustomerList() async {
    setState(() {
      showProgress = true;
    });
    callProgressStateOnBuild(true);
    final result = await customerStatusService.getConsultationPendingService();
    print("result: $result");

    if (result.runtimeType == ConsultationModel) {
      print("Ticket List");
      ConsultationModel model = result as ConsultationModel;

      consultationModel = model;
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
      setState(() {
        showProgress = false;
      });
    }
    setState(() {
      showProgress = false;
    });
    print(result);
  }

  callProgressStateOnBuild(bool value) {
    Future.delayed(Duration.zero).whenComplete(() {
      setState(() {
        showProgress = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment> consultationList =
        consultationModel?.appointmentList ?? [];

    return (showProgress)
        ? Center(
            child: buildCircularIndicator(),
          )
        : consultationList.isEmpty
            ? buildNoData()
            : Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: searchBarTitle,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (searchIcon.icon == Icons.search) {
                                searchIcon = Icon(
                                  Icons.close,
                                  color: gBlackColor,
                                  size: 2.5.h,
                                );
                                searchBarTitle = buildSearchWidget();
                              } else {
                                searchIcon = Icon(
                                  Icons.search,
                                  color: gBlackColor,
                                  size: 2.5.h,
                                );
                                searchBarTitle = const Text('');
                                // filteredNames = names;
                                searchController.clear();
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: gWhiteColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 8,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: searchIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: searchController.text.isEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: consultationList.length,
                              itemBuilder: ((context, index) {
                                var data = consultationList[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        saveUserId(
                                            data.teamPatients?.patientId
                                                    ?.toString() ??
                                                '',
                                            data.teamPatientId.toString());
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ct) => NutriDelightScreen(
                                              userId: int.parse(
                                                  "${data.teamPatients?.patient?.user?.id}"),
                                              tabIndex: 0,
                                              userName: data.teamPatients
                                                      ?.patient?.user?.name ??
                                                  '',

                                              age:
                                                  "${data.teamPatients?.patient?.user?.age} ${data.teamPatients?.patient?.user?.gender}",
                                              appointmentDetails:
                                                  "${DateFormat('dd MMM yyyy').format(DateTime.parse((data.date.toString()))).toString()} / ${getTime(data.slotStartTime.toString(), data.date.toString()) ?? ""}",
                                              status: buildStatusText(data
                                                      .teamPatients
                                                      ?.patient
                                                      ?.status
                                                      .toString() ??
                                                  ''),
                                              iconStatus: data.teamPatients
                                                      ?.patient?.status
                                                      .toString() ??
                                                  '',
                                              updateDate: data.teamPatients
                                                  ?.updateDate
                                                  .toString() ??
                                                  '',
                                              updateTime: data.teamPatients
                                                  ?.updateTime
                                                  .toString() ??
                                                  '',
                                              finalDiagnosis: '',
                                              preparatoryCurrentDay: '',
                                              transitionCurrentDay: '',
                                              isPrepCompleted: '',
                                              isProgramStatus: '',
                                              programDaysStatus: '',
                                            ),
                                            // CustomerDetailsScreen(
                                            //   userName: data[index]
                                            //           .teamPatients
                                            //           .patient
                                            //           .user
                                            //           .name ??
                                            //       '',
                                            //   age:
                                            //       "${data[index].teamPatients.patient.user.age ?? ""} ${data[index].teamPatients.patient.user.gender ?? ""}",
                                            //   appointmentDetails:
                                            //       "${DateFormat('dd MMM yyyy').format(DateTime.parse((data[index].date.toString()))).toString() ?? ""} / ${getTime(data[index].slotStartTime.toString(), data[index].date.toString()) ?? ""}",
                                            //   status:
                                            //       buildStatusText(data[index].status),
                                            // ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 3.h,
                                            backgroundImage: NetworkImage(
                                                "${data.teamPatients?.patient?.user?.profile.toString()}"),
                                          ),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.teamPatients?.patient
                                                          ?.user?.name ??
                                                      '',
                                                  style: AllListText()
                                                      .headingText(),
                                                ),
                                                Text(
                                                  "${data.teamPatients?.patient?.user?.age} ${data.teamPatients?.patient?.user?.gender}",
                                                  style: AllListText()
                                                      .subHeadingText(),
                                                ),
                                                Text(
                                                  "${DateFormat('dd MMM yyyy').format(DateTime.parse((data.date.toString()))).toString()} / ${getTime(data.slotStartTime.toString(), data.date.toString()) ?? ""}",
                                                  style:
                                                      AllListText().otherText(),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Status : ",
                                                      style: AllListText()
                                                          .otherText(),
                                                    ),
                                                    Text(
                                                      buildStatusText(data
                                                              .teamPatients
                                                              ?.patient
                                                              ?.status
                                                              .toString() ??
                                                          ''),
                                                      style: AllListText()
                                                          .subHeadingText(),
                                                    ),
                                                    SizedBox(width: 1.w),
                                                    buildIconWidget(data
                                                            .teamPatients
                                                            ?.patient
                                                            ?.status
                                                            .toString() ??
                                                        ''),
                                                  ],
                                                ),
                                                buildUpdatedTime(
                                                    data.teamPatients?.patient
                                                            ?.status
                                                            .toString() ??
                                                        '',
                                                    data.teamPatients
                                                            ?.updateDate
                                                            .toString() ??
                                                        '',
                                                    data.teamPatients
                                                            ?.updateTime
                                                            .toString() ??
                                                        ''),
                                              ],
                                            ),
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     saveUserId(
                                          //         data.teamPatients?.patientId
                                          //                 ?.toString() ??
                                          //             '',
                                          //         data.teamPatientId
                                          //             .toString());
                                          //     Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //         builder: (ct) =>
                                          //             NutriDelightScreen(
                                          //           userId: int.parse(
                                          //               "${data.teamPatients?.patient?.user?.id}"),
                                          //           tabIndex: 0,
                                          //           userName: data
                                          //                   .teamPatients
                                          //                   ?.patient
                                          //                   ?.user
                                          //                   ?.name ??
                                          //               '',
                                          //           age:
                                          //               "${data.teamPatients?.patient?.user?.age} ${data.teamPatients?.patient?.user?.gender}",
                                          //           appointmentDetails:
                                          //               "${DateFormat('dd MMM yyyy').format(DateTime.parse((data.date.toString()))).toString()} / ${getTime(data.slotStartTime.toString(), data.date.toString()) ?? ""}",
                                          //           status: buildStatusText(data
                                          //                   .teamPatients
                                          //                   ?.patient
                                          //                   ?.status
                                          //                   .toString() ??
                                          //               ''),
                                          //           finalDiagnosis: '',
                                          //           preparatoryCurrentDay: '',
                                          //           transitionCurrentDay: '',
                                          //           isPrepCompleted: '',
                                          //           isProgramStatus: '',
                                          //           programDaysStatus: '',
                                          //         ),
                                          //         // CustomerDetailsScreen(
                                          //         //   userName: data[index]
                                          //         //           .teamPatients
                                          //         //           .patient
                                          //         //           .user
                                          //         //           .name ??
                                          //         //       '',
                                          //         //   age:
                                          //         //       "${data[index].teamPatients.patient.user.age ?? ""} ${data[index].teamPatients.patient.user.gender ?? ""}",
                                          //         //   appointmentDetails:
                                          //         //       "${DateFormat('dd MMM yyyy').format(DateTime.parse((data[index].date.toString()))).toString() ?? ""} / ${getTime(data[index].slotStartTime.toString(), data[index].date.toString()) ?? ""}",
                                          //         //   status:
                                          //         //       buildStatusText(data[index].status),
                                          //         // ),
                                          //       ),
                                          //     );
                                          //   },
                                          //   child: SvgPicture.asset(
                                          //       "assets/images/noun-view-1041859.svg"),
                                          // ),
                                          // SizedBox(width: 2.w),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.5.h),
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                  ],
                                );
                              }),
                            )
                          : buildSearchList(),
                    ),
                  ),
                ],
              );
  }

  buildUpdatedTime(String status, String updateDate, String updateTime) {
    DateFormat dateFormat = DateFormat("dd MMM yyyy HH:mm");

   DateTime dateTime = dateFormat.parse("$updateDate $updateTime");

    DateTime? auction = dateTime.add(const Duration(days: 1));

     DateTime? now = DateTime.now();

     print("auction : $auction");

    print("dateTime : $dateTime");

    Duration? difference = auction.difference(now);

    print("difference : $difference");

    if (status == "consultation_done" ||
        status == "check_user_reports" ||
        status == "consultation_accepted" ||
        status == "accepted") {
      return Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Time Pending : ",
            style: AllListText().otherText(),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "$updateDate/$updateTime",
              //   style: AllListText().subHeadingText(),
              // ),
             if (difference.inHours > 00) Text(
                '${difference.inHours}hrs ${difference.inMinutes.remainder(60)}mins pending',
                style: AllListText().deliveryDateText(),
              ) else Text(
               '00hrs 00mins pending',
               style: AllListText().deliveryDateText(),
             ),
            ],
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: gBlackColor,
    size: 2.5.h,
  );
  Widget searchBarTitle = const Text('');

  Widget buildSearchWidget() {
    return StatefulBuilder(builder: (_, setstate) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border:
              Border.all(color: lightTextColor.withOpacity(0.3), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: lightTextColor.withOpacity(0.3),
              blurRadius: 2,
            ),
          ],
        ),
        //padding: EdgeInsets.symmetric(horizontal: 2.w),
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: searchController,
          cursorColor: newBlackColor,
          cursorHeight: 2.h,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: newBlackColor,
              size: 2.5.h,
            ),
            hintText: "Search...",
            suffixIcon: searchController.text.isNotEmpty
                ? GestureDetector(
                    child: Icon(Icons.close_outlined,
                        size: 2.h, color: newBlackColor),
                    onTap: () {
                      searchController.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : null,
            hintStyle: LoginScreen().hintTextField(),
            border: InputBorder.none,
          ),
          style: LoginScreen().mainTextField(),
          onChanged: (value) {
            onSearchTextChanged(value);
          },
        ),
      );
    });
  }

  onSearchTextChanged(String text) async {
    searchResults.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    consultationModel?.appointmentList?.forEach((userDetail) {
      if (userDetail.teamPatients!.patient!.user!.name!
          .toLowerCase()
          .contains(text.toLowerCase())) {
        searchResults.add(userDetail);
      }
    });
    print("searchResults : $searchResults");
    setState(() {});
  }

  buildSearchList() {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchResults.length,
      itemBuilder: ((context, index) {
        var data = searchResults[index];
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                saveUserId(data.teamPatients?.patientId?.toString() ?? '',
                    data.teamPatientId.toString());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => NutriDelightScreen(
                      userId:
                          int.parse("${data.teamPatients?.patient?.user?.id}"),
                      tabIndex: 0,
                      userName: data.teamPatients?.patient?.user?.name ?? '',
                      age:
                          "${data.teamPatients?.patient?.user?.age} ${data.teamPatients?.patient?.user?.gender}",
                      appointmentDetails:
                          "${DateFormat('dd MMM yyyy').format(DateTime.parse((data.date.toString()))).toString()} / ${getTime(data.slotStartTime.toString(), data.date.toString()) ?? ""}",
                      status: buildStatusText(
                          data.teamPatients?.patient?.status.toString() ?? ''),
                      finalDiagnosis: '',
                      preparatoryCurrentDay: '',
                      transitionCurrentDay: '',
                      isPrepCompleted: '',
                      isProgramStatus: '',
                      programDaysStatus: '',
                      updateDate: data.teamPatients
                          ?.updateDate
                          .toString() ??
                          '',
                      updateTime: data.teamPatients
                          ?.updateTime
                          .toString() ??
                          '',
                    ),
                    // CustomerDetailsScreen(
                    //   userName: data[index]
                    //           .teamPatients
                    //           .patient
                    //           .user
                    //           .name ??
                    //       '',
                    //   age:
                    //       "${data[index].teamPatients.patient.user.age ?? ""} ${data[index].teamPatients.patient.user.gender ?? ""}",
                    //   appointmentDetails:
                    //       "${DateFormat('dd MMM yyyy').format(DateTime.parse((data[index].date.toString()))).toString() ?? ""} / ${getTime(data[index].slotStartTime.toString(), data[index].date.toString()) ?? ""}",
                    //   status:
                    //       buildStatusText(data[index].status),
                    // ),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundImage: NetworkImage(
                        "${data.teamPatients?.patient?.user?.profile.toString()}"),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.teamPatients?.patient?.user?.name ?? '',
                          style: AllListText().headingText(),
                        ),
                        Text(
                          "${data.teamPatients?.patient?.user?.age} ${data.teamPatients?.patient?.user?.gender}",
                          style: AllListText().subHeadingText(),
                        ),
                        Text(
                          "${DateFormat('dd MMM yyyy').format(DateTime.parse((data.date.toString()))).toString()} / ${getTime(data.slotStartTime.toString(), data.date.toString()) ?? ""}",
                          style: AllListText().otherText(),
                        ),
                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style: AllListText().otherText(),
                            ),
                            Text(
                              buildStatusText(data.teamPatients?.patient?.status
                                      .toString() ??
                                  ''),
                              style: AllListText().subHeadingText(),
                            ),
                          ],
                        ),
                        buildUpdatedTime(
                            data.teamPatients?.patient
                                ?.status
                                .toString() ??
                                '',
                            data.teamPatients
                                ?.updateDate
                                .toString() ??
                                '',
                            data.teamPatients
                                ?.updateTime
                                .toString() ??
                                ''),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      saveUserId(data.teamPatients?.patientId?.toString() ?? '',
                          data.teamPatientId.toString());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ct) => NutriDelightScreen(
                            userId: int.parse(
                                "${data.teamPatients?.patient?.user?.id}"),
                            tabIndex: 0,
                            userName:
                                data.teamPatients?.patient?.user?.name ?? '',
                            age:
                                "${data.teamPatients?.patient?.user?.age} ${data.teamPatients?.patient?.user?.gender}",
                            appointmentDetails:
                                "${DateFormat('dd MMM yyyy').format(DateTime.parse((data.date.toString()))).toString()} / ${getTime(data.slotStartTime.toString(), data.date.toString()) ?? ""}",
                            status: buildStatusText(
                                data.teamPatients?.patient?.status.toString() ??
                                    ''),
                            finalDiagnosis: '',
                            preparatoryCurrentDay: '',
                            transitionCurrentDay: '',
                            isPrepCompleted: '',
                            isProgramStatus: '',
                            programDaysStatus: '',
                            updateDate: data.teamPatients
                                ?.updateDate
                                .toString() ??
                                '',
                            updateTime: data.teamPatients
                                ?.updateTime
                                .toString() ??
                                '',
                          ),
                          // CustomerDetailsScreen(
                          //   userName: data[index]
                          //           .teamPatients
                          //           .patient
                          //           .user
                          //           .name ??
                          //       '',
                          //   age:
                          //       "${data[index].teamPatients.patient.user.age ?? ""} ${data[index].teamPatients.patient.user.gender ?? ""}",
                          //   appointmentDetails:
                          //       "${DateFormat('dd MMM yyyy').format(DateTime.parse((data[index].date.toString()))).toString() ?? ""} / ${getTime(data[index].slotStartTime.toString(), data[index].date.toString()) ?? ""}",
                          //   status:
                          //       buildStatusText(data[index].status),
                          // ),
                        ),
                      );
                    },
                    child:
                        SvgPicture.asset("assets/images/noun-view-1041859.svg"),
                  ),
                  SizedBox(width: 2.w),
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
    );
  }

  final CustomerStatusRepo repository = CustomerStatusRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

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
      return "Accepted (MR & CS Pending)";
    } else if (status == "consultation_rejected") {
      return "Consultation Rejected";
    } else if (status == "consultation_waiting") {
      return "Waiting for Reports";
    } else if (status == "pending") {
      return "Pending";
    } else if (status == "wait") {
      return "Requested for Reports";
    } else if (status == "accepted") {
      return "Accepted (MR & CS Pending)";
    } else if (status == "rejected") {
      return "Consultation Rejected";
    } else if (status == "evaluation_done") {
      return "Evaluation Done";
    } else if (status == "declined") {
      return "Declined";
    } else if (status == "check_user_reports") {
      return "Check User Reports";
    } else if (status == "appointment_booked") {
      return "Pending";
    }

    return statusText;
  }
}
