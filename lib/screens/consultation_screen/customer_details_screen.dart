import 'package:doctor_app_new/screens/customer_screens/customers_details/user_reports_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_details/case_study_details.dart';
import '../customer_screens/customers_details/evaluation_get_details.dart';
import '../customer_screens/customers_details/medical_report_details.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final String userName;
  final String age;
  final String appointmentDetails;
  final String status;
  const CustomerDetailsScreen(
      {Key? key,
      required this.userName,
      required this.age,
      required this.appointmentDetails,
      required this.status})
      : super(key: key);

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
          backgroundColor: gWhiteColor,
          appBar: buildAppBar(() {
            Navigator.pop(context);
          }),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                Text(
                  widget.userName,
                  style: AllListText().headingText(),
                ),
                Text(
                  widget.age,
                  style: AllListText().subHeadingText(),
                ),
                Text(
                  widget.appointmentDetails,
                  style: AllListText().otherText(),
                ),
                Row(
                  children: [
                    Text(
                      "Status : ",
                      style: AllListText().otherText(),
                    ),
                    Text(
                      widget.status,
                      style: AllListText().subHeadingText(),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                TabBar(
                  labelColor: tapSelectedColor,
                  unselectedLabelColor: tapUnSelectedColor,
                  isScrollable: true,
                  indicatorColor: tapIndicatorColor,
                  labelStyle: TabBarText().selectedText(),
                  unselectedLabelStyle: TabBarText().unSelectedText(),
                  labelPadding: EdgeInsets.only(
                      right: 6.w, left: 2.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 5.w),
                  tabs: const [
                    Text('Evaluation'),
                    Text('User Reports'),
                    Text('Medical Report'),
                    Text('Case Sheet'),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      EvaluationGetDetails(),
                      UserReportsDetails(),
                      MedicalReportDetails(
                        userId: 0,
                      ),
                      CaseStudyDetails(
                        userId: 0,
                      ),
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
}
