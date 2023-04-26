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
import '../customer_screens/customer_meal_plans/day_plan_details.dart';

class MealsCustomerDetails extends StatefulWidget {
  final String userName;
  final String age;
  final String appointmentDetails;
  final String status;
  final String finalDiagnosis;
  final String preparatoryCurrentDay;
  final String transitionCurrentDay;
  const MealsCustomerDetails(
      {Key? key,
      required this.userName,
      required this.age,
      required this.appointmentDetails,
      required this.status,
      required this.finalDiagnosis,
      required this.preparatoryCurrentDay,
      required this.transitionCurrentDay})
      : super(key: key);

  @override
  State<MealsCustomerDetails> createState() => _MealsCustomerDetailsState();
}

class _MealsCustomerDetailsState extends State<MealsCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Final Diagnosis : ",
                      style: AllListText().otherText(),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.finalDiagnosis,
                              style: AllListText().subHeadingText(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                TabBar(
                    // padding: EdgeInsets.symmetric(horizontal: 3.w),
                    labelColor: tapSelectedColor,
                    unselectedLabelColor: tapUnSelectedColor,
                    isScrollable: true,
                    indicatorColor: tapIndicatorColor,
                    labelStyle:TabBarText().selectedText(),
                    unselectedLabelStyle: TabBarText().unSelectedText(),
                    labelPadding:
                        EdgeInsets.only(right: 6.w,left: 2.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 5.w),
                    tabs: const [
                      Text('Preparatory'),
                      Text("Meal & Yoga Plan"),
                      Text('Transition'),
                      Text('Evaluation'),
                      Text('User Reports'),
                      Text('Medical Report'),
                      Text('Case Sheet'),
                    ]),
                Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PreparatoryMealPlan(
                          preparatoryCurrentDay: widget.preparatoryCurrentDay, ppCurrentDay: '', presDay: '',
                        ),
                        const DayPlanDetails(),
                        TransitionMealPlan(
                          transitionCurrentDay: widget.transitionCurrentDay,
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
