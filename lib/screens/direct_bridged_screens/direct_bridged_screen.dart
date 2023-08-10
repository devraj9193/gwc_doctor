import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../model/direct_list_model.dart';
import '../../model/error_model.dart';
import '../../repository/api_service.dart';
import '../../repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../services/customer_status_service/customer_status_service.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/pop_up_menu_widget.dart';
import '../../widgets/widgets.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:http/http.dart' as http;

class DirectBridgedScreen extends StatefulWidget {
  const DirectBridgedScreen({Key? key}) : super(key: key);

  @override
  State<DirectBridgedScreen> createState() => _DirectBridgedScreenState();
}

class _DirectBridgedScreenState extends State<DirectBridgedScreen> {
  String statusText = "";
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final searchController = TextEditingController();

  bool showProgress = false;
  DirectListModel? directListModel;
  List<UsersList> searchResults = [];
  final ScrollController _scrollController = ScrollController();

  late final CustomerStatusService customerStatusService =
      CustomerStatusService(customerStatusRepo: repository);

  @override
  void initState() {
    super.initState();
    getClaimedCustomerList();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await customerStatusService.getPostProgramService();
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  getClaimedCustomerList() async {
    setState(() {
      showProgress = true;
    });
    callProgressStateOnBuild(true);
    final result = await customerStatusService.getDirectListService();
    print("result: $result");

    if (result.runtimeType == DirectListModel) {
      print("Ticket List");
      DirectListModel model = result as DirectListModel;

      directListModel = model;
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
                      searchBarTitle = SizedBox(
                        height: 5.h,
                        child: const Image(
                          image:
                              AssetImage("assets/images/Gut wellness logo.png"),
                        ),
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
              SizedBox(width: 2.w),
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
                  Text('Direct'),
                  // Text('Bridged'),
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 0.w, bottom: 1.h),
                color: gGreyColor.withOpacity(0.3),
                width: double.maxFinite,
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildDirect(),
                      //    buildBridged(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDirect() {
    List<UsersList> directList = directListModel?.usersList ?? [];

    return (showProgress)
        ? Center(
            child: buildCircularIndicator(),
          )
        : directList.isEmpty
            ? buildNoData()
            : Column(
                children: [
                  SizedBox(height: 1.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: searchController.text.isEmpty
                          ? ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: directList.length,
                              itemBuilder: ((context, index) {
                                var data = directList[index];
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 3.h,
                                          backgroundImage: NetworkImage(
                                              data.patient?.user?.profile ??
                                                  ""),
                                        ),
                                        SizedBox(width: 2.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.patient?.user?.name ?? "",
                                                style:
                                                    AllListText().headingText(),
                                              ),
                                              Text(
                                                "${data.patient?.user?.age ?? ""} ${data.patient?.user?.gender ?? ""}",
                                                style: AllListText()
                                                    .subHeadingText(),
                                              ),
                                              Text(
                                                "${data.appointmentDate ?? ""} / ${data.appointmentTime ?? ""}",
                                                style:
                                                    AllListText().otherText(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopUpMenuWidget(
                                          onView: () {
                                            saveUserId(
                                                data.patientId.toString(),
                                                data.id.toString(),
                                                data.patient?.user?.id
                                                        .toString() ??
                                                    '');
                                            // Navigator.of(context).push(
                                            //   MaterialPageRoute(
                                            //     builder: (ct) =>
                                            //         ActiveCustomerDetails(
                                            //       userName:
                                            //           data[index].patient.user.name ??
                                            //               "",
                                            //       age:
                                            //           "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                            //       appointmentDetails:
                                            //           "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                                            //       status: data[index].status ?? "",
                                            //       startDate: '',
                                            //       presentDay: '',
                                            //       finalDiagnosis: '',
                                            //       preparatoryCurrentDay: data[index]
                                            //               .userDetails
                                            //               .patient
                                            //               .user
                                            //               .userProgram
                                            //               .ppCurrentDay ??
                                            //           "",
                                            //       transitionCurrentDay: data[index]
                                            //               .userDetails
                                            //               .patient
                                            //               .user
                                            //               .userProgram
                                            //               .tpCurrentDay ??
                                            //           "",
                                            //       transitionDays: '',
                                            //       prepDays: '',
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          onCall: () {
                                            saveUserId(
                                                data.patientId.toString(),
                                                data.id.toString(),
                                                data.patient?.user?.id
                                                        .toString() ??
                                                    '');
                                            // callDialog(context);
                                          },
                                          onMessage: () {
                                            // getChatGroupId(
                                            //   data[index].patient.user.name ?? "",
                                            //   "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                            //   data[index].patient.user.id.toString(),
                                            //);
                                            saveUserId(
                                                data.patientId.toString(),
                                                data.id.toString(),
                                                data.patient?.user?.id
                                                        .toString() ??
                                                    '');
                                          },
                                        ),
                                      ],
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

  Icon searchIcon = Icon(
    Icons.search,
    color: gBlackColor,
    size: 2.5.h,
  );
  Widget searchBarTitle = SizedBox(
    height: 5.h,
    child: const Image(
      image: AssetImage("assets/images/Gut wellness logo.png"),
    ),
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
    directListModel?.usersList?.forEach((userDetail) {
      if (userDetail.patient!.user!.name!
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
          onTap: () {},
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundImage:
                        NetworkImage(data.patient?.user?.profile ?? ""),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.patient?.user?.name ?? "",
                          style: AllListText().headingText(),
                        ),
                        Text(
                          "${data.patient?.user?.age ?? ""} ${data.patient?.user?.gender ?? ""}",
                          style: AllListText().subHeadingText(),
                        ),
                        Text(
                          "${data.appointmentDate ?? ""} / ${data.appointmentTime ?? ""}",
                          style: AllListText().otherText(),
                        ),
                      ],
                    ),
                  ),
                  PopUpMenuWidget(
                    onView: () {
                      saveUserId(data.patientId.toString(), data.id.toString(),
                          data.patient?.user?.id.toString() ?? '');
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ct) =>
                      //         ActiveCustomerDetails(
                      //       userName:
                      //           data[index].patient.user.name ??
                      //               "",
                      //       age:
                      //           "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                      //       appointmentDetails:
                      //           "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                      //       status: data[index].status ?? "",
                      //       startDate: '',
                      //       presentDay: '',
                      //       finalDiagnosis: '',
                      //       preparatoryCurrentDay: data[index]
                      //               .userDetails
                      //               .patient
                      //               .user
                      //               .userProgram
                      //               .ppCurrentDay ??
                      //           "",
                      //       transitionCurrentDay: data[index]
                      //               .userDetails
                      //               .patient
                      //               .user
                      //               .userProgram
                      //               .tpCurrentDay ??
                      //           "",
                      //       transitionDays: '',
                      //       prepDays: '',
                      //     ),
                      //   ),
                      // );
                    },
                    onCall: () {
                      saveUserId(data.patientId.toString(), data.id.toString(),
                          data.patient?.user?.id.toString() ?? '');
                      // callDialog(context);
                    },
                    onMessage: () {
                      // getChatGroupId(
                      //   data[index].patient.user.name ?? "",
                      //   "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                      //   data[index].patient.user.id.toString(),
                      //);
                      saveUserId(data.patientId.toString(), data.id.toString(),
                          data.patient?.user?.id.toString() ?? '');
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

  final CustomerStatusRepo repository = CustomerStatusRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  // buildBridged() {
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.symmetric(horizontal: 3.w),
  //     physics: const AlwaysScrollableScrollPhysics(),
  //     child: FutureBuilder(
  //         future: linkedCustomersController.fetchCustomersList(),
  //         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //           if (snapshot.hasError) {
  //             return buildNoData();
  //           } else if (snapshot.hasData) {
  //             var data = snapshot.data;
  //             return RefreshIndicator(
  //               onRefresh: () async {
  //                 linkedCustomersController.fetchCustomersList();
  //               },
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     height: 1,
  //                     color: Colors.grey.withOpacity(0.3),
  //                   ),
  //                   SizedBox(height: 2.h),
  //                   ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     padding: EdgeInsets.symmetric(horizontal: 1.w),
  //                     physics: const AlwaysScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     itemCount: 9,
  //                     itemBuilder: ((context, index) {
  //                       return GestureDetector(
  //                         onTap: () {},
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 CircleAvatar(
  //                                   radius: 3.h,
  //                                   backgroundImage: NetworkImage(
  //                                       data[index].profile.toString()),
  //                                 ),
  //                                 SizedBox(width: 2.w),
  //                                 Expanded(
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         "${data[index].fname.toString()} ${data[index].lname.toString()}",
  //                                         style: AllListText().headingText(),
  //                                       ),
  //
  //                                       Text(
  //                                         "${data[index].date.toString()} / ${data[index].time.toString()}",
  //                                         style: AllListText().subHeadingText(),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 PopUpMenuWidget(
  //                                   onView: () {
  //                                     Navigator.of(context).push(
  //                                       MaterialPageRoute(
  //                                         builder: (ct) =>
  //                                             ActiveCustomerDetails(
  //                                           userName:
  //                                               data[index].patient.user.name ??
  //                                                   "",
  //                                           age:
  //                                               "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
  //                                           appointmentDetails:
  //                                               "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
  //                                           status: data[index].status ?? "",
  //                                           startDate: '',
  //                                           presentDay: '',
  //                                           finalDiagnosis: '',
  //                                           preparatoryCurrentDay: data[index]
  //                                                   .userDetails
  //                                                   .patient
  //                                                   .user
  //                                                   .userProgram
  //                                                   .ppCurrentDay ??
  //                                               "",
  //                                           transitionCurrentDay: data[index]
  //                                                   .userDetails
  //                                                   .patient
  //                                                   .user
  //                                                   .userProgram
  //                                                   .tpCurrentDay ??
  //                                               "",
  //                                           transitionDays: '',
  //                                           prepDays: '', isPrepCompleted: '',
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                   onCall: () {
  //                                     callDialog(context);
  //                                   },
  //                                   onMessage: () {
  //                                     // getChatGroupId(
  //                                     //     "${data[index].fname.toString()} ${data[index].lname.toString()}",
  //                                     //     data[index].profile.toString(),
  //                                     //     data[index].id.toString());
  //                                   },
  //                                 ),
  //                               ],
  //                             ),
  //                             Container(
  //                               height: 1,
  //                               margin: EdgeInsets.symmetric(vertical: 1.5.h),
  //                               color: Colors.grey.withOpacity(0.3),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     }),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }
  //           return Padding(
  //             padding: EdgeInsets.symmetric(vertical: 10.h),
  //             child: buildCircularIndicator(),
  //           );
  //         }),
  //   );
  // }
  //
  // buildList() {
  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       mealPlanData.length;
  //     },
  //     child: ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemCount: mealPlanData.length,
  //       itemBuilder: ((context, index) {
  //         return GestureDetector(
  //           child: Container(
  //             margin: EdgeInsets.symmetric(vertical: 1.h),
  //             padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
  //             width: double.maxFinite,
  //             decoration: BoxDecoration(
  //               color: gWhiteColor,
  //               borderRadius: BorderRadius.circular(10),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.3),
  //                   blurRadius: 10,
  //                   offset: const Offset(2, 3),
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     SizedBox(
  //                       height: 5.h,
  //                       width: 10.w,
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(8),
  //                         child: const Image(
  //                           image: AssetImage("assets/images/cheerful.png"),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(width: 3.w),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Ms. Lorem Ipsum Daries",
  //                           style: TextStyle(
  //                               fontFamily: "GothamRoundedBold_21016",
  //                               color: gPrimaryColor,
  //                               fontSize: 11.sp),
  //                         ),
  //
  //                         Text(
  //                           "Signup Date : 12th April",
  //                           style: TextStyle(
  //                               fontFamily: "PhilosopherRegular",
  //                               color: gMainColor,
  //                               fontSize: 9.sp),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }

  saveUserId(String patientId, String teamPatientId, String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("patient_id", patientId);
    preferences.setString("team_patient_id", teamPatientId);
    preferences.setString("user_id", userId);
  }

  String buildStatusText(String status) {
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

  // final MessageRepository chatRepository = MessageRepository(
  //   apiClient: ApiClient(
  //     httpClient: http.Client(),
  //   ),
  // );
  //
  // getChatGroupId(String userName, String profileImage, String userId) async {
  //   print(_pref.getInt(AppConfig.GET_QB_SESSION));
  //   print(_pref.getBool(AppConfig.IS_QB_LOGIN));
  //
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var chatUserName = preferences.getString("chatUserName")!;
  //   print("UserName: $chatUserName");
  //
  //   print(_pref.getInt(AppConfig.GET_QB_SESSION) == null ||
  //       _pref.getBool(AppConfig.IS_QB_LOGIN) == null ||
  //       _pref.getBool(AppConfig.IS_QB_LOGIN) == false);
  //   final _qbService = Provider.of<QuickBloxService>(context, listen: false);
  //   print(await _qbService.getSession());
  //   if (_pref.getInt(AppConfig.GET_QB_SESSION) == null ||
  //       await _qbService.getSession() == true ||
  //       _pref.getBool(AppConfig.IS_QB_LOGIN) == null ||
  //       _pref.getBool(AppConfig.IS_QB_LOGIN) == false) {
  //     _qbService.login(chatUserName);
  //   } else {
  //     if (await _qbService.isConnected() == false) {
  //       _qbService.connect(_pref.getInt(AppConfig.QB_CURRENT_USERID)!);
  //     }
  //   }
  //   final res = await ChatService(repository: chatRepository)
  //       .getChatGroupIdService(userId);
  //
  //   if (res.runtimeType == GetChatGroupIdModel) {
  //     GetChatGroupIdModel model = res as GetChatGroupIdModel;
  //     // QuickBloxRepository().init(AppConfig.QB_APP_ID, AppConfig.QB_AUTH_KEY, AppConfig.QB_AUTH_SECRET, AppConfig.QB_ACCOUNT_KEY);
  //     _pref.setString(AppConfig.GROUP_ID, model.group ?? '');
  //     print('model.group: ${model.group}');
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (c) => MessageScreen(
  //                   isGroupId: true,
  //                   userName: userName,
  //                   profileImage: profileImage,
  //                 )));
  //   } else {
  //     ErrorModel model = res as ErrorModel;
  //     AppConfig()
  //         .showSnackBar(context, model.message.toString(), isError: true);
  //   }
  // }
}
