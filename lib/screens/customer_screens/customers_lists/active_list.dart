import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../model/customers_list_models/meal_active_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../../services/customer_status_service/customer_status_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import '../../nutri_delight_screens/nutri_delight_screen.dart';
import 'package:http/http.dart' as http;

class CustomersActiveList extends StatefulWidget {
  const CustomersActiveList({Key? key}) : super(key: key);

  @override
  State<CustomersActiveList> createState() => _CustomersActiveListState();
}

class _CustomersActiveListState extends State<CustomersActiveList> {
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
    final result = await customerStatusService.getMealActiveService();
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
                                        data.userDetails?.patientId
                                                .toString() ??
                                            '',
                                        data.userDetails?.id.toString() ?? '',
                                        data.userDetails?.patient?.user?.id
                                                .toString() ??
                                            '');
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ct) => NutriDelightScreen(
                                          tabIndex: 4,
                                          userId: int.parse(
                                              "${data.userDetails?.patient?.user?.id}"),
                                          userName: data.userDetails?.patient
                                                  ?.user?.name ??
                                              '',
                                          age:
                                              "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                                          appointmentDetails: buildTimeDate(
                                              data.userDetails?.appointments?[0]
                                                      .date
                                                      .toString() ??
                                                  '',
                                              data.userDetails?.appointments?[0]
                                                      .slotStartTime
                                                      .toString() ??
                                                  ''),
                                          status: buildStatusText(data
                                                  .userDetails
                                                  ?.patient
                                                  ?.status ??
                                              ''),
                                          finalDiagnosis:
                                              data.userFinalDiagnosis ?? '',
                                          preparatoryCurrentDay: "",
                                          transitionCurrentDay: "",
                                          isPrepCompleted: data
                                                  .userDetails
                                                  ?.patient
                                                  ?.user
                                                  ?.userProgram
                                                  ?.isPreparatoryCompleted
                                                  .toString() ??
                                              '',
                                          isProgramStatus: getProgramStatus(
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.preparatoryProgram
                                                    .toString() ??
                                                '',
                                            data.userDetails?.patient?.user
                                                    ?.userProgram?.detoxProgram
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.healingProgram
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.nourishProgram
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.isNourishCompleted
                                                    .toString() ??
                                                '',
                                          ),
                                          programDaysStatus:
                                              getProgramDayStatus(
                                            getProgramStatus(
                                              data
                                                      .userDetails
                                                      ?.patient
                                                      ?.user
                                                      ?.userProgram
                                                      ?.preparatoryProgram
                                                      .toString() ??
                                                  '',
                                              data
                                                      .userDetails
                                                      ?.patient
                                                      ?.user
                                                      ?.userProgram
                                                      ?.detoxProgram
                                                      .toString() ??
                                                  '',
                                              data
                                                      .userDetails
                                                      ?.patient
                                                      ?.user
                                                      ?.userProgram
                                                      ?.healingProgram
                                                      .toString() ??
                                                  '',
                                              data
                                                      .userDetails
                                                      ?.patient
                                                      ?.user
                                                      ?.userProgram
                                                      ?.nourishProgram
                                                      .toString() ??
                                                  '',
                                              data
                                                      .userDetails
                                                      ?.patient
                                                      ?.user
                                                      ?.userProgram
                                                      ?.isNourishCompleted
                                                      .toString() ??
                                                  '',
                                            ),
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.preparatoryTotalDays
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.preparatoryPresentDay
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.detoxTotalDays
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.detoxPresentDay
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.healingTotalDays
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.healingPresentDay
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.nourishTotalDays
                                                    .toString() ??
                                                '',
                                            data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.userProgram
                                                    ?.nourishPresentDay
                                                    .toString() ??
                                                '',
                                          ),
                                          updateTime: '',
                                          updateDate: '',
                                          userProgram: data.userDetails?.patient?.user?.userProgram,
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
                                            backgroundImage: NetworkImage(data
                                                    .userDetails
                                                    ?.patient
                                                    ?.user
                                                    ?.profile
                                                    .toString() ??
                                                ''),
                                          ),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.userDetails?.patient
                                                          ?.user?.name ??
                                                      '',
                                                  style: AllListText()
                                                      .headingText(),
                                                ),
                                                Text(
                                                  "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                                                  style: AllListText()
                                                      .subHeadingText(),
                                                ),
                                                Text(
                                                  buildTimeDate(
                                                      data
                                                              .userDetails
                                                              ?.appointments?[0]
                                                              .date
                                                              .toString() ??
                                                          '',
                                                      data
                                                              .userDetails
                                                              ?.appointments?[0]
                                                              .slotStartTime
                                                              .toString() ??
                                                          ''),
                                                  style:
                                                      AllListText().otherText(),
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
                                                      style: AllListText()
                                                          .otherText(),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        data.userFinalDiagnosis
                                                            .toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AllListText()
                                                            .subHeadingText(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Status : ",
                                                      style: AllListText()
                                                          .otherText(),
                                                    ),
                                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                      Text(
                                                        getProgramStatus(
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.preparatoryProgram
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.detoxProgram
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.healingProgram
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.nourishProgram
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.isNourishCompleted
                                                              .toString() ??
                                                              '',
                                                        ),
                                                        style: AllListText()
                                                            .getProgramStatus(),
                                                      ),
                                                      Text(
                                                        getProgramDayStatus(
                                                          getProgramStatus(
                                                            data
                                                                .userDetails
                                                                ?.patient
                                                                ?.user
                                                                ?.userProgram
                                                                ?.preparatoryProgram
                                                                .toString() ??
                                                                '',
                                                            data
                                                                .userDetails
                                                                ?.patient
                                                                ?.user
                                                                ?.userProgram
                                                                ?.detoxProgram
                                                                .toString() ??
                                                                '',
                                                            data
                                                                .userDetails
                                                                ?.patient
                                                                ?.user
                                                                ?.userProgram
                                                                ?.healingProgram
                                                                .toString() ??
                                                                '',
                                                            data
                                                                .userDetails
                                                                ?.patient
                                                                ?.user
                                                                ?.userProgram
                                                                ?.nourishProgram
                                                                .toString() ??
                                                                '',
                                                            data
                                                                .userDetails
                                                                ?.patient
                                                                ?.user
                                                                ?.userProgram
                                                                ?.isNourishCompleted
                                                                .toString() ??
                                                                '',
                                                          ),
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.preparatoryTotalDays
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.preparatoryPresentDay
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.detoxTotalDays
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.detoxPresentDay
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.healingTotalDays
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.healingPresentDay
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.nourishTotalDays
                                                              .toString() ??
                                                              '',
                                                          data
                                                              .userDetails
                                                              ?.patient
                                                              ?.user
                                                              ?.userProgram
                                                              ?.nourishPresentDay
                                                              .toString() ??
                                                              '',
                                                        ),
                                                        style: AllListText()
                                                            .getProgramStatus(),
                                                      ),
                                                    ],),

                                                    // Text(
                                                    //   buildStatusText(data
                                                    //       .userDetails
                                                    //       ?.patient
                                                    //       ?.status ??
                                                    //       ''),
                                                    //   style: AllListText()
                                                    //       .subHeadingText(),
                                                    // ),
                                                    buildActiveIconWidget(
                                                      data
                                                          .userDetails
                                                          ?.patient
                                                          ?.user
                                                          ?.userProgram
                                                          ?.isPreparatoryCompleted
                                                          .toString() ??
                                                          '',
                                                      data
                                                          .userDetails
                                                          ?.patient
                                                          ?.user
                                                          ?.userProgram
                                                          ?.detoxProgram
                                                          .toString() ??
                                                          '',
                                                      data
                                                          .userDetails
                                                          ?.patient
                                                          ?.user
                                                          ?.userProgram
                                                          ?.isDetoxCompleted
                                                          .toString() ??
                                                          '',
                                                      data
                                                          .userDetails
                                                          ?.patient
                                                          ?.user
                                                          ?.userProgram
                                                          ?.healingProgram
                                                          .toString() ??
                                                          '',
                                                      data
                                                          .userDetails
                                                          ?.patient
                                                          ?.user
                                                          ?.userProgram
                                                          ?.isHealingCompleted
                                                          .toString() ??
                                                          '',
                                                      data
                                                          .userDetails
                                                          ?.patient
                                                          ?.user
                                                          ?.userProgram
                                                          ?.nourishProgram
                                                          .toString() ??
                                                          '',
                                                    ),
                                                  ],
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
                                        margin: EdgeInsets.symmetric(
                                            vertical: 1.5.h),
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
                data.userDetails?.id.toString() ?? '',
                data.userDetails?.patient?.user?.id.toString() ?? '');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ct) => NutriDelightScreen(
                  tabIndex: 4,
                  userId: int.parse("${data.userDetails?.patient?.user?.id}"),
                  userName: data.userDetails?.patient?.user?.name ?? '',
                  age:
                      "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                  appointmentDetails: buildTimeDate(
                      data.userDetails?.appointments?[0].date.toString() ?? '',
                      data.userDetails?.appointments?[0].slotStartTime
                              .toString() ??
                          ''),
                  status:
                      buildStatusText(data.userDetails?.patient?.status ?? ''),
                  finalDiagnosis: data.userFinalDiagnosis ?? '',
                  preparatoryCurrentDay: "",
                  transitionCurrentDay: "",
                  isPrepCompleted: data.userDetails?.patient?.user?.userProgram
                          ?.isPreparatoryCompleted
                          .toString() ??
                      '',
                  isProgramStatus: getProgramStatus(
                    data.userDetails?.patient?.user?.userProgram
                            ?.preparatoryProgram
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram?.detoxProgram
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram?.healingProgram
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram?.nourishProgram
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.isNourishCompleted
                            .toString() ??
                        '',
                  ),
                  programDaysStatus: getProgramDayStatus(
                    getProgramStatus(
                      data.userDetails?.patient?.user?.userProgram
                              ?.preparatoryProgram
                              .toString() ??
                          '',
                      data.userDetails?.patient?.user?.userProgram?.detoxProgram
                              .toString() ??
                          '',
                      data.userDetails?.patient?.user?.userProgram
                              ?.healingProgram
                              .toString() ??
                          '',
                      data.userDetails?.patient?.user?.userProgram
                              ?.nourishProgram
                              .toString() ??
                          '',
                      data.userDetails?.patient?.user?.userProgram
                              ?.isNourishCompleted
                              .toString() ??
                          '',
                    ),
                    data.userDetails?.patient?.user?.userProgram
                            ?.preparatoryTotalDays
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.preparatoryPresentDay
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram?.detoxTotalDays
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.detoxPresentDay
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.healingTotalDays
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.healingPresentDay
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.nourishTotalDays
                            .toString() ??
                        '',
                    data.userDetails?.patient?.user?.userProgram
                            ?.nourishPresentDay
                            .toString() ??
                        '',
                  ),
                  updateTime: '',
                  updateDate: '',
                  userProgram: data.userDetails?.patient?.user?.userProgram,
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
                    backgroundImage: NetworkImage(
                        data.userDetails?.patient?.user?.profile.toString() ??
                            ''),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.userDetails?.patient?.user?.name ?? '',
                          style: AllListText().headingText(),
                        ),
                        Text(
                          "${data.userDetails?.patient?.user?.age ?? ""} ${data.userDetails?.patient?.user?.gender ?? ""}",
                          style: AllListText().subHeadingText(),
                        ),
                        Text(
                          buildTimeDate(
                              data.userDetails?.appointments?[0].date
                                      .toString() ??
                                  '',
                              data.userDetails?.appointments?[0].slotStartTime
                                      .toString() ??
                                  ''),
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
                                  data.userDetails?.patient?.status ?? ''),
                              style: AllListText().subHeadingText(),
                            ),
                            buildActiveIconWidget(
                              data
                                  .userDetails
                                  ?.patient
                                  ?.user
                                  ?.userProgram
                                  ?.isPreparatoryCompleted
                                  .toString() ??
                                  '',
                              data
                                  .userDetails
                                  ?.patient
                                  ?.user
                                  ?.userProgram
                                  ?.detoxProgram
                                  .toString() ??
                                  '',
                              data
                                  .userDetails
                                  ?.patient
                                  ?.user
                                  ?.userProgram
                                  ?.isDetoxCompleted
                                  .toString() ??
                                  '',
                              data
                                  .userDetails
                                  ?.patient
                                  ?.user
                                  ?.userProgram
                                  ?.healingProgram
                                  .toString() ??
                                  '',
                              data
                                  .userDetails
                                  ?.patient
                                  ?.user
                                  ?.userProgram
                                  ?.isHealingCompleted
                                  .toString() ??
                                  '',
                              data
                                  .userDetails
                                  ?.patient
                                  ?.user
                                  ?.userProgram
                                  ?.nourishProgram
                                  .toString() ??
                                  '',
                            )
                          ],
                        ),
                        data.userProgramStartDate.toString() == "null"
                            ? const SizedBox()
                            : Row(
                                children: [
                                  Text(
                                    "Start Date : ",
                                    style: AllListText().otherText(),
                                  ),
                                  Text(
                                    data.userProgramStartDate.toString(),
                                    style: AllListText().subHeadingText(),
                                  ),
                                ],
                              ),
                        Row(
                          children: [
                            Text(
                              "Final Diagnosis : ",
                              style: AllListText().otherText(),
                            ),
                            Expanded(
                              child: Text(
                                data.userFinalDiagnosis.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AllListText().subHeadingText(),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          getProgramStatus(
                            data.userDetails?.patient?.user?.userProgram
                                    ?.preparatoryProgram
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.detoxProgram
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.healingProgram
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.nourishProgram
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.isNourishCompleted
                                    .toString() ??
                                '',
                          ),
                          style: AllListText().getProgramStatus(),
                        ),
                        Text(
                          getProgramDayStatus(
                            getProgramStatus(
                              data.userDetails?.patient?.user?.userProgram
                                      ?.preparatoryProgram
                                      .toString() ??
                                  '',
                              data.userDetails?.patient?.user?.userProgram
                                      ?.detoxProgram
                                      .toString() ??
                                  '',
                              data.userDetails?.patient?.user?.userProgram
                                      ?.healingProgram
                                      .toString() ??
                                  '',
                              data.userDetails?.patient?.user?.userProgram
                                      ?.nourishProgram
                                      .toString() ??
                                  '',
                              data.userDetails?.patient?.user?.userProgram
                                      ?.isNourishCompleted
                                      .toString() ??
                                  '',
                            ),
                            data.userDetails?.patient?.user?.userProgram
                                    ?.preparatoryTotalDays
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.preparatoryPresentDay
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.detoxTotalDays
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.detoxPresentDay
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.healingTotalDays
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.healingPresentDay
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.nourishTotalDays
                                    .toString() ??
                                '',
                            data.userDetails?.patient?.user?.userProgram
                                    ?.nourishPresentDay
                                    .toString() ??
                                '',
                          ),
                          style: AllListText().getProgramStatus(),
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
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
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

  saveUserId(String patientId, String teamPatientId, String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("patient_id", patientId);
    preferences.setString("team_patient_id", teamPatientId);
    preferences.setString("user_id", userId);
  }

  String buildStatusText(String status) {
    if (status == "start_program") {
      return "Started Program";
    } else if (status == "shipping_delivered") {
      return "Shipment Delivered";
    } else if (status == "prep") {
      return "Preparatory";
    } else if (status == "detox") {
      return "Detox";
    } else if (status == "healing") {
      return "Healing";
    } else if (status == "nourish") {
      return "Nourish";
    }
    return statusText;
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
    if (programStatus == "Preparatory Program Running") {
      return "Preparatory days : $prepCurrentDay/$prepTotalDays";
    } else if (programStatus == "Detox Program Running") {
      return "Detox days : $detoxCurrentDay/$detoxTotalDays";
    } else if (programStatus == "Healing Program Running") {
      return "Healing days : $healingCurrentDay/$healingTotalDays";
    } else if (programStatus == "Nourish Program Running") {
      return "Nourish days : $nourishCurrentDay/$nourishTotalDays";
    }
    return programDayStatus;
  }

}
