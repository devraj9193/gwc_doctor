import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controller/linked_customers_controller.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_lists/all_customer_active_list.dart';
import '../customer_screens/customers_lists/all_customer_consultation_list.dart';
import '../customer_screens/customers_lists/all_customer_maintenance_list.dart';
import '../customer_screens/customers_lists/all_customer_meal_list.dart';
import '../customer_screens/customers_lists/all_customer_pp_list.dart';

class AllCustomersList extends StatefulWidget {
  const AllCustomersList({Key? key}) : super(key: key);

  @override
  State<AllCustomersList> createState() => _AllCustomersListState();
}

class _AllCustomersListState extends State<AllCustomersList> {
  LinkedCustomersController linkedCustomersController =
      Get.put(LinkedCustomersController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
                  labelColor: tapSelectedColor,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  unselectedLabelColor: tapUnSelectedColor,
                  labelStyle:TabBarText().selectedText(),
                  unselectedLabelStyle: TabBarText().unSelectedText(),
                  isScrollable: true,
                  indicatorColor: tapIndicatorColor,
                  labelPadding:
                      EdgeInsets.only(right: 7.w,left: 2.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 5.w),
                  tabs: const [
                    Text('Consultation'),
                    Text('Meal Plan'),
                    Text('Active'),
                    Text('Post Program Consultation'),
                    Text('Maintenance Guide'),
                  ]),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: const TabBarView(children: [
                    AllCustomerConsultationList(),
                    AllCustomersMealList(),
                    AllCustomersActiveList(),
                    AllCustomerPostProgramList(),
                    AllCustomersMaintenanceGuideList(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
  //               isGroupId: true,
  //               userName: userName,
  //               profileImage: profileImage,
  //             )));
  //   } else {
  //     ErrorModel model = res as ErrorModel;
  //     AppConfig()
  //         .showSnackBar(context, model.message.toString(), isError: true);
  //   }
  // }
}
