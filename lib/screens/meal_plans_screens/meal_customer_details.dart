import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/case_study_details.dart';
import '../customer_screens/evaluation_form_screens/evaluation_details.dart';
import '../customer_screens/medical_report_details.dart';
import '../customer_screens/user_reports_details.dart';
import 'day_plan_details.dart';

class MealsCustomerDetails extends StatefulWidget {
  const MealsCustomerDetails({Key? key}) : super(key: key);

  @override
  State<MealsCustomerDetails> createState() => _MealsCustomerDetailsState();
}

class _MealsCustomerDetailsState extends State<MealsCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                buildAppBar(() {
                  Navigator.pop(context);
                }),
                SizedBox(height: 1.h),
                TabBar(
                    // padding: EdgeInsets.symmetric(horizontal: 3.w),
                    labelColor: gPrimaryColor,
                    unselectedLabelColor: gTextColor,
                    isScrollable: true,
                    indicatorColor: gPrimaryColor,
                    labelPadding:
                        EdgeInsets.only(right: 6.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 5.w),
                    labelStyle: TextStyle(
                        fontFamily: "GothamMedium",
                        color: gPrimaryColor,
                        fontSize: 10.sp),
                    tabs: const [
                      Text('Meal & Yoga Plan'),
                      Text('Evaluation'),
                      Text('User Reports'),
                      Text('Medical Report'),
                      Text('Case Study'),
                    ]),
                const Expanded(
                  child: TabBarView(children: [
                    DayPlanDetails(),
                    EvaluationDetails(),
                    UserReportsDetails(),
                    MedicalReportDetails(),
                    CaseStudyDetails(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
