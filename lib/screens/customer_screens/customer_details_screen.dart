import 'package:doctor_app_new/screens/customer_screens/user_reports_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'case_study_details.dart';
import 'evaluation_form_screens/evaluation_details.dart';
import 'medical_report_details.dart';

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 1.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(() {
                  Navigator.pop(context);
                }),
                SizedBox(height: 1.h),
                TabBar(
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
                    ]),
                const Expanded(
                  child: TabBarView(children: [
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
