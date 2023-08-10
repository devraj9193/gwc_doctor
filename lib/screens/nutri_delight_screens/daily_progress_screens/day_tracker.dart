import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../model/combined_meal_model/dailyProgressMealPlanModel.dart';
import '../../../model/day_tracker_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../../utils/check_box_settings.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import 'package:http/http.dart' as http;

class DayMealTracerUI extends StatefulWidget {
  final String selectedDay;
  final String detoxOrHealing;
  //final ProceedProgramDayModel proceedProgramDayModel;
  const DayMealTracerUI(
      {Key? key, required this.selectedDay, required this.detoxOrHealing})
      : super(key: key);

  @override
  State<DayMealTracerUI> createState() => _DayMealTracerUIState();
}

class _DayMealTracerUIState extends State<DayMealTracerUI> {
  DailyProgressMealPlanModel? dailyProgressMealPlanModel;
  bool showProgress = false;
  Color? textColor;
  DayTracker? trackerDetails;

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

  final formKey = GlobalKey<FormState>();
  List missedAnything = ["Yes, I have", "No, I've Done It All"];

  String selectedMissedAnything = '';

  final mealPlanMissedController = TextEditingController();

  final symptomsCheckBox1 = <CheckBoxSettings>[
    CheckBoxSettings(title: "Aches, pain, and soreness"),
    CheckBoxSettings(title: "Nausea"),
    CheckBoxSettings(title: "Vomiting"),
    CheckBoxSettings(title: "Diarrhea"),
    CheckBoxSettings(title: "Constipation"),
    CheckBoxSettings(title: "Headache"),
    CheckBoxSettings(title: "fever or flu-like symptoms"),
    CheckBoxSettings(title: "Cold"),
    CheckBoxSettings(title: "Frequent urination"),
    CheckBoxSettings(title: "Urinary tract discharges"),
    CheckBoxSettings(
        title: "Skin eruptions, including boils, hives, and rashes"),
    CheckBoxSettings(
        title: "Emotional Disturbances like anger, despair, sadness, fear"),
    CheckBoxSettings(title: "Anxiety, Mood swings, Phobias"),
    CheckBoxSettings(title: "Joints &/or Muscle Pain"),
    CheckBoxSettings(title: "Chills"),
    CheckBoxSettings(title: "Stuffy Nose"),
    CheckBoxSettings(title: "Congestion"),
    CheckBoxSettings(title: "Change in Blood Pressure"),
    CheckBoxSettings(title: "Severe Joint pain / Body ache"),
    CheckBoxSettings(title: "Dry cough / Dryness of mouth"),
    CheckBoxSettings(title: "Loss of appetite / tastelessness"),
    CheckBoxSettings(title: "Severe thirst"),
    CheckBoxSettings(title: "Weaker sense of hearing / vision"),
    CheckBoxSettings(
        title: "Reduction in physical, mental, and or digestive capacity"),
    CheckBoxSettings(title: "Feeling dizzy / giddiness"),
    CheckBoxSettings(title: "Mind agitation"),
    CheckBoxSettings(title: "Weakness / restlessness / cramps / sleeplessness"),
    CheckBoxSettings(title: "None Of The Above"),
  ];
  List selectedSymptoms1 = [];

  final symptomsCheckBox2 = <CheckBoxSettings>[
    CheckBoxSettings(
        title:
            "Satisfactory release of Solid waste matter / Gas from stomach and or Urine"),
    CheckBoxSettings(title: "Lightness in the Chest / Abdomen"),
    CheckBoxSettings(title: "Odour free burps"),
    CheckBoxSettings(title: "Freshness in the Mouth"),
    CheckBoxSettings(title: "Easily getting hungry, thirsty, or both"),
    CheckBoxSettings(
        title:
            "Clear tongue/Sense (absence of discharges from sense organs such as the skin's sweat or perspiration, the ears, the nose, the tongue, and the eyes)"),
    CheckBoxSettings(title: "Odour free breath"),
    CheckBoxSettings(title: "No Body odour"),
    CheckBoxSettings(title: "Weight loss"),
    CheckBoxSettings(title: "Peaceful Sleep"),
    CheckBoxSettings(title: "Easy Digestion"),
    CheckBoxSettings(title: "Increased energy levels"),
    CheckBoxSettings(title: "Reduced / absence of cravings"),
    CheckBoxSettings(title: "Feeling of internal wellbeing and happiness"),
    CheckBoxSettings(
        title:
            "Reduced / Absence of Detox related Recovery symptoms as mentioned in the previous question"),
    CheckBoxSettings(title: "None of the above"),
  ];

  List selectedSymptoms2 = [];

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
                                : trackerDetails == null ? buildNoData() : Expanded(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            textAlign: TextAlign.start,
                                            style:
                                                EvaluationText().headingText()),
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
                                    getSymptom(),
                                    // ...symptomsCheckBox1
                                    //     .map((e) =>
                                    //         buildHealthCheckBox(e, '1'))
                                    //     .toList(),
                                    Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      color: newLightGreyColor,
                                    ),
                                    SizedBox(height: 1.h),
                                    buildLabelTextField(
                                        'Did any of the following (adequate) detoxification / healing signs and symptoms happen to you today? If "Yes," then choose all that apply. If no, choose none of the above.'),
                                    SizedBox(height: 1.h),
                                    getSymptom1(),
                                    // ...symptomsCheckBox2
                                    //     .map((e) =>
                                    //         buildHealthCheckBox(e, '2'))
                                    //     .toList(),
                                    Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      color: newLightGreyColor,
                                    ),
                                    SizedBox(height: 1.h),
                                    buildLabelTextField(
                                        'Please let us know if you notice any other signs or have any other worries. If none, enter "No."'),
                                    SizedBox(height: 1.h),
                                    Text(trackerDetails?.haveAnyOtherWorries ?? "",
                                        textAlign: TextAlign.start,
                                        style: EvaluationText().answerText()),
                                    Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.h),
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
                                    Text(trackerDetails?.eatSomethingOther ?? "",
                                        textAlign: TextAlign.start,
                                        style: EvaluationText().answerText()),
                                    Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.h),
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 25,
                                              child: Radio(
                                                value: "Yes",
                                                activeColor: kPrimaryColor,
                                                visualDensity:
                                                    const VisualDensity(
                                                        vertical: VisualDensity
                                                            .minimumDensity,
                                                        horizontal: VisualDensity
                                                            .minimumDensity),
                                                groupValue: trackerDetails?.completedCalmMoveModules,
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 25,
                                              child: Radio(
                                                value: "No",
                                                visualDensity:
                                                    const VisualDensity(
                                                        vertical: VisualDensity
                                                            .minimumDensity,
                                                        horizontal: VisualDensity
                                                            .minimumDensity),
                                                activeColor: kPrimaryColor,
                                                groupValue: trackerDetails?.completedCalmMoveModules,
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
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      color: newLightGreyColor,
                                    ),
                                    buildLabelTextField(
                                        'Have you had a medical exam or taken any medications during the program? If "Yes", please give more information. Type "No" if not.'),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                        trackerDetails?.hadAMedicalExamMedications ??
                                            "",
                                        textAlign: TextAlign.start,
                                        style: EvaluationText().answerText()),
                                    SizedBox(
                                      height: 3.h,
                                    )
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

  buildHealthCheckBox(CheckBoxSettings healthCheckBox, String from) {
    return ListTile(
      minLeadingWidth: 30,
      horizontalTitleGap: 3,
      dense: true,
      //  leading: ,
      trailing: SizedBox(
        width: 20,
        child: Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: kPrimaryColor,
          value: healthCheckBox.value,
          onChanged: (v) {
            if (from == '1') {
              if (healthCheckBox.title == symptomsCheckBox1.last.title) {
                print("if");
                setState(() {
                  selectedSymptoms1.clear();
                  symptomsCheckBox1.forEach((element) {
                    element.value = false;
                  });
                  selectedSymptoms1.add(healthCheckBox.title!);
                  healthCheckBox.value = v;
                });
              } else {
                print("else");
                if (selectedSymptoms1.contains(symptomsCheckBox1.last.title)) {
                  print("if");
                  setState(() {
                    selectedSymptoms1.clear();
                    symptomsCheckBox1.last.value = false;
                  });
                }
                if (v == true) {
                  setState(() {
                    selectedSymptoms1.add(healthCheckBox.title!);
                    healthCheckBox.value = v;
                  });
                } else {
                  setState(() {
                    selectedSymptoms1.remove(healthCheckBox.title!);
                    healthCheckBox.value = v;
                  });
                }
              }
              print(selectedSymptoms1);
            } else if (from == '2') {
              if (healthCheckBox.title == symptomsCheckBox2.last.title) {
                print("if");
                setState(() {
                  selectedSymptoms2.clear();
                  symptomsCheckBox2.forEach((element) {
                    element.value = false;
                    // if(element.title != symptomsCheckBox2.last.title){
                    // }
                  });
                  if (v == true) {
                    selectedSymptoms2.add(healthCheckBox.title);
                    healthCheckBox.value = v;
                  } else {
                    selectedSymptoms2.remove(healthCheckBox.title!);
                    healthCheckBox.value = v;
                  }
                });
              } else {
                // print("else");
                if (v == true) {
                  // print("if");
                  setState(() {
                    if (selectedSymptoms2
                        .contains(symptomsCheckBox2.last.title)) {
                      // print("if");
                      selectedSymptoms2.removeWhere(
                          (element) => element == symptomsCheckBox2.last.title);
                      symptomsCheckBox2.forEach((element) {
                        element.value = false;
                      });
                    }
                    selectedSymptoms2.add(healthCheckBox.title!);
                    healthCheckBox.value = v;
                  });
                } else {
                  setState(() {
                    selectedSymptoms2.remove(healthCheckBox.title!);
                    healthCheckBox.value = v;
                  });
                }
              }
              print(selectedSymptoms2);
            }
            // print("${healthCheckBox.title}=> ${healthCheckBox.value}");
          },
        ),
      ),
      title: Text(
        healthCheckBox.title.toString(),
        style: EvaluationText().answerText(),
      ),
    );
  }

  buildTrackSelection(String didUMiss) {
    if (didUMiss == missedAnything[0]) {
      return selectedMissedAnything = "Yes, I have";
    } else {
      return selectedMissedAnything = "No, I've Done It All";
    }
  }

  // void proceed() async {
  //   ProceedProgramDayModel? model;
  //   model = ProceedProgramDayModel(
  //     patientMealTracking: widget.proceedProgramDayModel.patientMealTracking,
  //     comment: widget.proceedProgramDayModel.comment,
  //     userProgramStatusTracking: 1,
  //     day: widget.proceedProgramDayModel.day,
  //     missedAnyThingRadio: selectedMissedAnything,
  //     didUMiss: mealPlanMissedController.text,
  //     withdrawalSymptoms: selectedSymptoms1.toString(),
  //     detoxification: selectedSymptoms2.toString(),
  //     haveAnyOtherWorries: worriesController.text,
  //     eatSomthingOther: eatSomethingController.text,
  //     completedCalmMoveModules: selectedCalmModule,
  //     hadAMedicalExamMedications: anyMedicationsController.text
  //   );
  //   print(model.toJson());
  //   print(model.missedAnyThingRadio);
  //   final result = await ProgramService(repository: repository).proceedDayMealDetailsService(model);
  //
  //   print("result: $result");
  //
  //   if(result.runtimeType == GetProceedModel){
  //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => DaysProgramPlan()), (route) => route.isFirst);
  //   }
  //   else{
  //     ErrorModel model = result as ErrorModel;
  //     AppConfig().showSnackbar(context, model.message ?? '', isError: true);
  //   }
  // }
  //
  // final ProgramRepository repository = ProgramRepository(
  //   apiClient: ApiClient(
  //     httpClient: http.Client(),
  //   ),
  // );

  getDetails1() {
    print("CheckBox 1 : ${trackerDetails?.withdrawalSymptoms}");
    List lifeStyle = jsonDecode("${trackerDetails?.withdrawalSymptoms}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle);
    selectedSymptoms1 = lifeStyle;
    print("selectedSymptoms1: $selectedSymptoms1");

    print(trackerDetails?.detoxification);
    List lifeStyle1 = jsonDecode("${trackerDetails?.detoxification}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle1);
    selectedSymptoms2 = lifeStyle1;
    print("selectedSymptoms2: $selectedSymptoms2");
  }

  getSymptom() {
    print("selectedSymptoms1: $selectedSymptoms1");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedSymptoms1.length,
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
                  selectedSymptoms1[index] ?? "",
                  style: EvaluationText().answerText(),
                ),
              ),
            ],
          ),
        );
        //   ListTile(
        //   leading: const Icon(
        //     Icons.gamepad_sharp,
        //     color: gBlackColor,
        //   ),
        //   title: Text(
        //     selectedSymptoms1[index] ?? "",
        //     style: TextStyle(
        //       fontSize: 10.sp,
        //       color: gBlackColor,
        //       fontFamily: "GothamBook",
        //     ),
        //   ),
        // );
      },
    );
  }

  getSymptom1() {
    print("selectedSymptoms1: $selectedSymptoms1");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedSymptoms2.length,
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
                  selectedSymptoms2[index] ?? "",
                  style: EvaluationText().answerText(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getDetails(DayTrackerModel model) {
    // --- Health Check -- //
    print(jsonDecode(model.data!.withdrawalSymptoms!));
    List lifeStyle = jsonDecode(model.data!.withdrawalSymptoms!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle);
    symptomsCheckBox1.forEach((element) {
      print('${element.title}');
      print(lifeStyle.any((e) => element.title == e));
      if (lifeStyle.any((e) => element.title == e)) {
        element.value = true;
      }
    });
    // if (lifeStyle.any((element) => element.toString().contains("Other"))) {
    //   selectedHealthCheckBox1 = true;
    // }

    // --- Health Details --- //

    print(jsonDecode(model.data!.detoxification!));
    List healthDetails = jsonDecode(model.data!.detoxification!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(healthDetails);
    symptomsCheckBox2.forEach((element) {
      print('${element.title}');
      print(healthDetails.any((e) => element.title == e));
      if (healthDetails.any((e) => element.title == e)) {
        element.value = true;
      }
    });
  }
}
