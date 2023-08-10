import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../model/combined_meal_model/dailyProgressMealPlanModel.dart';
import '../../../model/day_tracker_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';

class SymptomTracker extends StatefulWidget {
  final String selectedDay;
  final String detoxOrHealing;
  const SymptomTracker(
      {Key? key, required this.selectedDay, required this.detoxOrHealing})
      : super(key: key);

  @override
  State<SymptomTracker> createState() => _SymptomTrackerState();
}

class _SymptomTrackerState extends State<SymptomTracker> {
  DailyProgressMealPlanModel? dailyProgressMealPlanModel;
  bool showProgress = false;
  Color? textColor;
  DayTracker? trackerDetails;
  List detoxificationList = [];
  List withdrawalList = [];
  List attachmentsList = [];

  @override
  void initState() {
    super.initState();
    getProgramData();
  }

  getProgramData() async {
    setState(() {
      showProgress = true;
    });
    final result = await ProgramService(repository: repository)
        .getDailyProgressMealService(widget.selectedDay, widget.detoxOrHealing);
    print("result: $result");

    if (result.runtimeType == DailyProgressMealPlanModel) {
      print("meal plan");
      DailyProgressMealPlanModel model = result as DailyProgressMealPlanModel;

      dailyProgressMealPlanModel = model;
      trackerDetails = model.userProgramStatusTracker;
      print("trackerDetails : $trackerDetails");
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    setState(() {
      showProgress = false;
    });
    print(result);
  }

  final ProgramRepository repository = ProgramRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                            color: gMainColor,
                            size: 2.h,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        SizedBox(
                          height: 5.h,
                          child: const Image(
                            image: AssetImage(
                                "assets/images/Gut wellness logo.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: gWhiteColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey.withOpacity(0.5))
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Day ${widget.selectedDay} Tracker',
                                      style:
                                          TabBarText().bottomSheetHeadingText(),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: newLightGreyColor, width: 1),
                                    ),
                                    child: Icon(
                                      Icons.clear,
                                      color: newLightGreyColor,
                                      size: 1.6.h,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5)
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 15.w),
                              height: 1,
                              color: newLightGreyColor,
                            ),
                            (showProgress)
                                ? Center(
                                    child: buildCircularIndicator(),
                                  )
                                : trackerDetails == null
                                    ? buildNoData()
                                    : Expanded(
                                        child: SingleChildScrollView(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 1.h),
                                              // Row(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.center,
                                              //   children: [
                                              //     Text("Gut Detox Program Status Tracker",
                                              //         textAlign: TextAlign.start,
                                              //         style:
                                              //             EvaluationText().headingText()),
                                              //     SizedBox(width: 2.w),
                                              //     Expanded(
                                              //       child: Container(
                                              //         height: 1,
                                              //         color: newLightGreyColor,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 1.5.h),
                                              // buildLabelTextField(
                                              //     "Have You Missed Anything In Your Meal Or Yoga Plan Today?"),
                                              // SizedBox(height: 1.h),
                                              // ...missedAnything.map(
                                              //   (e) => Row(
                                              //     children: [
                                              //       Radio<String>(
                                              //         value: e,
                                              //         activeColor: kPrimaryColor,
                                              //         visualDensity: const VisualDensity(
                                              //             vertical: VisualDensity
                                              //                 .minimumDensity,
                                              //             horizontal: VisualDensity
                                              //                 .minimumDensity),
                                              //         groupValue: buildTrackSelection(
                                              //             "${trackerDetails?.didUMiss.toString()}"),
                                              //         onChanged: (value) {},
                                              //       ),
                                              //       Text(
                                              //         e,
                                              //         style:
                                              //             EvaluationText().answerText(),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              // SizedBox(height: 1.h),
                                              // Row(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.center,
                                              //   children: [
                                              //     Text("Missed Items",
                                              //         textAlign: TextAlign.start,
                                              //         style:
                                              //             EvaluationText().headingText()),
                                              //     SizedBox(
                                              //       width: 2.w,
                                              //     ),
                                              //     Expanded(
                                              //       child: Container(
                                              //         height: 1,
                                              //         color: newLightGreyColor,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(
                                              //   height: 2.h,
                                              // ),
                                              // buildLabelTextField(
                                              //     "What Did you Miss In Your Meal Plan Or Yoga Today?"),
                                              // SizedBox(
                                              //   height: 1.h,
                                              // ),
                                              // Text(trackerDetails?.didUMissAnything ?? "",
                                              //     textAlign: TextAlign.start,
                                              //     style: EvaluationText().answerText()),
                                              // SizedBox(
                                              //   height: 2.h,
                                              // ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text("Symptom Tracker",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: EvaluationText()
                                                          .headingText()),
                                                  SizedBox(width: 2.w),
                                                  Expanded(
                                                    child: Container(
                                                      height: 1,
                                                      color: newLightGreyColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              buildLabelTextField(
                                                  'Did you deal with any of the following withdrawal symptoms from detox today? If "Yes," then choose all that apply. If no, choose none of the above.'),
                                              SizedBox(height: 1.h),
                                              withdrawalCheckBox(
                                                  "${trackerDetails?.withdrawalSymptoms}"),
                                              // getSymptom(),
                                              // ...symptomsCheckBox1
                                              //     .map((e) =>
                                              //         buildHealthCheckBox(e, '1'))
                                              //     .toList(),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                color: newLightGreyColor,
                                              ),
                                              SizedBox(height: 1.h),
                                              buildLabelTextField(
                                                  'Did any of the following (adequate) detoxification / healing signs and symptoms happen to you today? If "Yes," then choose all that apply. If no, choose none of the above.'),
                                              SizedBox(height: 1.h),
                                              detoxificationCheckBox(
                                                  "${trackerDetails?.detoxification}"),
                                              // getSymptom1(),
                                              // ...symptomsCheckBox2
                                              //     .map((e) =>
                                              //         buildHealthCheckBox(e, '2'))
                                              //     .toList(),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                color: newLightGreyColor,
                                              ),
                                              SizedBox(height: 1.h),
                                              buildLabelTextField(
                                                  'Please let us know if you notice any other signs or have any other worries. If none, enter "No."'),
                                              SizedBox(height: 1.h),
                                              Text(
                                                  trackerDetails
                                                          ?.haveAnyOtherWorries ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                  style: EvaluationText()
                                                      .answerText()),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                color: newLightGreyColor,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              buildLabelTextField(
                                                  'Did you eat something other than what was on your meal plan? If "Yes", please give more information? If not, type "No."'),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                  trackerDetails
                                                          ?.eatSomethingOther ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                  style: EvaluationText()
                                                      .answerText()),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                color: newLightGreyColor,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              buildLabelTextField(
                                                  'Did you complete the Calm and Move modules suggested today?'),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 25,
                                                        child: Radio(
                                                          value: "Yes",
                                                          activeColor:
                                                              kPrimaryColor,
                                                          visualDensity: const VisualDensity(
                                                              vertical:
                                                                  VisualDensity
                                                                      .minimumDensity,
                                                              horizontal:
                                                                  VisualDensity
                                                                      .minimumDensity),
                                                          groupValue: trackerDetails
                                                              ?.completedCalmMoveModules,
                                                          onChanged: (value) {},
                                                        ),
                                                      ),
                                                      Text('Yes',
                                                          style: EvaluationText()
                                                              .answerText()),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 25,
                                                        child: Radio(
                                                          value: "No",
                                                          visualDensity: const VisualDensity(
                                                              vertical:
                                                                  VisualDensity
                                                                      .minimumDensity,
                                                              horizontal:
                                                                  VisualDensity
                                                                      .minimumDensity),
                                                          activeColor:
                                                              kPrimaryColor,
                                                          groupValue: trackerDetails
                                                              ?.completedCalmMoveModules,
                                                          onChanged: (value) {},
                                                        ),
                                                      ),
                                                      Text('No',
                                                          style: EvaluationText()
                                                              .answerText()),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                color: newLightGreyColor,
                                              ),
                                              buildLabelTextField(
                                                  'Have you had a medical exam or taken any medications during the program? If "Yes", please give more information. Type "No" if not.'),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                  trackerDetails
                                                          ?.hadAMedicalExamMedications ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                  style: EvaluationText()
                                                      .answerText()),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              // showAttachments(
                                              //     "${trackerDetails?.trackingAttachment}"),
                                            ],
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  withdrawalCheckBox(String withdrawal) {
    print(jsonDecode(withdrawal));
    withdrawalList = jsonDecode(withdrawal)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split('\/');
    print("List : $withdrawalList");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: withdrawalList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_box_outlined,
                color: gSecondaryColor,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  withdrawalList[index] ?? "",
                  style: EvaluationText().answerText(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  detoxificationCheckBox(String detoxification) {
    print(jsonDecode(detoxification));
    detoxificationList = jsonDecode(detoxification)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split('\/');
    print("List : $detoxificationList");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: detoxificationList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_box_outlined,
                color: gSecondaryColor,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  detoxificationList[index] ?? "",
                  style: EvaluationText().answerText(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showAttachments(String attachments) {
    print(attachments);
    attachmentsList = jsonDecode(attachments)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print("List : $attachmentsList");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: attachmentsList.length,
      itemBuilder: (context, index) {
        return Image(
          image: NetworkImage(
            attachmentsList[index],
          ),
        );
      },
    );
  }
}
