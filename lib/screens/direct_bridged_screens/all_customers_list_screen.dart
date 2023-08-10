import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/customers_list_models/all_customer_consultation_model.dart';
import '../../model/customers_list_models/meal_active_model.dart';
import '../../model/error_model.dart';
import '../../model/maintenance_guide_model.dart';
import '../../repository/api_service.dart';
import '../../repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../services/customer_status_service/customer_status_service.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_lists/all_customers/all_customer_active_list.dart';
import '../customer_screens/customers_lists/all_customers/all_customer_consultation_list.dart';
import '../customer_screens/customers_lists/all_customers/all_customer_maintenance_list.dart';
import '../customer_screens/customers_lists/all_customers/all_customer_meal_list.dart';
import '../customer_screens/customers_lists/all_customers/all_customer_pp_list.dart';

class AllCustomersList extends StatefulWidget {
  const AllCustomersList({Key? key}) : super(key: key);

  @override
  State<AllCustomersList> createState() => _AllCustomersListState();
}

class _AllCustomersListState extends State<AllCustomersList> with SingleTickerProviderStateMixin {
  TabController? tabController;

  int consultationPendingListCount = 0;
  int mrListCount = 0;
  int mealListCount = 0;
  int activeListCount = 0;
  int ppListCount = 0;
  int maintenanceGuideListCount = 0;

  AllCustomerConsultationModel? consultationModel;
  MealActiveModel? mealActiveModel;
  MaintenanceGuideModel? maintenanceGuideModel;

  late final CustomerStatusService customerStatusService =
  CustomerStatusService(customerStatusRepo: repository);

  @override
  void initState() {
    super.initState();
    getConsultationPendingCount();
    getMealActiveCount();
    getPostProgramCount();
    tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  getConsultationPendingCount() async {
    final result = await customerStatusService.getAllConsultationPendingService();
    print("result: $result");

    if (result.runtimeType == AllCustomerConsultationModel) {
      print("Ticket List");
      AllCustomerConsultationModel model = result as AllCustomerConsultationModel;

      consultationModel = model;

      int? count = consultationModel?.appointmentList?.length;
      int? mrCount = consultationModel?.documentUpload?.length;

      setState(() {
        consultationPendingListCount = count!;
        mrListCount = mrCount!;
        print("consultationPendingListCount: $consultationPendingListCount");
        print("mrListCount: $mrListCount");
      });
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    print(result);
  }

  getMealActiveCount() async {
    final result = await customerStatusService.getAllMealActiveService();
    print("result: $result");

    if (result.runtimeType == MealActiveModel) {
      print("Ticket List");
      MealActiveModel model = result as MealActiveModel;

      mealActiveModel = model;

      int? mealCount = mealActiveModel?.mealPlanList?.length;

      int? activeCount = mealActiveModel?.activeDetails?.length;

      setState(() {
        mealListCount = mealCount!;
        activeListCount = activeCount!;
        print("mealListCount: $mealListCount");
        print("activeListCount: $activeListCount");
      });
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    print(result);
  }

  getPostProgramCount() async {
    final result = await customerStatusService.getAllPostProgramService();
    print("result: $result");

    if (result.runtimeType == MaintenanceGuideModel) {
      print("Ticket List");
      MaintenanceGuideModel model = result as MaintenanceGuideModel;

      maintenanceGuideModel = model;

      int? ppCount = maintenanceGuideModel?.postProgramList?.length;
      int? mgCount = maintenanceGuideModel?.gutMaintenanceGuide?.length;

      setState(() {
        ppListCount = ppCount!;
        maintenanceGuideListCount = mgCount!;
        print("ppListCount: $ppListCount");
        print("maintenanceGuideListCount: $maintenanceGuideListCount");
      });
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    print(result);
  }

  @override
  void dispose() async {
    super.dispose();
    tabController?.dispose();
  }

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
                  tabs: [
                    buildTapCount('Consultation', consultationPendingListCount),
                    buildTapCount('Meal Plan', mealListCount),
                    buildTapCount('Active', activeListCount),
                    buildTapCount('Post Program', ppListCount),
                    buildTapCount('Maintenance Guide', maintenanceGuideListCount),
                  ]),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 0.w, bottom: 1.h),
                color: gGreyColor.withOpacity(0.3),
                width: double.maxFinite,
              ),
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

  final CustomerStatusRepo repository = CustomerStatusRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
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
