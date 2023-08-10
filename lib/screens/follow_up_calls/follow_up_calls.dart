import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../model/error_model.dart';
import '../../model/follow_up_calls_model/follow_up_calls_model.dart';
import '../../repository/api_service.dart';
import '../../repository/follow_up_calls_repo/follow_up_calls_repo.dart';
import '../../services/follow_up_calls_service/follow_up_calls_service.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/pop_up_menu_widget.dart';
import '../../widgets/widgets.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../nutri_delight_screens/nutri_delight_screen.dart';

class FollowUpCallsScreen extends StatefulWidget {
  const FollowUpCallsScreen({Key? key}) : super(key: key);

  @override
  State<FollowUpCallsScreen> createState() => _FollowUpCallsScreenState();
}

class _FollowUpCallsScreenState extends State<FollowUpCallsScreen> {
  final searchController = TextEditingController();
  List<Datum> searchResults = [];

  String statusText = "";
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  DateTime initialDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  bool showProgress = false;
  FollowUpCallsModel? followUpCallsModel;

  final ScrollController _scrollController = ScrollController();

  late final FollowUpCallsService followUpCallsService =
      FollowUpCallsService(followUpCallsRepo: repository);

  @override
  void initState() {
    super.initState();
    getFollowUpCallsList();
  }

  getFollowUpCallsList() async {
    setState(() {
      showProgress = true;
    });

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(selectedDate);

    print("formatted : $formatted");

    callProgressStateOnBuild(true);
    final result = await followUpCallsService.getAllCustomerService(formatted);
    print("result: $result");

    if (result.runtimeType == FollowUpCallsModel) {
      print("Follow UP Calls List");
      FollowUpCallsModel model = result as FollowUpCallsModel;

      followUpCallsModel = model;
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
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

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await followUpCallsService.getAllCustomerService(selectedDate.toString());
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "selectedDate : ${DateTime(selectedDate.year, selectedDate.month, selectedDate.day)} == ${DateTime(initialDate.year, initialDate.month, initialDate.day)}");
    return DefaultTabController(
      length: 1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gWhiteColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            elevation: 0,
            backgroundColor: gWhiteColor,
            title: searchBarTitle,
            actions: [
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
                      searchBarTitle = Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: gSecondaryColor,
                              size: 2.h,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          SizedBox(
                            height: 5.h,
                            child: const Image(
                              image: AssetImage("assets/images/Gut wellness logo.png"),
                            ),
                          ),
                        ],
                      );
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
              SizedBox(width: 3.w),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                labelColor: tapSelectedColor,
                unselectedLabelColor: tapUnSelectedColor,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                isScrollable: true,
                indicatorColor: tapIndicatorColor,
                labelStyle: TabBarText().selectedText(),
                unselectedLabelStyle: TabBarText().unSelectedText(),
                labelPadding: EdgeInsets.only(
                    right: 10.w, left: 2.w, top: 1.h, bottom: 1.h),
                indicatorPadding: EdgeInsets.only(right: 7.w),
                tabs: const [
                  Text('Follow Up Calls'),
                ],
              ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(""),
                  DateTime(selectedDate.year, selectedDate.month, selectedDate.day) == DateTime(initialDate.year, initialDate.month, initialDate.day)
                        ? Text(
                            "Today",
                            style: TabBarText().selectedText(),
                          )
                        : Text(
                            DateFormat('dd/MM/yyyy')
                                .format(
                                    DateTime.parse((selectedDate.toString())))
                                .toString(),
                            style: TabBarText().selectedText(),
                          ),
                    GestureDetector(
                      onTap: () => _selectDate(context), // Refer step 3
                      child: Icon(
                        Icons.date_range_outlined,
                        color: gBlackColor,
                        size: 3.5.h,
                      ),
                    ),
                  ],
                ),
              ),
              (showProgress)
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: buildCircularIndicator(),
                    )
                  : Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          buildFollowUpCalls(),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  buildFollowUpCalls() {
    List<Datum> followUpCalls = followUpCallsModel?.data ?? [];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SmartRefresher(
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: refreshController,
          physics: const BouncingScrollPhysics(),
          enablePullDown: true,
          enablePullUp: true,
          header: const ClassicHeader(),
          child: followUpCalls.isEmpty
              ? buildNoData()
              : searchController.text.isEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: followUpCalls.length,
                  itemBuilder: ((context, index) {
                    Datum? currentIndex = followUpCalls[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 3.h,
                                backgroundImage: NetworkImage(currentIndex
                                        .teamPatients?.patient?.user?.profile ??
                                    ""),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentIndex.teamPatients?.patient?.user
                                              ?.name ??
                                          "",
                                      style: AllListText().headingText(),
                                    ),
                                    Text(
                                      "${currentIndex.teamPatients?.patient?.user?.age ?? ""} ${currentIndex.teamPatients?.patient?.user?.gender ?? ""}",
                                      style: AllListText().subHeadingText(),
                                    ),
                                    Text(
                                      buildTimeDate(
                                        "${currentIndex.teamPatients?.appointments![0].date.toString()}",
                                        "${currentIndex.teamPatients?.appointments![0].slotStartTime.toString()}",
                                      ),
                                      style: AllListText().otherText(),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Present Date : ",
                                          style: AllListText().otherText(),
                                        ),
                                        Text(
                                          currentIndex.date.toString(),
                                          style: AllListText().subHeadingText(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Status : ",
                                          style: AllListText().otherText(),
                                        ),
                                        Text(
                                          currentIndex.teamPatients?.patient
                                                  ?.status ??
                                              '',
                                          style: AllListText().subHeadingText(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              PopUpMenuWidget(
                                onView: () {
                                  Get.to(
                                    () => NutriDelightScreen(
                                      tabIndex: 0,
                                      userId : int.parse("${currentIndex.teamPatients?.patient?.user?.id}"),
                                      userName: currentIndex.teamPatients
                                              ?.patient?.user?.name ??
                                          "",updateTime: '', updateDate: '',
                                      age:
                                          "${currentIndex.teamPatients?.patient?.user?.age ?? ""} ${currentIndex.teamPatients?.patient?.user?.gender ?? ""}",
                                      appointmentDetails: buildTimeDate(
                                        "${currentIndex.teamPatients?.appointments![0].date.toString()}",
                                        "${currentIndex.teamPatients?.appointments![0].slotStartTime.toString()}",
                                      ),
                                      status: currentIndex
                                              .teamPatients?.patient?.status ??
                                          '',
                                      finalDiagnosis: '',
                                      preparatoryCurrentDay: '',
                                      transitionCurrentDay: '',
                                      isPrepCompleted: '',
                                      isProgramStatus: '',
                                      programDaysStatus: '',
                                    ),
                                  );
                                  saveUserId(
                                    currentIndex.id.toString(),
                                    "${currentIndex.teamPatients?.id}",
                                    "${currentIndex.teamPatients?.patient?.user?.id}",
                                  );
                                },
                                onCall: () {
                                  saveUserId(
                                    currentIndex.id.toString(),
                                    "${currentIndex.teamPatients?.id}",
                                    "${currentIndex.teamPatients?.patient?.user?.id}",
                                  );

                                  // callDialog(context);
                                },
                                onMessage: () {
                                  // getChatGroupId(
                                  //   data[index].patient.user.name ?? "",
                                  //   "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                  //   data[index].patient.user.id.toString(),
                                  //);
                                  saveUserId(
                                    currentIndex.id.toString(),
                                    "${currentIndex.teamPatients?.id}",
                                    "${currentIndex.teamPatients?.patient?.user?.id}",
                                  );
                                },
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
                ) : buildSearchList(),
        ),
      ),
    );
  }

  Icon searchIcon = Icon(
    Icons.search,
    color: gBlackColor,
    size: 2.5.h,
  );
  Widget searchBarTitle = Row(
    children: [
      GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_sharp,
          color: gSecondaryColor,
          size: 2.h,
        ),
      ),
      SizedBox(width: 2.w),
      SizedBox(
        height: 5.h,
        child: const Image(
          image: AssetImage("assets/images/Gut wellness logo.png"),
        ),
      ),
    ],
  );

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
        margin: EdgeInsets.only(right: 1.w),
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
    followUpCallsModel?.data?.forEach((userDetail) {
      if (userDetail.teamPatients!.patient!.user!.name!.toLowerCase().contains(text.toLowerCase())) {
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
        Datum? currentIndex = searchResults[index];
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundImage: NetworkImage(currentIndex
                        .teamPatients?.patient?.user?.profile ??
                        ""),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentIndex.teamPatients?.patient?.user
                              ?.name ??
                              "",
                          style: AllListText().headingText(),
                        ),
                        Text(
                          "${currentIndex.teamPatients?.patient?.user?.age ?? ""} ${currentIndex.teamPatients?.patient?.user?.gender ?? ""}",
                          style: AllListText().subHeadingText(),
                        ),
                        Text(
                          buildTimeDate(
                            "${currentIndex.teamPatients?.appointments![0].date.toString()}",
                            "${currentIndex.teamPatients?.appointments![0].slotStartTime.toString()}",
                          ),
                          style: AllListText().otherText(),
                        ),
                        Row(
                          children: [
                            Text(
                              "Present Date : ",
                              style: AllListText().otherText(),
                            ),
                            Text(
                              currentIndex.date.toString(),
                              style: AllListText().subHeadingText(),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Status : ",
                              style: AllListText().otherText(),
                            ),
                            Text(
                              currentIndex.teamPatients?.patient
                                  ?.status ??
                                  '',
                              style: AllListText().subHeadingText(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopUpMenuWidget(
                    onView: () {
                      Get.to(
                            () => NutriDelightScreen(
                          tabIndex: 0,
                          userId : int.parse("${currentIndex.teamPatients?.patient?.user?.id}"),
                          userName: currentIndex.teamPatients
                              ?.patient?.user?.name ??
                              "",updateTime: '', updateDate: '',
                          age:
                          "${currentIndex.teamPatients?.patient?.user?.age ?? ""} ${currentIndex.teamPatients?.patient?.user?.gender ?? ""}",
                          appointmentDetails: buildTimeDate(
                            "${currentIndex.teamPatients?.appointments![0].date.toString()}",
                            "${currentIndex.teamPatients?.appointments![0].slotStartTime.toString()}",
                          ),
                          status: currentIndex
                              .teamPatients?.patient?.status ??
                              '',
                          finalDiagnosis: '',
                          preparatoryCurrentDay: '',
                          transitionCurrentDay: '',
                          isPrepCompleted: '',
                          isProgramStatus: '',
                          programDaysStatus: '',
                        ),
                      );
                      saveUserId(
                        currentIndex.id.toString(),
                        "${currentIndex.teamPatients?.id}",
                        "${currentIndex.teamPatients?.patient?.user?.id}",
                      );
                    },
                    onCall: () {
                      saveUserId(
                        currentIndex.id.toString(),
                        "${currentIndex.teamPatients?.id}",
                        "${currentIndex.teamPatients?.patient?.user?.id}",
                      );

                      // callDialog(context);
                    },
                    onMessage: () {
                      // getChatGroupId(
                      //   data[index].patient.user.name ?? "",
                      //   "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                      //   data[index].patient.user.id.toString(),
                      //);
                      saveUserId(
                        currentIndex.id.toString(),
                        "${currentIndex.teamPatients?.id}",
                        "${currentIndex.teamPatients?.patient?.user?.id}",
                      );
                    },
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
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate, // Refer step 1
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
        print("picked Date : $selectedDate");
        getFollowUpCallsList();
        // selectedDate = picked;
      });
    }
  }

  final FollowUpCallsRepo repository = FollowUpCallsRepo(
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
}
