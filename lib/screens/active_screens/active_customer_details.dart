import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customer_meal_plans/preparatory_meal_plans.dart';
import '../customer_screens/customer_meal_plans/transition_meal_plan.dart';
import '../customer_screens/customers_details/case_study_details.dart';
import '../customer_screens/customers_details/evaluation_get_details.dart';
import '../customer_screens/customers_details/medical_report_details.dart';
import '../customer_screens/customers_details/user_reports_details.dart';
import '../customer_screens/customers_details/daily_progress_screens/progress_details.dart';
import '../customer_screens/customer_meal_plans/day_plan_details.dart';

class ActiveCustomerDetails extends StatefulWidget {
  final String userName;
  final String age;
  final String appointmentDetails;
  final String status;
  final String startDate;
  final String presentDay;
  final String finalDiagnosis;
  final String preparatoryCurrentDay;
  final String transitionCurrentDay;
  const ActiveCustomerDetails(
      {Key? key,
      required this.userName,
      required this.age,
      required this.appointmentDetails,
      required this.status,
      required this.startDate,
      required this.presentDay,
      required this.finalDiagnosis,
      required this.preparatoryCurrentDay,
      required this.transitionCurrentDay})
      : super(key: key);

  @override
  State<ActiveCustomerDetails> createState() => _ActiveCustomerDetailsState();
}

class _ActiveCustomerDetailsState extends State<ActiveCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
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
                  style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gTextColor,
                      fontSize: 10.sp),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  widget.age,
                  style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gTextColor,
                      fontSize: 8.sp),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  widget.appointmentDetails,
                  style: TextStyle(
                      fontFamily: "GothamBook",
                      color: gTextColor,
                      fontSize: 8.sp),
                ),
                SizedBox(height: 0.5.h),
                (widget.status.isEmpty)
                    ? Container()
                    : Row(
                        children: [
                          Text(
                            "Status : ",
                            style: TextStyle(
                                fontFamily: "GothamBook",
                                color: gBlackColor,
                                fontSize: 8.sp),
                          ),
                          Text(
                            widget.status,
                            style: TextStyle(
                                fontFamily: "GothamMedium",
                                color: gPrimaryColor,
                                fontSize: 8.sp),
                          ),
                        ],
                      ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Text(
                      "Start Date : ",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 8.sp),
                    ),
                    Text(
                      widget.startDate,
                      style: TextStyle(
                          fontFamily: "GothamMedium",
                          color: gPrimaryColor,
                          fontSize: 8.sp),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Text(
                      "Present Day : ",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 8.sp),
                    ),
                    Text(
                      widget.presentDay,
                      style: TextStyle(
                          fontFamily: "GothamMedium",
                          color: gPrimaryColor,
                          fontSize: 8.sp),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Final Diagnosis : ",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 8.sp),
                    ),
                    Expanded(
                      child: Text(
                        widget.finalDiagnosis,
                        style: TextStyle(
                            fontFamily: "GothamMedium",
                            color: gPrimaryColor,
                            fontSize: 8.sp),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 1.h),
                TabBar(
                    // padding: EdgeInsets.symmetric(horizontal: 3.w),
                    labelColor: gPrimaryColor,
                    unselectedLabelColor: gTextColor,
                    isScrollable: true,
                    indicatorColor: gPrimaryColor,
                    labelPadding:
                        EdgeInsets.only(right: 6.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 5.w),
                    unselectedLabelStyle: TextStyle(
                        fontFamily: "GothamBook",
                        color: gGreyColor,
                        fontSize: 9.sp),
                    labelStyle: TextStyle(
                        fontFamily: "GothamMedium",
                        color: gPrimaryColor,
                        fontSize: 10.sp),
                    tabs: const [
                      Text('Preparatory'),
                      Text('Daily Progress'),
                      Text("Meal & Yoga Plan"),
                      Text('Transition'),
                      Text('Evaluation'),
                      Text('User Reports'),
                      Text('Medical Report'),
                      Text('Case Study'),
                    ]),
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        PreparatoryMealPlan(
                          preparatoryCurrentDay: widget.preparatoryCurrentDay,
                        ),
                        const ProgressDetails(),
                        const DayPlanDetails(),
                        TransitionMealPlan(
                          transitionCurrentDay: widget.transitionCurrentDay,
                          isTransition: true,
                        ),
                        const EvaluationGetDetails(),
                        const UserReportsDetails(),
                        const MedicalReportDetails(),
                        const CaseStudyDetails(),
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
