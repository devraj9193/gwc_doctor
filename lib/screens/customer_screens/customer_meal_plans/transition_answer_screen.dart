import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/transition_answer_controller.dart';
import '../../../model/transition_answer_model.dart';
import '../../../utils/check_box_settings.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';

class TransitionAnswerScreen extends StatefulWidget {
  final String days;
  final String currentDay;
  const TransitionAnswerScreen(
      {Key? key, required this.days, required this.currentDay})
      : super(key: key);

  @override
  State<TransitionAnswerScreen> createState() => _TransitionAnswerScreenState();
}

class _TransitionAnswerScreenState extends State<TransitionAnswerScreen> {
  final formKey = GlobalKey<FormState>();
  List missedAnything = ["Yes, I have", "No, I've Done It All"];
  String selectedDay = "";

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

  String selectedCalmModule = '';

  final worriesController = TextEditingController();
  final eatSomethingController = TextEditingController();
  final anyMedicationsController = TextEditingController();

  String didYouCompleteCalmMoveModule = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int a = int.parse(
      buildCurrentDay(widget.currentDay),
    );
    int b = a - 1;
    String c = b.toString();
    print("CDay : $c");
    changedIndex(c);
    mealPlanMissedController.addListener(() {
      setState(() {});
    });
  }

  buildCurrentDay(String transition) {
    print("TTT : $transition");
    if (transition == "null") {
      return "0";
    } else {
      return transition;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mealPlanMissedController.removeListener(() {});
  }

  TransitionAnswerController transitionAnswerController =
      Get.put(TransitionAnswerController());
  @override
  Widget build(BuildContext context) {
    // selectedDay = widget.currentDay;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: const BoxDecoration(
          color: gWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '${widget.days} Days Transition',
                        style: TabBarText().bottomSheetHeadingText(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: mediumTextColor, width: 1),
                      ),
                      child: Icon(
                        Icons.clear,
                        color: mediumTextColor,
                        size: 1.6.h,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              height: 1,
              color: newLightGreyColor,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Day : ',
                          style: TextStyle(
                            fontSize: fontSize09,
                            fontFamily: fontBook,
                            color: newGreyColor,
                          ),
                        ),
                        TextSpan(
                          text: selectedDay,
                          style: TextStyle(
                            fontSize: fontSize09,
                            fontFamily: fontMedium,
                            color: newGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                    child: PopupMenuButton(
                      //   onSelected: null,
                      elevation: 2,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 0.5.h),
                      offset: const Offset(0, 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          //   onTap: null,
                          child: SizedBox(
                            height: 15.h,
                            width: 13.w,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: int.parse(widget.currentDay),
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print(index + 1);
                                      changedIndex("${index + 1}");
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Day : ${index + 1}",
                                      style: TextStyle(
                                        fontSize: fontSize08,
                                        fontFamily: fontMedium,
                                        color: newGreyColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 1.h),
                                    height: 1,width: double.maxFinite,
                                    color: newLightGreyColor.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.expand_more,
                        color: newGreyColor,
                        size: 2.5.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: FutureBuilder(
                    future: transitionAnswerController
                        .fetchTransitionAnswer(selectedDay),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.h),
                          child: Center(
                            child: Image(
                              image: const AssetImage(
                                  "assets/images/Group 5294.png"),
                              height: 25.h,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        var data = snapshot.data;
                        getDetails1(data);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       "Gut Detox Program Status Tracker",
                            //       textAlign: TextAlign.start,
                            //       style: TextStyle(
                            //           fontFamily: "GothamMedium",
                            //           color: gSecondaryColor,
                            //           fontSize: 10.sp),
                            //     ),
                            //     SizedBox(width: 2.w),
                            //     Expanded(
                            //       child: Container(
                            //         height: 1,
                            //         color: kPrimaryColor,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 1.5.h),
                            // buildLabelTextField(
                            //     "Have You Missed Anything In Your Meal Or Yoga Plan Today?"),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // ...missedAnything.map(
                            //   (e) => Row(
                            //     children: [
                            //       Radio<String>(
                            //         value: e,
                            //         activeColor: kPrimaryColor,
                            //         groupValue: buildTrackSelection(
                            //             data.data.didUMiss.toString()),
                            //         onChanged: (value) {},
                            //       ),
                            //       Text(
                            //         e,
                            //         style: EvaluationText().answerText(),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       "Missed Items",
                            //       textAlign: TextAlign.start,
                            //       style: TextStyle(
                            //           fontFamily: "GothamMedium",
                            //           color: kPrimaryColor,
                            //           fontSize: 10.sp),
                            //     ),
                            //     SizedBox(
                            //       width: 2.w,
                            //     ),
                            //     Expanded(
                            //       child: Container(
                            //         height: 1,
                            //         color: kPrimaryColor,
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
                            // Text(
                            //   data.data.didUMissAnything ?? "",
                            //   textAlign: TextAlign.start,
                            //   style: TextStyle(
                            //       fontFamily: "GothamBook",
                            //       color: gBlackColor,
                            //       fontSize: 10.sp),
                            // ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Symptom Tracker",
                                  textAlign: TextAlign.start,
                                  style: EvaluationText().headingText(),
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: newLightGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.5.h),
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
                              margin: EdgeInsets.symmetric(vertical: 1.h),
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
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              color: newLightGreyColor,
                            ),
                            SizedBox(height: 1.h),
                            buildLabelTextField(
                                'Please let us know if you notice any other signs or have any other worries. If none, enter "No."'),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              data.data.haveAnyOtherWorries ?? "",
                              textAlign: TextAlign.start,
                              style: EvaluationText().answerText(),
                            ),
                            Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(vertical: 1.h),
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
                              data.data.eatSomethingOther ?? "",
                              textAlign: TextAlign.start,
                              style: EvaluationText().answerText(),
                            ),
                            Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(vertical: 1.h),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      child: Radio(
                                        value: "Yes",
                                        activeColor: kPrimaryColor,
                                        visualDensity: const VisualDensity(
                                            vertical:
                                                VisualDensity.minimumDensity,
                                            horizontal:
                                                VisualDensity.minimumDensity),
                                        groupValue:
                                            data.data.completedCalmMoveModules,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    Text(
                                      'Yes',
                                      style: EvaluationText().answerText(),
                                    ),
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
                                        activeColor: kPrimaryColor,
                                        visualDensity: const VisualDensity(
                                            vertical:
                                                VisualDensity.minimumDensity,
                                            horizontal:
                                                VisualDensity.minimumDensity),
                                        groupValue:
                                            data.data.completedCalmMoveModules,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    Text(
                                      'No',
                                      style: EvaluationText().answerText(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              color: newLightGreyColor,
                            ),
                            SizedBox(height: 1.h),
                            buildLabelTextField(
                                'Have you had a medical exam or taken any medications during the program? If "Yes", please give more information. Type "No" if not.'),
                            SizedBox(height: 1.h),
                            Text(
                              data.data.hadAMedicalExamMedications ?? "",
                              textAlign: TextAlign.start,
                              style: EvaluationText().answerText(),
                            ),
                            SizedBox(
                              height: 3.h,
                            )
                          ],
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: buildCircularIndicator(),
                      );
                    }),
              ),
            ),
            // buildStatus(),
          ],
        ),
      ),
    );
  }

  void changedIndex(String index) {
    setState(() {
      selectedDay = index;
    });
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
    if (didUMiss == "yes") {
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

  getDetails1(TransitionAnswerModel model) {
    print(model.data?.withdrawalSymptoms);
    List lifeStyle = jsonDecode("${model.data?.withdrawalSymptoms}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle);
    selectedSymptoms1 = lifeStyle;
    print("selectedSymptoms1: $selectedSymptoms1");

    print(model.data?.detoxification);
    List lifeStyle1 = jsonDecode("${model.data?.detoxification}")
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
        //   ListTile(
        //   leading: const Icon(
        //     Icons.gamepad_sharp,
        //     color: gBlackColor,
        //   ),
        //   title: Text(
        //     selectedSymptoms2[index] ?? "",
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

  void getDetails(TransitionAnswerModel model) {
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
