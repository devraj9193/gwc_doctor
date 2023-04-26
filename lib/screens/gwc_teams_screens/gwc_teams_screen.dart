import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controller/gwc_team_controller.dart';
import '../../controller/services/quick_blox_service.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/pop_up_menu_widget.dart';
import 'package:get/get.dart';
import '../../utils/app_config.dart';
import '../../widgets/widgets.dart';

class GwcTeamsScreen extends StatefulWidget {
  const GwcTeamsScreen({Key? key}) : super(key: key);

  @override
  State<GwcTeamsScreen> createState() => _GwcTeamsScreenState();
}

class _GwcTeamsScreenState extends State<GwcTeamsScreen> {
  final SharedPreferences _pref = AppConfig().preferences!;

  GwcTeamController gwcTeamController = Get.put(GwcTeamController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: SafeArea(
        child: Scaffold(
          appBar: dashboardAppBar(),
          backgroundColor: gWhiteColor,
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
                  labelColor: tapSelectedColor,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  unselectedLabelColor: tapUnSelectedColor,
                  isScrollable: true,
                  labelStyle: TabBarText().selectedText(),
                  unselectedLabelStyle: TabBarText().unSelectedText(),
                  indicatorColor: tapIndicatorColor,
                  labelPadding: EdgeInsets.only(
                      right: 10.w, left: 2.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 7.w),
                  tabs: const [
                    // Text('Doctors'),
                    Text('Success Team'),
                    //Text("Tech Team")
                  ]),
              Expanded(
                child: TabBarView(children: [
                  //  buildDoctors(),
                  buildSuccessTeam(),
                  //   buildTechTeam(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSuccessTeam() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: FutureBuilder(
          future: gwcTeamController.fetchSuccessList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 35.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(height: 2.h),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 3.h,
                                  backgroundImage: NetworkImage(
                                    data[index].profile.toString(),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].name ?? "",
                                        style: AllListText().headingText(),
                                      ),

                                      Text(
                                        "${data[index].age ?? ""} ${data[index].gender ?? ""}",
                                        style: AllListText().subHeadingText(),
                                      ),

                                      Text(
                                        "${data[index].signupDate ?? ""} ${data[index].signupDate ?? ""}",
                                        style: AllListText().otherText(),
                                      ),
                                    ],
                                  ),
                                ),
                                PopUpMenuWidget(
                                  onView: () {},
                                  onCall: () {},
                                  onMessage: () {
                                    final kaleyraAccessToken = _pref.getString(GwcApi.kaleyraAccessToken);
                                    final kaleyraUserId = _pref.getString("kaleyraUserId");
                                    saveUserId(data[index].id.toString());
                                    final qbService = Provider.of<QuickBloxService>(
                                        context,
                                        listen: false);
                                    qbService.openKaleyraChat("$kaleyraUserId",
                                        data[index].kaleyraUserId.toString(), "$kaleyraAccessToken");
                                    // getSuccessChatGroupId(
                                    //   data[index].name ?? "",
                                    //   "${data[index].profile}",
                                    //   data[index].id.toString(),
                                    // );
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
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  saveUserId(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_id", userId);
  }

  // buildDoctors() {
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.symmetric(horizontal: 3.w),
  //     physics: const BouncingScrollPhysics(),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 1,
  //           color: Colors.grey.withOpacity(0.3),
  //         ),
  //         SizedBox(height: 2.h),
  //         ListView.builder(
  //           scrollDirection: Axis.vertical,
  //           padding: EdgeInsets.symmetric(horizontal: 1.w),
  //           physics: const ScrollPhysics(),
  //           shrinkWrap: true,
  //           itemCount: 10,
  //           itemBuilder: ((context, index) {
  //             return GestureDetector(
  //               onTap: () {},
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 2.h,
  //                         backgroundImage:
  //                             const AssetImage("assets/images/Ellipse 232.png"),
  //                       ),
  //                       SizedBox(width: 2.w),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "Lorem ipsum dadids",
  //                               style: TextStyle(
  //                                   fontFamily: "GothamMedium",
  //                                   color: gTextColor,
  //                                   fontSize: 10.sp),
  //                             ),
  //             
  //                             Text(
  //                               "24 F",
  //                               style: TextStyle(
  //                                   fontFamily: "GothamMedium",
  //                                   color: gTextColor,
  //                                   fontSize: 8.sp),
  //                             ),
  //             
  //                             Text(
  //                               "09th Sep 2022 / 08:30 PM",
  //                               style: TextStyle(
  //                                   fontFamily: "GothamBook",
  //                                   color: gTextColor,
  //                                   fontSize: 8.sp),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       PopUpMenuWidget(
  //                         onView: () {},
  //                         onCall: () {},
  //                         onMessage: () {},
  //                       ),
  //                     ],
  //                   ),
  //                   Container(
  //                     height: 1,
  //                     margin: EdgeInsets.symmetric(vertical: 1.5.h),
  //                     color: Colors.grey.withOpacity(0.3),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // buildTechTeam() {
  //   return SingleChildScrollView(
  //     physics: const BouncingScrollPhysics(),
  //     padding: EdgeInsets.symmetric(horizontal: 3.w),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 1,
  //           color: Colors.grey.withOpacity(0.3),
  //         ),
  //         SizedBox(height: 2.h),
  //         ListView.builder(
  //           scrollDirection: Axis.vertical,
  //           padding: EdgeInsets.symmetric(horizontal: 1.w),
  //           physics: const ScrollPhysics(),
  //           shrinkWrap: true,
  //           itemCount: 10,
  //           itemBuilder: ((context, index) {
  //             return GestureDetector(
  //               onTap: () {},
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 2.h,
  //                         backgroundImage:
  //                             const AssetImage("assets/images/Ellipse 232.png"),
  //                       ),
  //                       SizedBox(width: 2.w),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "Lorem ipsum dadids",
  //                               style: TextStyle(
  //                                   fontFamily: "GothamMedium",
  //                                   color: gTextColor,
  //                                   fontSize: 10.sp),
  //                             ),
  //             
  //                             Text(
  //                               "24 F",
  //                               style: TextStyle(
  //                                   fontFamily: "GothamMedium",
  //                                   color: gTextColor,
  //                                   fontSize: 8.sp),
  //                             ),
  //             
  //                             Text(
  //                               "09th Sep 2022 / 08:30 PM",
  //                               style: TextStyle(
  //                                   fontFamily: "GothamBook",
  //                                   color: gTextColor,
  //                                   fontSize: 8.sp),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       PopUpMenuWidget(
  //                         onView: () {},
  //                         onCall: () {},
  //                         onMessage: () {},
  //                       ),
  //                     ],
  //                   ),
  //                   Container(
  //                     height: 1,
  //                     margin: EdgeInsets.symmetric(vertical: 1.5.h),
  //                     color: Colors.grey.withOpacity(0.3),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // final MessageRepository chatRepository = MessageRepository(
  //   apiClient: ApiClient(
  //     httpClient: http.Client(),
  //   ),
  // );
  //
  // getSuccessChatGroupId(
  //     String userName, String profileImage, String userId) async {
  //   print(_pref.getInt(AppConfig.GET_QB_SESSION));
  //   print(_pref.getBool(AppConfig.IS_QB_LOGIN));
  //   print(_pref.getString(AppConfig.QB_CURRENT_USERID));
  //
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var chatUserName = preferences.getString(AppConfig.QB_USERNAME)!;
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
  //       _qbService.connect(int.parse("${_pref.getString(AppConfig.QB_CURRENT_USERID)}"));
  //     }
  //   }
  //   final res = await ChatService(repository: chatRepository)
  //       .getSuccessChatGroupIdService(userId);
  //
  //   if (res.runtimeType == GetChatGroupIdModel) {
  //     GetChatGroupIdModel model = res as GetChatGroupIdModel;
  //     // QuickBloxRepository().init(AppConfig.QB_APP_ID, AppConfig.QB_AUTH_KEY, AppConfig.QB_AUTH_SECRET, AppConfig.QB_ACCOUNT_KEY);
  //     _pref.setString(AppConfig.SUCCESS_GROUP_ID, model.group ?? '');
  //     print('model.group: ${model.group}');
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (c) => SuccessMessageScreen(
  //             isGroupId: true, userName: userName, profileImage: profileImage),
  //       ),
  //     );
  //   } else {
  //     ErrorModel model = res as ErrorModel;
  //     AppConfig()
  //         .showSnackBar(context, model.message.toString(), isError: true);
  //   }
  // }
}
