import 'package:doctor_app_new/screens/post_programs_screens/post_program_details.dart';
import 'package:doctor_app_new/screens/daily_progress_screens/progress_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/case_study_details.dart';
import '../customer_screens/evaluation_form_screens/evaluation_details.dart';
import '../customer_screens/medical_report_details.dart';
import '../customer_screens/user_reports_details.dart';
import '../meal_plans_screens/day_plan_details.dart';
import '../meal_plans_screens/meal_yoga_plan_details.dart';

class PostCustomerDetails extends StatefulWidget {
  const PostCustomerDetails({Key? key}) : super(key: key);

  @override
  State<PostCustomerDetails> createState() => _PostCustomerDetailsState();
}

class _PostCustomerDetailsState extends State<PostCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      initialIndex: 5,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: buildAppBar(() {
                  Navigator.pop(context);
                }),
              ),
              SizedBox(height: 1.h),
              TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                    Text('Evaluation'),
                    Text('User Reports'),
                    Text('Medical Report'),
                    Text('Case Study'),
                    Text('Meal & Yoga Plan'),
                    Text('Progress'),
                    Text('Post Program'),
                  ]),
              const Expanded(
                child: TabBarView(children: [
                  EvaluationDetails(),
                  UserReportsDetails(),
                  MedicalReportDetails(),
                  CaseStudyDetails(),
                  DayPlanDetails(),
                  ProgressDetails(),
                  PostProgramDetails()
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
