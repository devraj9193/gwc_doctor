import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../../model/customers_list_models/meal_active_model.dart';
import '../../../../model/error_model.dart';
import '../../../../repository/api_service.dart';
import '../../../../repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../../../services/customer_status_service/customer_status_service.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/common_screen_widgets.dart';
import '../../../../widgets/widgets.dart';
import '../../../nutri_delight_screens/nutri_delight_screen.dart';

class AllCustomersActiveList extends StatefulWidget {
  const AllCustomersActiveList({Key? key}) : super(key: key);

  @override
  State<AllCustomersActiveList> createState() => _AllCustomersActiveListState();
}

class _AllCustomersActiveListState extends State<AllCustomersActiveList> {
  String statusText = "";
  String programStatus = "";
  String programDayStatus = "";
  final searchController = TextEditingController();

  bool showProgress = false;
  MealActiveModel? mealActiveModel;
  List<ActiveDetail> searchResults = [];
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
    final result = await customerStatusService.getAllMealActiveService();
    print("result: $result");

    if (result.runtimeType == MealActiveModel) {
      print("Ticket List");
      MealActiveModel model = result as MealActiveModel;

      mealActiveModel = model;
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
    List<ActiveDetail> activeList = mealActiveModel?.activeDetails ?? [];

    return (showProgress)
        ? Center(
      child: buildCircularIndicator(),
    )
        : activeList.isEmpty
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
              itemCount: activeList.length,
              itemBuilder: ((context, index) {
                var data = activeList[index];
                return GestureDetector(
                  onTap: () {
                    saveUserId(
                        data.userDetails?.patientId.toString() ?? '',
                        data.userDetails?.id.toString() ??'',
                        data.userDetails?.patient?.user?.id.toString() ?? '');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ct) => NutriDelightScreen(
                          tabIndex: 4,
                          userId : int.parse("${data.userDetails?.patient?.user?.id}"),
                          userName: data.userDetails?.patient?.user?.name ?? '',
                          age:
                          "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                          appointmentDetails: buildTimeDate(
                              data.userDetails?.appointments?[0].date.toString() ?? '',
                              data.userDetails?.appointments?[0].slotStartTime.toString() ?? ''),
                          status: buildStatusText(
                              data.userDetails?.patient?.status ?? ''),
                          finalDiagnosis:
                          data.userFinalDiagnosis ?? '',
                          preparatoryCurrentDay: "",
                          transitionCurrentDay: "",
                          isPrepCompleted: data.userDetails?.patient?.user?.userProgram?.isPreparatoryCompleted.toString() ?? '',
                          isProgramStatus: getProgramStatus(
                            data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                          ), programDaysStatus: getProgramDayStatus(
                          getProgramStatus(
                            data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                          ),
                          data.userDetails?.patient?.user?.userProgram?.preparatoryTotalDays.toString() ?? '',
                          data.userDetails?.patient?.user?.userProgram?.preparatoryPresentDay.toString() ?? '',
                          data.userDetails?.patient?.user?.userProgram?.detoxTotalDays.toString() ?? '',
                          data.userDetails?.patient?.user?.userProgram?.detoxPresentDay.toString() ?? '',
                          data.userDetails?.patient?.user?.userProgram?.healingTotalDays.toString() ??'',
                          data.userDetails?.patient?.user?.userProgram?.healingPresentDay.toString() ?? '',
                          data.userDetails?.patient?.user?.userProgram?.nourishTotalDays.toString() ?? '',
                          data.userDetails?.patient?.user?.userProgram?.nourishPresentDay.toString() ?? '',
                        ), updateTime: '', updateDate: '',
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
                                data.userDetails?.patient?.user?.profile.toString() ?? ''),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.userDetails?.patient?.user?.name ?? '',
                                  style:
                                  AllListText().headingText(),
                                ),
                                Text(
                                  "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                                  style: AllListText()
                                      .subHeadingText(),
                                ),
                                Text(
                                  buildTimeDate(
                                      data.userDetails?.appointments?[0].date.toString() ?? '',
                                      data.userDetails?.appointments?[0].slotStartTime.toString() ?? ''),
                                  style: AllListText().otherText(),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Status : ",
                                      style:
                                      AllListText().otherText(),
                                    ),
                                    Text(
                                      buildStatusText(
                                          data.userDetails?.patient?.status ?? ''),
                                      style: AllListText()
                                          .subHeadingText(),
                                    ),
                                  ],
                                ),
                                data.userProgramStartDate
                                    .toString() ==
                                    "null"
                                    ? const SizedBox()
                                    : Row(
                                  children: [
                                    Text(
                                      "Start Date : ",
                                      style: AllListText()
                                          .otherText(),
                                    ),
                                    Text(
                                      data.userProgramStartDate
                                          .toString(),
                                      style: AllListText()
                                          .subHeadingText(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Final Diagnosis : ",
                                      style:
                                      AllListText().otherText(),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data.userFinalDiagnosis
                                            .toString(),
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: AllListText()
                                            .subHeadingText(),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  getProgramStatus(
                                    data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                                  ),
                                  style: AllListText()
                                      .getProgramStatus(),
                                ),
                                Text(
                                  getProgramDayStatus(
                                    getProgramStatus(
                                      data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                                      data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                                      data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                                      data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                                      data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                                    ),
                                    data.userDetails?.patient?.user?.userProgram?.preparatoryTotalDays.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.preparatoryPresentDay.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.detoxTotalDays.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.detoxPresentDay.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.healingTotalDays.toString() ??'',
                                    data.userDetails?.patient?.user?.userProgram?.healingPresentDay.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.nourishTotalDays.toString() ?? '',
                                    data.userDetails?.patient?.user?.userProgram?.nourishPresentDay.toString() ?? '',
                                  ),
                                  style: AllListText()
                                      .getProgramStatus(),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "See more",
                            style: AllListText().otherText(),
                          ),
                          SizedBox(width: 2.w),
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
                : buildSearchList(),
          ),
        ),
      ],
    );
    // return SingleChildScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   child: FutureBuilder(
    //       future: allCustomerMealActiveListController.fetchActiveList(),
    //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //         if (snapshot.hasError) {
    //           return buildNoData();
    //         } else if (snapshot.hasData) {
    //           var data = snapshot.data;
    //           return Column(
    //             children: [
    //               Container(
    //                 height: 1,
    //                 color: Colors.grey.withOpacity(0.3),
    //               ),
    //               SizedBox(height: 2.h),
    //               ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 // padding: EdgeInsets.symmetric(horizontal: 3.w),
    //                 physics: const ScrollPhysics(),
    //                 shrinkWrap: true,
    //                 itemCount: data.length,
    //                 itemBuilder: ((context, index) {
    //                   return GestureDetector(
    //                     onTap: () {
    //                       saveUserId(
    //                           data[index].userDetails.patientId.toString(),
    //                           data[index].userDetails.id.toString(),
    //                           data[index]
    //                               .userDetails
    //                               .patient
    //                               .user
    //                               .id
    //                               .toString());
    //                       Navigator.of(context).push(
    //                         MaterialPageRoute(
    //                           builder: (ct) => NutriDelightScreen(
    //                             tabIndex: 4,
    //                             userId : data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .id,
    //                             userName: data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .name ??
    //                                 '',
    //                             age:
    //                             "${data[index].userDetails.patient.user.age ?? ""} ${data[index].userDetails.patient.user.gender ?? ""}",
    //                             appointmentDetails: buildTimeDate(
    //                                 data[index]
    //                                     .userDetails
    //                                     .appointments[0]
    //                                     .date
    //                                     .toString(),
    //                                 data[index]
    //                                     .userDetails
    //                                     .appointments[0]
    //                                     .slotStartTime
    //                                     .toString()),
    //                             status: buildStatusText(
    //                                 data[index].userDetails.status),
    //                             finalDiagnosis:
    //                             data[index].userFinalDiagnosis ?? '',
    //                             preparatoryCurrentDay: "",
    //                             transitionCurrentDay: "",
    //                             isPrepCompleted: data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .isPreparatoryCompleted
    //                                 .toString(),
    //                             isProgramStatus: getProgramStatus(
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .preparatoryProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .detoxProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .healingProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .nourishProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .isNourishCompleted
    //                                   .toString(),
    //                             ), programDaysStatus: getProgramDayStatus(
    //                             getProgramStatus(
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .preparatoryProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .detoxProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .healingProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .nourishProgram
    //                                   .toString(),
    //                               data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .userProgram
    //                                   .isNourishCompleted
    //                                   .toString(),
    //                             ),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .preparatoryTotalDays
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .preparatoryPresentDay
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .detoxTotalDays
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .detoxPresentDay
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .healingTotalDays
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .healingPresentDay
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .nourishTotalDays
    //                                 .toString(),
    //                             data[index]
    //                                 .userDetails
    //                                 .patient
    //                                 .user
    //                                 .userProgram
    //                                 .nourishPresentDay
    //                                 .toString(),
    //                           ),
    //                           ),
    //                           //     ActiveCustomerDetails(
    //                           //   userName:
    //                           //       data[index].userDetails.patient.user.name ??
    //                           //           "",
    //                           //   age:
    //                           //       "${data[index].userDetails.patient.user.age ?? ""} ${data[index].userDetails.patient.user.gender ?? ""}",
    //                           //   appointmentDetails:
    //                           //       "${data[index].userDetails.appointmentDate ?? ""} / ${data[index].userDetails.appointmentTime ?? ""}",
    //                           //   status: buildStatusText(
    //                           //       data[index].userDetails.status),
    //                           //   startDate:
    //                           //       data[index].userProgramStartDate ?? "",
    //                           //   presentDay: data[index].userPresentDay ?? '',
    //                           //   finalDiagnosis:
    //                           //       data[index].userFinalDiagnosis ?? '',
    //                           //   preparatoryCurrentDay: data[index]
    //                           //           .userDetails
    //                           //           .patient
    //                           //           .user
    //                           //           .userProgram
    //                           //           .ppCurrentDay ??
    //                           //       "",
    //                           //   transitionCurrentDay: data[index]
    //                           //           .userDetails
    //                           //           .patient
    //                           //           .user
    //                           //           .userProgram
    //                           //           .tpCurrentDay ??
    //                           //       "",
    //                           //   transitionDays: '',
    //                           //   prepDays: '', isPrepCompleted: data[index]
    //                           //     .userDetails
    //                           //     .patient
    //                           //     .user
    //                           //     .userProgram
    //                           //     .isPrepCompleted,
    //                           // ),
    //                         ),
    //                       );
    //                     },
    //                     child: Column(
    //                       children: [
    //                         Row(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             CircleAvatar(
    //                               radius: 3.h,
    //                               backgroundImage: NetworkImage(data[index]
    //                                   .userDetails
    //                                   .patient
    //                                   .user
    //                                   .profile
    //                                   .toString()),
    //                             ),
    //                             SizedBox(width: 2.w),
    //                             Expanded(
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     data[index]
    //                                         .userDetails
    //                                         .patient
    //                                         .user
    //                                         .name
    //                                         .toString(),
    //                                     style: AllListText().headingText(),
    //                                   ),
    //
    //                                   Text(
    //                                     "${data[index].userDetails.patient.user.age.toString()} ${data[index].userDetails.patient.user.gender.toString()}",
    //                                     style: AllListText().subHeadingText(),
    //                                   ),
    //
    //                                   Text(
    //                                     "${data[index].userDetails.appointmentDate.toString()} / ${data[index].userDetails.appointmentTime.toString()}",
    //                                     style: AllListText().otherText(),
    //                                   ),
    //
    //                                   Row(
    //                                     children: [
    //                                       Text(
    //                                         "Status : ",
    //                                         style: AllListText().otherText(),
    //                                       ),
    //                                       Text(
    //                                         buildStatusText(data[index]
    //                                             .userDetails
    //                                             .status
    //                                             .toString()),
    //                                         style:
    //                                             AllListText().subHeadingText(),
    //                                       ),
    //                                     ],
    //                                   ),
    //
    //                                   Row(
    //                                     children: [
    //                                       Text(
    //                                         "Associated Doctor : ",
    //                                         style: AllListText().otherText(),
    //                                       ),
    //                                       Text(
    //                                         data[index]
    //                                             .userDetails
    //                                             .team
    //                                             .teamMember[0]
    //                                             .user
    //                                             .fname
    //                                             .toString(),
    //                                         style:
    //                                             AllListText().subHeadingText(),
    //                                       ),
    //                                     ],
    //                                   ),
    //
    //                                   Row(
    //                                     children: [
    //                                       Text(
    //                                         "Start Date : ",
    //                                         style: AllListText().otherText(),
    //                                       ),
    //                                       Text(
    //                                         data[index]
    //                                             .userProgramStartDate
    //                                             .toString(),
    //                                         style:
    //                                             AllListText().subHeadingText(),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   // SizedBox(height: 0.5.h),
    //                                   // Row(
    //                                   //   children: [
    //                                   //     Text(
    //                                   //       "Present Day : ",
    //                                   //       style: AllListText().otherText(),
    //                                   //     ),
    //                                   //     Text(
    //                                   //       data[index]
    //                                   //           .userPresentDay
    //                                   //           .toString(),
    //                                   //       style:
    //                                   //           AllListText().subHeadingText(),
    //                                   //     ),
    //                                   //   ],
    //                                   // ),
    //
    //                                   Row(
    //                                     children: [
    //                                       Text(
    //                                         "Final Diagnosis : ",
    //                                         style: AllListText().otherText(),
    //                                       ),
    //                                       Expanded(
    //                                         child: Text(
    //                                           data[index]
    //                                               .userFinalDiagnosis
    //                                               .toString(),
    //                                           maxLines: 1,
    //                                           overflow: TextOverflow.ellipsis,
    //                                           style: AllListText()
    //                                               .subHeadingText(),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   buildPreparatoryStatus(data[index]
    //                                       .userDetails
    //                                       .patient
    //                                       .user
    //                                       .userProgram
    //                                       .isPreparatoryCompleted.toString()),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Container(
    //                           height: 1,
    //                           margin: EdgeInsets.symmetric(vertical: 1.5.h),
    //                           color: Colors.grey.withOpacity(0.3),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 }),
    //               ),
    //             ],
    //           );
    //         }
    //         return Padding(
    //           padding: EdgeInsets.symmetric(vertical: 10.h),
    //           child: buildCircularIndicator(),
    //         );
    //       }),
    // );
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
    mealActiveModel?.activeDetails?.forEach((userDetail) {
      if (userDetail.userDetails!.patient!.user!.name!
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
        return GestureDetector(
          onTap: () {
            saveUserId(
                data.userDetails?.patientId.toString() ?? '',
                data.userDetails?.id.toString() ??'',
                data.userDetails?.patient?.user?.id.toString() ?? '');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ct) => NutriDelightScreen(
                  tabIndex: 4,
                  userId : int.parse("${data.userDetails?.patient?.user?.id}"),
                  userName: data.userDetails?.patient?.user?.name ?? '',
                  age:
                  "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                  appointmentDetails: buildTimeDate(
                      data.userDetails?.appointments?[0].date.toString() ?? '',
                      data.userDetails?.appointments?[0].slotStartTime.toString() ?? ''),
                  status: buildStatusText(
                      data.userDetails?.patient?.status ?? ''),
                  finalDiagnosis:
                  data.userFinalDiagnosis ?? '',
                  preparatoryCurrentDay: "",
                  transitionCurrentDay: "",
                  isPrepCompleted: data.userDetails?.patient?.user?.userProgram?.isPreparatoryCompleted.toString() ?? '',
                  isProgramStatus: getProgramStatus(
                    data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                  ), programDaysStatus: getProgramDayStatus(
                  getProgramStatus(
                    data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                    data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                  ),
                  data.userDetails?.patient?.user?.userProgram?.preparatoryTotalDays.toString() ?? '',
                  data.userDetails?.patient?.user?.userProgram?.preparatoryPresentDay.toString() ?? '',
                  data.userDetails?.patient?.user?.userProgram?.detoxTotalDays.toString() ?? '',
                  data.userDetails?.patient?.user?.userProgram?.detoxPresentDay.toString() ?? '',
                  data.userDetails?.patient?.user?.userProgram?.healingTotalDays.toString() ??'',
                  data.userDetails?.patient?.user?.userProgram?.healingPresentDay.toString() ?? '',
                  data.userDetails?.patient?.user?.userProgram?.nourishTotalDays.toString() ?? '',
                  data.userDetails?.patient?.user?.userProgram?.nourishPresentDay.toString() ?? '',
                ),
                  updateTime: '', updateDate: '',
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
                        data.userDetails?.patient?.user?.profile.toString() ?? ''),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.userDetails?.patient?.user?.name ?? '',
                          style:
                          AllListText().headingText(),
                        ),
                        Text(
                          "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                          style: AllListText()
                              .subHeadingText(),
                        ),
                        Text(
                          buildTimeDate(
                              data.userDetails?.appointments?[0].date.toString() ?? '',
                              data.userDetails?.appointments?[0].slotStartTime.toString() ?? ''),
                          style: AllListText().otherText(),
                        ),
                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style:
                              AllListText().otherText(),
                            ),
                            Text(
                              buildStatusText(
                                  data.userDetails?.patient?.status ?? ''),
                              style: AllListText()
                                  .subHeadingText(),
                            ),
                          ],
                        ),
                        data.userProgramStartDate
                            .toString() ==
                            "null"
                            ? const SizedBox()
                            : Row(
                          children: [
                            Text(
                              "Start Date : ",
                              style: AllListText()
                                  .otherText(),
                            ),
                            Text(
                              data.userProgramStartDate
                                  .toString(),
                              style: AllListText()
                                  .subHeadingText(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Final Diagnosis : ",
                              style:
                              AllListText().otherText(),
                            ),
                            Expanded(
                              child: Text(
                                data.userFinalDiagnosis
                                    .toString(),
                                maxLines: 1,
                                overflow:
                                TextOverflow.ellipsis,
                                style: AllListText()
                                    .subHeadingText(),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          getProgramStatus(
                            data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                          ),
                          style: AllListText()
                              .getProgramStatus(),
                        ),
                        Text(
                          getProgramDayStatus(
                            getProgramStatus(
                              data.userDetails?.patient?.user?.userProgram?.preparatoryProgram.toString() ?? '',
                              data.userDetails?.patient?.user?.userProgram?.detoxProgram.toString() ?? '',
                              data.userDetails?.patient?.user?.userProgram?.healingProgram.toString() ?? '',
                              data.userDetails?.patient?.user?.userProgram?.nourishProgram.toString() ?? '',
                              data.userDetails?.patient?.user?.userProgram?.isNourishCompleted.toString() ?? '',
                            ),
                            data.userDetails?.patient?.user?.userProgram?.preparatoryTotalDays.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.preparatoryPresentDay.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.detoxTotalDays.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.detoxPresentDay.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.healingTotalDays.toString() ??'',
                            data.userDetails?.patient?.user?.userProgram?.healingPresentDay.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.nourishTotalDays.toString() ?? '',
                            data.userDetails?.patient?.user?.userProgram?.nourishPresentDay.toString() ?? '',
                          ),
                          style: AllListText()
                              .getProgramStatus(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "See more",
                    style: AllListText().otherText(),
                  ),
                  SizedBox(width: 2.w),
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
    );
  }

  final CustomerStatusRepo repository = CustomerStatusRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  buildPreparatoryStatus(String isPrepCompleted) {
    return (isPrepCompleted == "1") && (isPrepCompleted != "null")
        ? Text(
      "Preparatory Plan Completed by user",
      style: TextStyle(
          height: 1.3,
          fontFamily: fontMedium,
          color: gSecondaryColor,
          fontSize: fontSize08),
    )
        : const SizedBox();
  }

  String getProgramStatus(String prepProgram, String detoxProgram,
      String healingProgram, String nourishProgram, String nourishCompleted) {
    print("programStatus Prep : $prepProgram == 1");
    print("programStatus Detox : $detoxProgram == 1");
    print("programStatus Healing : $healingProgram == 1");
    print("programStatus Nourish : $nourishProgram == 1");

    if (nourishCompleted == "1" &&
        nourishProgram == "1" &&
        detoxProgram == "1" &&
        prepProgram == "1" &&
        healingProgram == "1") {
      return "Program Completed";
    } else if (nourishProgram == "1" &&
        detoxProgram == "1" &&
        prepProgram == "1" &&
        healingProgram == "1") {
      return "Nourish Program Running";
    } else if (detoxProgram == "1" &&
        prepProgram == "1" &&
        healingProgram == "1") {
      return "Healing Program Running";
    } else if (prepProgram == "1" && detoxProgram == "1") {
      return "Detox Program Running";
    } else if (prepProgram == "1") {
      return "Preparatory Program Running";
    }
    print("programStatus : $programStatus");
    return programStatus;
  }

  String getProgramDayStatus(
      String programStatus,
      String prepTotalDays,
      String prepCurrentDay,
      String detoxTotalDays,
      String detoxCurrentDay,
      String healingTotalDays,
      String healingCurrentDay,
      String nourishTotalDays,
      String nourishCurrentDay,
      ) {
    if(programStatus == "Preparatory Program Running"){
      return "Preparatory days : $prepCurrentDay/$prepTotalDays";
    } else if(programStatus == "Detox Program Running"){
      return "Detox days : $detoxCurrentDay/$detoxTotalDays";
    } else if(programStatus == "Healing Program Running"){
      return "Healing days : $healingCurrentDay/$healingTotalDays";
    }else if(programStatus == "Nourish Program Running"){
      return "Nourish days : $nourishCurrentDay/$nourishTotalDays";
    }
    return programDayStatus;
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
