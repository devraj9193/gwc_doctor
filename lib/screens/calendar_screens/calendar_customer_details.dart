import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/customer_profile_model.dart';
import '../../model/error_model.dart';
import '../../repository/api_service.dart';
import '../../repository/customer_details_repo/customer_profile_repo.dart';
import '../../services/customer_details_service/customer_profile_service.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_details/case_study_details.dart';
import '../customer_screens/customers_details/evaluation_get_details.dart';
import '../customer_screens/customers_details/medical_report_details.dart';
import '../nutri_delight_screens/daily_progress_screens/progress_details.dart';
import '../nutri_delight_screens/nutri_delight_detox.dart';
import '../nutri_delight_screens/nutri_delight_healing.dart';
import '../nutri_delight_screens/nutri_delight_nourish.dart';
import '../nutri_delight_screens/nutri_delight_preparatory.dart';
import '../post_programs_screens/medical_feedback_answer.dart';
import 'package:http/http.dart' as http;

class CalendarCustomerDetails extends StatefulWidget {
  final int userId;

  const CalendarCustomerDetails({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<CalendarCustomerDetails> createState() =>
      _CalendarCustomerDetailsState();
}

class _CalendarCustomerDetailsState extends State<CalendarCustomerDetails> {
  GetCustomerModel? getCustomerModel;
  String userName = "";
  String appointmentDetails = '';
  String userAge = '';
  bool showProgress = false;

  late final CustomerProfileService customerProfileService =
      CustomerProfileService(customerProfileRepo: repository);

  @override
  void initState() {
    super.initState();
    getCustomerDetails();
  }

  getCustomerDetails() async {
    setState(() {
      showProgress = true;
    });
    final result = await customerProfileService
        .getCustomerProfileService(widget.userId.toString());
    print("result: $result");

    if (result.runtimeType == GetCustomerModel) {
      print("Customer Profile");
      GetCustomerModel model = result as GetCustomerModel;

      getCustomerModel = model;
      setState(() {
        userName = "${getCustomerModel?.username}";
        userAge = "${getCustomerModel?.age}";
        appointmentDetails = buildTimeDate(
            getCustomerModel?.consultationDateAndTime?.date ?? "",
            getCustomerModel?.consultationDateAndTime?.slotStartTime ?? "");

        print("userName : $userName");
        print("userAge : $userAge");
        print("appointmentDetails : $appointmentDetails");
      });
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    setState(() {
      showProgress = false;
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gWhiteColor,
          appBar: buildAppBar(() {
            Navigator.pop(context);
          }),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AllListText().headingText(),
                ),
                Row(
                  children: [
                    Text(
                      "Age : ",
                      style: AllListText().otherText(),
                    ),
                    Text(
                      userAge,
                      style: AllListText().subHeadingText(),
                    ),
                  ],
                ),
                Text(
                  appointmentDetails,
                  style: AllListText().otherText(),
                ),
                TabBar(
                  // padding: EdgeInsets.symmetric(horizontal: 3.w),
                  labelColor: tapSelectedColor,
                  unselectedLabelColor: tapUnSelectedColor,
                  isScrollable: true,
                  indicatorColor: tapIndicatorColor,
                  labelPadding: EdgeInsets.only(
                      right: 6.w, left: 2.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 5.w),
                  labelStyle: TabBarText().selectedText(),
                  unselectedLabelStyle: TabBarText().unSelectedText(),
                  tabs: const [
                    Text('Evaluation'),
                    // Text('User Reports'),
                    Text('Medical Report'),
                    Text('Case Sheet'),
                    Text('Daily Progress'),
                    Text('Preparatory'),
                    Text("Detox"),
                    Text('Healing'),
                    Text('Nourish'),
                    Text('Medical Feedback'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const EvaluationGetDetails(),
                      // const UserReportsDetails(),
                      MedicalReportDetails(userId: widget.userId),
                      CaseStudyDetails(userId: widget.userId),
                      ProgressDetails(userId: widget.userId),
                      NutriDelightPreparatory(userId: widget.userId),
                      NutriDelightDetox(userId: widget.userId),
                      NutriDelightHealing(userId: widget.userId),
                      NutriDelightNourish(userId: widget.userId),
                      const MedicalFeedbackAnswer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final CustomerProfileRepo repository = CustomerProfileRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}
