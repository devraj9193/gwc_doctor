import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controller/direct_list_controller.dart';
import '../../controller/linked_customers_controller.dart';
import '../../controller/repository/api_service.dart';
import '../../controller/services/chat_service.dart';
import '../../controller/services/quick_blox_service.dart';
import '../../model/error_model.dart';
import '../../model/message_model/get_chat_groupid_model.dart';
import '../../model/quick_blox_repository/message_repo.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/pop_up_menu_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../widgets/widgets.dart';
import '../active_screens/active_customer_details.dart';
import '../meal_plans_screens/meal_plan_data.dart';
import '../message_screens/message_screen.dart';

class DirectBridgedScreen extends StatefulWidget {
  const DirectBridgedScreen({Key? key}) : super(key: key);

  @override
  State<DirectBridgedScreen> createState() => _DirectBridgedScreenState();
}

class _DirectBridgedScreenState extends State<DirectBridgedScreen> {
  String statusText = "";
  final SharedPreferences _pref = AppConfig().preferences!;

  DirectListController directListController = Get.put(DirectListController());

  LinkedCustomersController linkedCustomersController =
      Get.put(LinkedCustomersController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gWhiteColor,
          appBar: dashboardAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 1.h),
              // Padding(
              //   padding: EdgeInsets.only(left: 3.w),
              //   child: SizedBox(
              //     height: 5.h,
              //     child: const Image(
              //       image: AssetImage("assets/images/Gut wellness logo.png"),
              //     ),
              //   ),
              // ),
              TabBar(
                  labelColor: gPrimaryColor,
                  unselectedLabelColor: gTextColor,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  isScrollable: true,
                  indicatorColor: gPrimaryColor,
                  unselectedLabelStyle: TextStyle(
                      fontFamily: "GothamBook",
                      color: gBlackColor,
                      fontSize: 9.sp),
                  labelPadding:
                      EdgeInsets.only(right: 10.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 7.w),
                  labelStyle: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gPrimaryColor,
                      fontSize: 10.sp),
                  tabs: const [
                    Text('Direct'),
                    // Text('Bridged'),
                  ]),
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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: directListController.fetchDirectList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return buildNoData();
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  directListController.fetchDirectList();
                },
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    SizedBox(height: 2.h),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 2.h,
                                    backgroundImage: NetworkImage(
                                        data[index].patient.user.profile ?? ""),
                                  ),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].patient.user.name ?? "",
                                          style: TextStyle(
                                              fontFamily: "GothamMedium",
                                              color: gTextColor,
                                              fontSize: 10.sp),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                          style: TextStyle(
                                              fontFamily: "GothamMedium",
                                              color: gTextColor,
                                              fontSize: 8.sp),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                                          style: TextStyle(
                                              fontFamily: "GothamBook",
                                              color: gTextColor,
                                              fontSize: 8.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopUpMenuWidget(
                                    onView: () {
                                      saveUserId(
                                          data[index].patientId.toString(),
                                          data[index].id.toString(),
                                          data[index]
                                              .patient
                                              .user
                                              .id
                                              .toString());
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ct) =>
                                              ActiveCustomerDetails(
                                            userName:
                                                data[index].patient.user.name ??
                                                    "",
                                            age:
                                                "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                            appointmentDetails:
                                                "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                                            status: data[index].status ?? "",
                                            startDate: '',
                                            presentDay: '',
                                            finalDiagnosis: '',
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
                                          ),
                                        ),
                                      );
                                    },
                                    onCall: () {
                                      saveUserId(
                                          data[index].patientId.toString(),
                                          data[index].id.toString(),
                                          data[index]
                                              .patient
                                              .user
                                              .id
                                              .toString());
                                      callDialog(context);
                                    },
                                    onMessage: () {
                                      getChatGroupId(
                                        data[index].patient.user.name ?? "",
                                        "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                        data[index].patient.user.id.toString(),
                                      );
                                      saveUserId(
                                          data[index].patientId.toString(),
                                          data[index].id.toString(),
                                          data[index]
                                              .patient
                                              .user
                                              .id
                                              .toString());
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
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  buildBridged() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const AlwaysScrollableScrollPhysics(),
      child: FutureBuilder(
          future: linkedCustomersController.fetchCustomersList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return buildNoData();
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  linkedCustomersController.fetchCustomersList();
                },
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    SizedBox(height: 2.h),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 9,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 2.h,
                                    backgroundImage: NetworkImage(
                                        data[index].profile.toString()),
                                  ),
                                  SizedBox(width: 2.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data[index].fname.toString()} ${data[index].lname.toString()}",
                                          style: TextStyle(
                                              fontFamily: "GothamMedium",
                                              color: gTextColor,
                                              fontSize: 10.sp),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          "${data[index].date.toString()} / ${data[index].time.toString()}",
                                          style: TextStyle(
                                              fontFamily: "GothamBook",
                                              color: gTextColor,
                                              fontSize: 8.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopUpMenuWidget(
                                    onView: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ct) =>
                                              ActiveCustomerDetails(
                                            userName:
                                                data[index].patient.user.name ??
                                                    "",
                                            age:
                                                "${data[index].patient.user.age ?? ""} ${data[index].patient.user.gender ?? ""}",
                                            appointmentDetails:
                                                "${data[index].appointmentDate ?? ""} / ${data[index].appointmentTime ?? ""}",
                                            status: data[index].status ?? "",
                                            startDate: '',
                                            presentDay: '',
                                            finalDiagnosis: '',
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
                                          ),
                                        ),
                                      );
                                    },
                                    onCall: () {
                                      callDialog(context);
                                    },
                                    onMessage: () {
                                      getChatGroupId(
                                          "${data[index].fname.toString()} ${data[index].lname.toString()}",
                                          data[index].profile.toString(),
                                          data[index].id.toString());
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
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  buildList() {
    return RefreshIndicator(
      onRefresh: () async {
        mealPlanData.length;
      },
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: mealPlanData.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1.h),
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: gWhiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 5.h,
                        width: 10.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: const Image(
                            image: AssetImage("assets/images/cheerful.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ms. Lorem Ipsum Daries",
                            style: TextStyle(
                                fontFamily: "GothamRoundedBold_21016",
                                color: gPrimaryColor,
                                fontSize: 11.sp),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            "Signup Date : 12th April",
                            style: TextStyle(
                                fontFamily: "PhilosopherRegular",
                                color: gMainColor,
                                fontSize: 9.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

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

  final MessageRepository chatRepository = MessageRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  getChatGroupId(String userName, String profileImage, String userId) async {
    print(_pref.getInt(AppConfig.GET_QB_SESSION));
    print(_pref.getBool(AppConfig.IS_QB_LOGIN));

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var chatUserName = preferences.getString("chatUserName")!;
    print("UserName: $chatUserName");

    print(_pref.getInt(AppConfig.GET_QB_SESSION) == null ||
        _pref.getBool(AppConfig.IS_QB_LOGIN) == null ||
        _pref.getBool(AppConfig.IS_QB_LOGIN) == false);
    final _qbService = Provider.of<QuickBloxService>(context, listen: false);
    print(await _qbService.getSession());
    if (_pref.getInt(AppConfig.GET_QB_SESSION) == null ||
        await _qbService.getSession() == true ||
        _pref.getBool(AppConfig.IS_QB_LOGIN) == null ||
        _pref.getBool(AppConfig.IS_QB_LOGIN) == false) {
      _qbService.login(chatUserName);
    } else {
      if (await _qbService.isConnected() == false) {
        _qbService.connect(_pref.getInt(AppConfig.QB_CURRENT_USERID)!);
      }
    }
    final res = await ChatService(repository: chatRepository)
        .getChatGroupIdService(userId);

    if (res.runtimeType == GetChatGroupIdModel) {
      GetChatGroupIdModel model = res as GetChatGroupIdModel;
      // QuickBloxRepository().init(AppConfig.QB_APP_ID, AppConfig.QB_AUTH_KEY, AppConfig.QB_AUTH_SECRET, AppConfig.QB_ACCOUNT_KEY);
      _pref.setString(AppConfig.GROUP_ID, model.group ?? '');
      print('model.group: ${model.group}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => MessageScreen(
                    isGroupId: true,
                    userName: userName,
                    profileImage: profileImage,
                  )));
    } else {
      ErrorModel model = res as ErrorModel;
      AppConfig()
          .showSnackBar(context, model.message.toString(), isError: true);
    }
  }
}
