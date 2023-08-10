import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customer_meal_plans/preparatory_meal_plans.dart';
import '../customer_screens/customer_meal_plans/transition_meal_plan.dart';
import '../customer_screens/customers_details/case_study_details.dart';
import '../customer_screens/customers_details/evaluation_get_details.dart';
import '../customer_screens/customers_details/medical_report_details.dart';
import '../customer_screens/customers_details/user_reports_details.dart';
import '../nutri_delight_screens/daily_progress_screens/progress_details.dart';
import '../customer_screens/customer_meal_plans/day_plan_details.dart';

class ActiveCustomerDetails extends StatefulWidget {
  final int userId;
  final String userName;
  final String age;
  final String appointmentDetails;
  final String status;
  final String startDate;
  final String presentDay;
  final String finalDiagnosis;
  final String preparatoryCurrentDay;
  final String transitionCurrentDay;
  final String transitionDays;
  final String prepDays;
  final String isPrepCompleted;
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
      required this.transitionCurrentDay,
      required this.transitionDays,
      required this.prepDays,
      required this.isPrepCompleted, required this.userId})
      : super(key: key);

  @override
  State<ActiveCustomerDetails> createState() => _ActiveCustomerDetailsState();
}

class _ActiveCustomerDetailsState extends State<ActiveCustomerDetails> {
  String transitionCurrentDay = "";
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
                (widget.status.isEmpty)
                    ? Container()
                    : Row(
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
                Row(
                  children: [
                    Text(
                      "Start Date : ",
                      style: AllListText().otherText(),
                    ),
                    Text(
                      widget.startDate,
                      style: AllListText().subHeadingText(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Meal Plan Present Day : ",
                      style: AllListText().otherText(),
                    ),
                    Text(
                      "${widget.presentDay} / 7 Days",
                      style: AllListText().subHeadingText(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Transition Present Day : ",
                      style: AllListText().otherText(),
                    ),
                    Text(
                      "${buildCurrentDay(widget.transitionCurrentDay)} / ${widget.transitionDays} Days",
                      style: AllListText().subHeadingText(),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Final Diagnosis : ",
                      style: AllListText().otherText(),
                    ),
                    Expanded(
                      child: Text(
                        widget.finalDiagnosis,
                        style: AllListText().subHeadingText(),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 1.h),
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
                      Text('Daily Progress'),
                      Text("Meal & Yoga Plan"),
                      Text('Transition'),
                      Text('Preparatory'),
                      Text('Evaluation'),
                      Text('User Reports'),
                      Text('Medical Report'),
                      Text('Case Sheet'),
                    ]),
                Expanded(
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                         ProgressDetails(userId: widget.userId),
                        const DayPlanDetails(),
                        TransitionMealPlan(
                          transitionCurrentDay: widget.transitionCurrentDay,
                          isTransition: true,
                        ),
                        PreparatoryMealPlan(
                          preparatoryCurrentDay: widget.preparatoryCurrentDay,
                          ppCurrentDay: widget.preparatoryCurrentDay,
                          presDay: widget.prepDays,
                          isPrepCompleted: widget.isPrepCompleted,
                        ),
                        const EvaluationGetDetails(),
                        const UserReportsDetails(),
                        const MedicalReportDetails(userId: 0,),
                        const CaseStudyDetails(userId: 0,),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCurrentDay(String transition) {
    print("TTT : $transition");
    if (transition == "null") {
      return "0";
    } else {
      return transition;
    }
  }
}
