import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/customers_list_models/meal_active_model.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_details/case_study_details.dart';
import '../post_programs_screens/medical_feedback_answer.dart';
import 'call_chat_icons.dart';
import 'daily_progress_screens/progress_details.dart';
import '../customer_screens/customers_details/evaluation_get_details.dart';
import '../customer_screens/customers_details/medical_report_details.dart';
import '../customer_screens/customers_details/user_reports_details.dart';
import 'nutri_delight_detox.dart';
import 'nutri_delight_healing.dart';
import 'nutri_delight_nourish.dart';
import 'nutri_delight_preparatory.dart';

class NutriDelightScreen extends StatefulWidget {
  final int tabIndex;
  final int userId;
  final String userName;
  final String age;
  final String appointmentDetails;
  final String status;
  final String? iconStatus;
  final String updateDate;
  final String updateTime;
  final String finalDiagnosis;
  final String preparatoryCurrentDay;
  final String transitionCurrentDay;
  final String isPrepCompleted;
  final String isProgramStatus;
  final String programDaysStatus;
  final UserProgram? userProgram;

  const NutriDelightScreen(
      {Key? key,
      required this.userName,
      required this.age,
      required this.appointmentDetails,
      required this.status,
      this.iconStatus,
      required this.updateTime,
      required this.updateDate,
      required this.finalDiagnosis,
      required this.preparatoryCurrentDay,
      required this.transitionCurrentDay,
      required this.isPrepCompleted,
      required this.isProgramStatus,
      required this.programDaysStatus,
      required this.userId,
      required this.tabIndex,
      this.userProgram})
      : super(key: key);

  @override
  State<NutriDelightScreen> createState() => _NutriDelightScreenState();
}

class _NutriDelightScreenState extends State<NutriDelightScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  // bool showProgress = false;
  // ChildPrepModel? _childPrepModel;
  //
  // ChildDetoxModel? _childDetoxModel, _childHealingModel;
  //
  // ChildNourishModel? _childNourishModel;
  //
  // String? totalDaysOfPreparatory, totalDaysOfNourish;
  //
  // getProgramData() async {
  //   setState(() {
  //     showProgress = true;
  //   });
  //   final result =
  //       await ProgramService(repository: repository).getCombinedMealService();
  //   print("result: $result");
  //
  //   if (result.runtimeType == CombinedMealModel) {
  //     print("meal plan");
  //     CombinedMealModel model = result as CombinedMealModel;
  //
  //     print('prep.values:${model.prep!.childPrepModel!.details}');
  //     _childPrepModel = model.prep!.childPrepModel;
  //     totalDaysOfPreparatory = model.prep?.totalDays.toString();
  //
  //     if (model.detox != null) {
  //       _childDetoxModel = model.detox!.value;
  //     }
  //     if (model.healing != null) {
  //       _childHealingModel = model.healing!.value;
  //     }
  //
  //     if (model.nourish != null) {
  //       _childNourishModel = model.nourish!.value;
  //       totalDaysOfNourish = model.nourish?.totalDays.toString();
  //     }
  //
  //     print('detox.values:${model.detox!.value!.details!.entries}');
  //     model.detox!.value!.details!.forEach((key, value) {
  //       print("day: $key");
  //       print(value.toMap());
  //       value.data!.forEach((k, v1) {
  //         print("$k -- $v1");
  //       });
  //     });
  //
  //     print('healing.values:${model.healing!.value!.details!.entries}');
  //     model.healing!.value!.details!.forEach((key, value) {
  //       print("day: $key");
  //       print(value.toMap());
  //       value.data!.forEach((k, v1) {
  //         print("$k -- $v1");
  //       });
  //     });
  //     print('nourish.values:${model.nourish!.value}');
  //   } else {
  //     ErrorModel model = result as ErrorModel;
  //     print("error: ${model.message}");
  //     // errorMsg = model.message ?? '';
  //     // Future.delayed(Duration(seconds: 0)).whenComplete(() {
  //     //   setState(() {
  //     //     showShimmer = false;
  //     //     isLoading = false;
  //     //   });
  //     //   showAlert(context, model.status!,
  //     //       isSingleButton: !(model.status != '401'), positiveButton: () {
  //     //         if (model.status == '401') {
  //     //           Navigator.pop(context);
  //     //           Navigator.pop(context);
  //     //         } else {
  //     //           getMeals();
  //     //           Navigator.pop(context);
  //     //         }
  //     //       });
  //     // });
  //   }
  //   setState(() {
  //     showProgress = false;
  //   });
  //   print(result);
  // }
  //
  // final ProgramRepository repository = ProgramRepository(
  //   apiClient: ApiClient(
  //     httpClient: http.Client(),
  //   ),
  // );
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getProgramData();
  // }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: widget.tabIndex,
      length: 10,
      vsync: this,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      appBar: AppBar(
        backgroundColor: gWhiteColor,
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: gSecondaryColor,
                size: 2.h,
              ),
            ),
            SizedBox(width: 2.w),
            SizedBox(
              height: 5.h,
              child: const Image(
                image: AssetImage("assets/images/Gut wellness logo.png"),
              ),
            ),
          ],
        ),
        actions: [
          CallChatIcons(
            userId: widget.userId,
            kaleyraUserId: '',
            chat: true,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: AllListText().headingText(),
              ),
              widget.age.isNotEmpty
                  ? Text(
                      widget.age,
                      style: AllListText().subHeadingText(),
                    )
                  : const SizedBox(),
              Text(
                widget.appointmentDetails,
                style: AllListText().otherText(),
              ),
              widget.status.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status : ",
                          style: AllListText().otherText(),
                        ),
                        widget.isProgramStatus.isNotEmpty
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.isProgramStatus.isNotEmpty
                                ? Text(
                              widget.isProgramStatus,
                              style: AllListText().getProgramStatus(),
                            )
                                : const SizedBox(),
                            widget.programDaysStatus.isNotEmpty
                                ? Text(
                              widget.programDaysStatus,
                              style: AllListText().getProgramStatus(),
                            )
                                : const SizedBox(),
                          ],
                        ):
                        Text(
                          widget.status,
                          style: AllListText().subHeadingText(),
                        ),
                        SizedBox(width: 1.w),
                        buildIconWidget("${widget.iconStatus}"),
                        buildActiveIconWidget(
                          widget.userProgram?.isPreparatoryCompleted
                                  .toString() ??
                              '',
                          widget.userProgram?.detoxProgram.toString() ?? '',
                          widget.userProgram?.isDetoxCompleted.toString() ?? '',
                          widget.userProgram?.healingProgram.toString() ?? '',
                          widget.userProgram?.isHealingCompleted.toString() ??
                              '',
                          widget.userProgram?.nourishProgram.toString() ?? '',
                        ),
                      ],
                    )
                  : SizedBox(height: 1.h),
              widget.updateDate.isEmpty
                  ? const SizedBox()
                  : buildUpdatedTime("${widget.iconStatus}", widget.updateDate,
                      widget.updateTime),

              widget.finalDiagnosis.isNotEmpty
                  ? Row(
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
                    )
                  : const SizedBox(),
              TabBar(
                // padding: EdgeInsets.symmetric(horizontal: 3.w),
                controller: tabController,
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
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const EvaluationGetDetails(),
                    const UserReportsDetails(),
                    MedicalReportDetails(userId: widget.userId),
                    CaseStudyDetails(userId: widget.userId),
                    ProgressDetails(userId: widget.userId),
                    NutriDelightPreparatory(userId: widget.userId),
                    // PreparatoryMealPlan(
                    //   preparatoryCurrentDay:
                    //       widget.preparatoryCurrentDay,
                    //   ppCurrentDay: '',
                    //   presDay: '',
                    //   isPrepCompleted: widget.isPrepCompleted,
                    // ),
                    NutriDelightDetox(userId: widget.userId),
                    NutriDelightHealing(userId: widget.userId),
                    NutriDelightNourish(userId: widget.userId),
                    const MedicalFeedbackAnswer(),
                    // TransitionMealPlan(
                    //   transitionCurrentDay:
                    //       widget.transitionCurrentDay,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // DefaultTabController(
    //       length: 8,
    //       child: SafeArea(
    //         child: Scaffold(
    //           backgroundColor: gWhiteColor,
    //           appBar: buildAppBar(() {
    //             Navigator.pop(context);
    //           }),
    //           body: Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 3.w),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   widget.userName,
    //                   style: AllListText().headingText(),
    //                 ),
    //                 Text(
    //                   widget.age,
    //                   style: AllListText().subHeadingText(),
    //                 ),
    //                 Text(
    //                   widget.appointmentDetails,
    //                   style: AllListText().otherText(),
    //                 ),
    //                 Row(
    //                   children: [
    //                     Text(
    //                       "Status : ",
    //                       style: AllListText().otherText(),
    //                     ),
    //                     Text(
    //                       widget.status,
    //                       style: AllListText().subHeadingText(),
    //                     ),
    //                   ],
    //                 ),
    //                 widget.finalDiagnosis.isNotEmpty
    //                     ? Row(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             "Final Diagnosis : ",
    //                             style: AllListText().otherText(),
    //                           ),
    //                           Expanded(
    //                             child: RichText(
    //                               text: TextSpan(
    //                                 children: <TextSpan>[
    //                                   TextSpan(
    //                                     text: widget.finalDiagnosis,
    //                                     style: AllListText().subHeadingText(),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       )
    //                     : const SizedBox(),
    //                 TabBar(
    //                     // padding: EdgeInsets.symmetric(horizontal: 3.w),
    //                     labelColor: tapSelectedColor,
    //                     unselectedLabelColor: tapUnSelectedColor,
    //                     isScrollable: true,
    //                     indicatorColor: tapIndicatorColor,
    //                     labelStyle: TabBarText().selectedText(),
    //                     unselectedLabelStyle: TabBarText().unSelectedText(),
    //                     labelPadding: EdgeInsets.only(
    //                         right: 6.w, left: 2.w, top: 1.h, bottom: 1.h),
    //                     indicatorPadding: EdgeInsets.only(right: 5.w),
    //                     tabs: const [
    //                       Text('Preparatory'),
    //                       Text("Detox"),
    //                       Text('Healing'),
    //                       Text('Nourish'),
    //                       Text('Evaluation'),
    //                       Text('User Reports'),
    //                       Text('Medical Report'),
    //                       Text('Case Sheet'),
    //                     ]),
    //                 Expanded(
    //                   child: TabBarView(
    //                       physics: const NeverScrollableScrollPhysics(),
    //                       children: [
    //                         NutriDelightPreparatory(userId: widget.userId),
    //                         // PreparatoryMealPlan(
    //                         //   preparatoryCurrentDay:
    //                         //       widget.preparatoryCurrentDay,
    //                         //   ppCurrentDay: '',
    //                         //   presDay: '',
    //                         //   isPrepCompleted: widget.isPrepCompleted,
    //                         // ),
    //                         NutriDelightDetox(userId: widget.userId),
    //                         NutriDelightHealing(userId: widget.userId),
    //                         NutriDelightNourish(userId: widget.userId),
    //                         // const DayPlanDetails(),
    //                         // const DayPlanDetails(),
    //                         // TransitionMealPlan(
    //                         //   transitionCurrentDay:
    //                         //       widget.transitionCurrentDay,
    //                         // ),
    //                         const EvaluationGetDetails(),
    //                         const UserReportsDetails(),
    //                         const MedicalReportDetails(),
    //                         const CaseStudyDetails(),
    //                       ]),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     )
  }
}
