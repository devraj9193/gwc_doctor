import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/customers_list_models/consultation_list_model.dart';
import '../../model/customers_list_models/meal_active_model.dart';
import '../../model/error_model.dart';
import '../../model/maintenance_guide_model.dart';
import '../../repository/api_service.dart';
import '../../repository/customer_status_repo.dart/customer_status_repo.dart';
import '../../services/customer_status_service/customer_status_service.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_lists/active_list.dart';
import '../customer_screens/customers_lists/completed_list_screen.dart';
import '../customer_screens/customers_lists/consultation_list.dart';
import '../customer_screens/customers_lists/maintenance_guide_list.dart';
import '../customer_screens/customers_lists/meal_plan_list.dart';
import '../customer_screens/customers_lists/post_program_list.dart';
import 'package:http/http.dart' as http;

class CustomerStatusScreen extends StatefulWidget {
  const CustomerStatusScreen({Key? key}) : super(key: key);

  @override
  State<CustomerStatusScreen> createState() => _CustomerStatusScreenState();
}

class _CustomerStatusScreenState extends State<CustomerStatusScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  int consultationPendingListCount = 0;
  int mrListCount = 0;
  int mealListCount = 0;
  int activeListCount = 0;
  int ppListCount = 0;
  int maintenanceGuideListCount = 0;
  int completedListCount = 0;

  ConsultationModel? consultationModel;
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
      length: 6,
      vsync: this,
    );
  }

  getConsultationPendingCount() async {
    final result = await customerStatusService.getConsultationPendingService();
    print("result: $result");

    if (result.runtimeType == ConsultationModel) {
      print("Ticket List");
      ConsultationModel model = result as ConsultationModel;

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
    final result = await customerStatusService.getMealActiveService();
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
    final result = await customerStatusService.getPostProgramService();
    print("result: $result");

    if (result.runtimeType == MaintenanceGuideModel) {
      print("Ticket List");
      MaintenanceGuideModel model = result as MaintenanceGuideModel;

      maintenanceGuideModel = model;

      int? ppCount = maintenanceGuideModel?.postProgramList?.length;
      int? mgCount = maintenanceGuideModel?.gutMaintenanceGuide?.length;
      int? completedCount = maintenanceGuideModel?.gmgSubmitted?.length;

      setState(() {
        ppListCount = ppCount!;
        maintenanceGuideListCount = mgCount!;
        completedListCount = completedCount!;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: buildAppBar(() {
          Navigator.pop(context);
        }),
        body: Padding(
          padding: EdgeInsets.only(
            left: 0.w,
            right: 0.w,
            top: 0.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const DoctorStatusScreen(),
              // SizedBox(height: 2.h),
              TabBar(
                labelColor: tapSelectedColor,
                controller: tabController,
                unselectedLabelColor: tapUnSelectedColor,
                isScrollable: true,
                indicatorColor: tapIndicatorColor,
                labelPadding: EdgeInsets.only(
                    right: 12.w, left: 2.w, top: 1.h, bottom: 1.h),
                indicatorPadding: EdgeInsets.only(right: 7.w),
                labelStyle: TabBarText().selectedText(),
                unselectedLabelStyle: TabBarText().unSelectedText(),
                tabs: [
                  buildTapCount('Consultation', consultationPendingListCount),
                  // buildTapCount('MR & CS', mrListCount),
                  buildTapCount('Meal Plan', mealListCount),
                  buildTapCount('Active', activeListCount),
                  buildTapCount('Post Program', ppListCount),
                  buildTapCount('Maintenance Guide', maintenanceGuideListCount),
                  buildTapCount('Completed', completedListCount),
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 0.w, bottom: 1.h),
                color: gGreyColor.withOpacity(0.3),
                width: double.maxFinite,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      ConsultationList(),
                      // DocumentUploadList(),
                      CustomersMealPlanList(),
                      CustomersActiveList(),
                      PostProgramList(),
                      MaintenanceGuideList(),
                      CompletedList(),
                    ],
                  ),
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
}
