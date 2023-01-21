import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/evaluation_details_controller.dart';
import '../../../model/evaluation_details_model.dart';
import '../../../utils/check_box_settings.dart';
import '../../../utils/constants.dart';

class HealthDetails extends StatefulWidget {
  const HealthDetails({Key? key}) : super(key: key);

  @override
  State<HealthDetails> createState() => _HealthDetailsState();
}

class _HealthDetailsState extends State<HealthDetails> {
  String tongueCoatingRadio = "";
  final String otherText = "Other";

  EvaluationDetailsController evaluationDetailsController =
      Get.put(EvaluationDetailsController());

  final healthCheckBox1 = <CheckBoxSettings>[
    CheckBoxSettings(title: "Autoimmune Diseases"),
    CheckBoxSettings(title: "Endocrine Diseases (Thyroid/Diabetes/PCOS)"),
    CheckBoxSettings(
        title:
            "Heart Diseases (Palpitations/Low Blood Pressure/High Blood Pressure)"),
    CheckBoxSettings(title: "Renal/Kidney Diseases (Kidney Stones)"),
    CheckBoxSettings(
        title: "Liver Diseases (Cirrhosis/Fatty Liver/Hepatitis/Jaundice)"),
    CheckBoxSettings(
        title:
            "Neurological Diseases (Seizures/Fits/Convulsions/Headache/Migraine/Vertigo)"),
    CheckBoxSettings(
        title:
            "Digestive Diseases (Hernia/Hemorrhoids/Piles/Indigestion/Gall Stone/Pancreatitis/Irritable Bowel Syndrome)"),
    CheckBoxSettings(
        title:
            "Skin Diseases (Psoriasis/Acne/Eczema/Herpes,/Skin Allergies/Dandruff/Rashes)"),
    CheckBoxSettings(
        title:
            "Respiratory Diseases (Athama/Allergic bronchitis/Rhinitis/Sinusitis/Frequent Cold, Cough & Fever/Tonsillitis/Wheezing)"),
    CheckBoxSettings(
        title:
            "Reproductive Diseases (PCOD/Infertility/MenstrualDisorders/Heavy or Scanty Period Bleeding/Increased or Decreased Sexual Drive/Painful Periods /Irregular Cycles)"),
    CheckBoxSettings(
        title:
            "Skeletal Muscle Disorders (Muscular Dystrophy/Rheumatoid Arthritis/Arthritis/Spondylitis/Loss ofMuscle Mass)"),
    CheckBoxSettings(
        title:
            "Psychological/Psychiatric Issues (Depression,Anxiety, OCD, ADHD, Mood Disorders, Schizophrenia,Personality Disorders, Eating Disorders)"),
    CheckBoxSettings(title: "None Of The Above"),
    CheckBoxSettings(title: "Other:"),
  ];

  final healthCheckBox2 = <CheckBoxSettings>[
    CheckBoxSettings(title: "Body Odor"),
    CheckBoxSettings(title: "Dry Mouth"),
    CheckBoxSettings(title: "Severe Thirst"),
    CheckBoxSettings(title: "Severe Sweet Cravings In The Evening/Night"),
    CheckBoxSettings(title: "Astringent/Pungent/Sour Taste In The Mouth"),
    CheckBoxSettings(title: "Burning Sensation In Your Chest"),
    CheckBoxSettings(title: "Heavy Stomach"),
    CheckBoxSettings(title: "Acid Reflux/Belching/Acidic Regurgitation"),
    CheckBoxSettings(title: "Bad Breathe"),
    CheckBoxSettings(title: "Sweet/Salty/Sour Taste In Your Mouth"),
    CheckBoxSettings(title: "Severe Sweet Craving During the Day"),
    CheckBoxSettings(title: "Dryness In The Mouth Inspite Of Salivatio"),
    CheckBoxSettings(title: "Mood Swings"),
    CheckBoxSettings(title: "Chronic Fatigue or Low Energy Levels"),
    CheckBoxSettings(title: "Insomnia"),
    CheckBoxSettings(title: "Frequent Head/Body Aches"),
    CheckBoxSettings(title: "Gurgling Noise In Your Tummy"),
    CheckBoxSettings(title: "Hypersalivation While Feeling Nauseous"),
    CheckBoxSettings(
        title: "Cannot Start My Day Without A Hot Beverage Once I'm Up"),
    CheckBoxSettings(title: "Gas & Bloating"),
    CheckBoxSettings(title: "Constipation"),
    CheckBoxSettings(title: "Low Immunity/ Falling Ill Frequently"),
    CheckBoxSettings(title: "Inflamation"),
    CheckBoxSettings(title: "Muscle Cramps & Painr"),
    CheckBoxSettings(title: "Acne/Skin Breakouts/Boils"),
    CheckBoxSettings(title: "PMS(Women Only)"),
    CheckBoxSettings(title: "Heaviness"),
    CheckBoxSettings(title: "Lack Of Energy Or Lethargy"),
    CheckBoxSettings(title: "Loss Of Appetite"),
    CheckBoxSettings(title: "Increased Salivation"),
    CheckBoxSettings(title: "Profuse Sweating"),
    CheckBoxSettings(title: "Loss Of Taste"),
    CheckBoxSettings(title: "Nausea Or Vomiting"),
    CheckBoxSettings(title: "Metallic Or Bitter Taste"),
    CheckBoxSettings(title: "Weight Loss"),
    CheckBoxSettings(title: "Weight Gain"),
    CheckBoxSettings(title: "Burping"),
    CheckBoxSettings(
        title:
            "Sour Regurgitation/ Food Regurgitation.(Food Coming back to your mouth)"),
    CheckBoxSettings(title: "Burning while passing urine"),
    CheckBoxSettings(title: "None Of The Above")
  ];

  final urinFrequencyList = [
    CheckBoxSettings(title: "Increased"),
    CheckBoxSettings(title: "Decreased"),
    CheckBoxSettings(title: "No Change"),
  ];
  List selectedUrinFrequencyList = [];

  final urinColorList = [
    CheckBoxSettings(title: "Clear"),
    CheckBoxSettings(title: "Pale Yello"),
    CheckBoxSettings(title: "Red"),
    CheckBoxSettings(title: "Black"),
    CheckBoxSettings(title: "Yellow"),
    CheckBoxSettings(title: "Other"),
  ];
  bool urinColorOtherSelected = false;

  final urinSmellList = [
    CheckBoxSettings(title: "Normal urine odour"),
    CheckBoxSettings(title: "Fruity"),
    CheckBoxSettings(title: "Ammonia"),
    CheckBoxSettings(title: "Other"),
  ];
  bool urinSmellOtherSelected = false;

  final urinLooksList = [
    CheckBoxSettings(title: "Clear/Transparent"),
    CheckBoxSettings(title: "Foggy/cloudy"),
    CheckBoxSettings(title: "Other"),
  ];
  bool urinLooksLikeOtherSelected = false;

  final medicalInterventionsDoneBeforeList = [
    CheckBoxSettings(title: "Surgery"),
    CheckBoxSettings(title: "Stents"),
    CheckBoxSettings(title: "Implants"),
    CheckBoxSettings(title: "Other"),
  ];
  bool medicalInterventionsOtherSelected = false;

  String selectedStoolMatch = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: evaluationDetailsController.fetchEvaluationDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            getDetails(data);
            return IgnorePointer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextStyle('Weight In Kgs'),
                  SizedBox(height: 1.h),
                  buildAnswerTile(data.data.weight ?? ""),
                  SizedBox(height: 2.h),
                  buildTextStyle('Height In Feet & Inches'),
                  SizedBox(height: 1.h),
                  buildAnswerTile(data.data.height ?? ""),
                  SizedBox(height: 2.h),
                  buildTextStyle(
                      'Brief Paragraph About Your Current Complaints Are & What You Are Looking To Heal Here'),
                  SizedBox(height: 1.h),
                  buildAnswerTile(data.data.healthProblem ?? ""),
                  SizedBox(height: 2.h),
                  buildTextStyle('Please Check All That Apply To You'),
                  SizedBox(height: 1.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ...healthCheckBox1.map(buildHealthCheckBox).toList(),
                      buildAnswerTile(data.data.listProblemsOther ?? ""),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  // health checkbox2
                  buildTextStyle('Please Check All That Apply To You'),
                  SizedBox(height: 1.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ...healthCheckBox2.map(buildHealthCheckBox).toList(),
                      SizedBox(height: 1.h),
                      buildTextStyle('Tongue Coating'),
                      SizedBox(height: 1.h),
                      Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: "clear",
                                  groupValue:
                                      data.data.tongueCoating.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Clear",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "Coated with white layer",
                                  groupValue:
                                      data.data.tongueCoating.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Coated with white layer",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  value: "Coated with yellow layer",
                                  groupValue:
                                      data.data.tongueCoating.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Coated with yellow layer",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  value: "Coated with black layer",
                                  groupValue:
                                      data.data.tongueCoating.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Coated with black layer",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  value: "other",
                                  groupValue:
                                      data.data.tongueCoating.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Other:",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      buildAnswerTile(data.data.tongueCoatingOther ?? ""),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  buildTextStyle(
                      "Has Frequency Of Urination Increased Or Decreased In The Recent Past"),
                  SizedBox(height: 1.h),
                  Wrap(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      ...urinFrequencyList
                          .map(buildWrapingCheckBox)
                          .toList()
                    ],
                  ),
                  buildTextStyle("Urin Color"),
                  SizedBox(height: 1.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: [
                          ...urinColorList
                              .map(buildWrapingCheckBox)
                              .toList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: buildAnswerTile(
                            data.data.urineColorOther ?? ""),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  buildTextStyle("Urin Smell"),
                  SizedBox(height: 1.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: [
                          ...urinSmellList
                              .map(buildHealthCheckBox)
                              .toList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: buildAnswerTile(
                            data.data.urineSmellOther ?? ""),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  buildTextStyle("What Does Your Urine Look Like"),
                  SizedBox(
                    height: 1.h,
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: [
                          ...urinLooksList
                              .map(buildHealthCheckBox)
                              .toList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: buildAnswerTile(
                            data.data.urineLookLikeOther ?? ""),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  buildTextStyle(
                      "Which one is the closest match to your stool"),
                  SizedBox(height: 1.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 18.h,
                        child: const Image(
                          image:
                              AssetImage("assets/images/stool_image.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: "Seperate hard lumps",
                                  groupValue:
                                      data.data.closestStoolType.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Seperate hard lumps",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "Lumpy & sausage like",
                                  groupValue:
                                      data.data.closestStoolType.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Lumpy & sausage like",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value:
                                      "Sausage shape with cracks on the surface",
                                  groupValue:
                                      data.data.closestStoolType.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Sausage shape with cracks on the surface",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "Smooth, soft sausage or snake",
                                  groupValue:
                                      data.data.closestStoolType.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Smooth, soft sausage or snake",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "Soft blobs with clear cut edges",
                                  groupValue:
                                      data.data.closestStoolType.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "Soft blobs with clear cut edges",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value:
                                      "liquid consistency with no solid pieces",
                                  groupValue:
                                      data.data.closestStoolType.toString(),
                                  activeColor: gPrimaryColor,
                                  onChanged: (value) {}),
                              Text(
                                "liquid consistency with no solid pieces",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: gTextColor,
                                  fontFamily: "GothamBook",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  buildTextStyle("Medical Interventions Done Before"),
                  SizedBox(height: 1.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: [
                          ...medicalInterventionsDoneBeforeList
                              .map(buildHealthCheckBox)
                              .toList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: buildAnswerTile(data.data
                                .anyMedicalIntervationDoneBeforeOther ??
                            ""),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  buildTextStyle(
                      'Any Medications/Supplements/Inhalers/Contraceptives You Consume At The Moment'),
                  SizedBox(height: 1.h),
                  buildAnswerTile(
                      data.data.anyMedicationConsumeAtMoment ?? ""),
                  SizedBox(height: 2.h),
                  buildTextStyle(
                      'Holistic/Alternative Therapies You Have Been Through & When (Ayurveda, Homeopathy) '),
                  SizedBox(height: 1.h),
                  buildAnswerTile(
                      data.data.anyTherapiesHaveDoneBefore ?? ""),
                  SizedBox(height: 2.h),
                  // (data.data.medicalReport.isNotEmpty)
                  //     ? buildTextStyle(
                  //         "All Medical Records That Might Be Helpful To Evaluate Your Condition Better")
                  //     : Container(width: 0),
                  // SizedBox(height: 2.h),
                  // // (data.data.medicalReport.isNotEmpty)
                  // //     ? builListTile(data.data.medicalReport)
                  // //     : Container(width: 0),
                  // buildAnswerTile(
                  //     data.data.medicalReport.toString()),
                ],
              ),
            );
          }
          return Container();
          //   Padding(
          //   padding: EdgeInsets.symmetric(vertical: 20.h),
          //   child: buildCircularIndicator(),
          // );
        });
  }

  builListTile(List<String> files) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: files.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            margin: EdgeInsets.symmetric(vertical: 0.5.h),
            decoration: BoxDecoration(
                color: kContentColor, borderRadius: BorderRadius.circular(5)),
            child: Text(
              files[index].toString(),
              style: TextStyle(
                fontSize: 9.sp,
                color: gBlackColor,
                fontFamily: "PoppinsRegular",
              ),
            ),
          ),
        );
      },
    );
  }

  buildTextStyle(String title) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
              height: 1,
              fontSize: 10.sp,
              color: gPrimaryColor,
              fontFamily: "GothamMedium",
            ),
          ),
          TextSpan(
            text: '*',
            style: TextStyle(
              fontSize: 11.sp,
              height: 1.5,
              color: gSecondaryColor,
              fontFamily: "GothamMedium",
            ),
          ),
        ],
      ),
    );
  }

  buildAnswerTile(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 9.sp,
        color: gTextColor,
        fontFamily: "GothamBook",
      ),
    );
  }

  buildWrapingCheckBox(CheckBoxSettings healthCheckBox) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: gPrimaryColor,
              value: healthCheckBox.value,
              onChanged: (v) {
                setState(() {
                  healthCheckBox.value = v;
                });
              },
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            healthCheckBox.title.toString(),
            style: TextStyle(
              fontSize: 9.sp,
              color: gTextColor,
              fontFamily: "GothamBook",
            ),
          ),
        ],
      ),
    );
  }

  buildHealthCheckBox(CheckBoxSettings healthCheckBox) {
    return ListTile(
      minLeadingWidth: 30,
      horizontalTitleGap: 3,
      dense: true,
      leading: SizedBox(
        width: 20,
        child: Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: gPrimaryColor,
          value: healthCheckBox.value,
          onChanged: (v) {
            setState(() {
              healthCheckBox.value = v;
            });
            print("${healthCheckBox.title}=> ${healthCheckBox.value}");
            // if(selectedHealthCheckBox1.contains(v)){
            //   selectedHealthCheckBox1.remove(v);
            // }
            // else{
            //   selectedHealthCheckBox1.add(v);
            // }
          },
        ),
      ),
      title: Text(
        healthCheckBox.title.toString(),
        style: TextStyle(
          height: 1.5,
          fontSize: 9.sp,
          color: gBlackColor,
          fontFamily: "GothamBook",
        ),
      ),
    );
  }

  void getDetails(EvaluationDetailsModel model) {
    // --- Health Check -- //
    print(jsonDecode(model.data!.listProblems!));
    List lifeStyle = jsonDecode(model.data!.listProblems!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle);
    healthCheckBox1.forEach((element) {
      print('${element.title} ${lifeStyle[0]}');
      print(lifeStyle.any((e) => element.title == e));
      if (lifeStyle.any((e) => element.title == e)) {
        element.value = true;
      }
    });
    // if (lifeStyle.any((element) => element.toString().contains("Other"))) {
    //   selectedHealthCheckBox1 = true;
    // }

    // --- Health Details --- //

    print(jsonDecode(model.data!.listBodyIssues!));
    List healthDetails = jsonDecode(model.data!.listBodyIssues!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(healthDetails);
    healthCheckBox2.forEach((element) {
      print('${element.title} ${healthDetails[0]}');
      print(healthDetails.any((e) => element.title == e));
      if (healthDetails.any((e) => element.title == e)) {
        element.value = true;
      }
    });

    // --- Urin Details --- //

    print(jsonDecode(model.data!.anyUrinationIssue!));
    List urinDetails = jsonDecode(model.data!.anyUrinationIssue!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(urinDetails);
    urinFrequencyList.forEach((element) {
      print('${element.title} ${urinDetails[0]}');
      print(urinDetails.any((e) => element.title == e));
      if (urinDetails.any((e) => element.title == e)) {
        element.value = true;
      }
    });

    //  --- Urin Color  ---//

    print(jsonDecode(model.data!.urineColor!));
    List urinColor = jsonDecode(model.data!.urineColor!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(urinColor);
    urinColorList.forEach((element) {
      print('${element.title} ${urinColor[0]}');
      print(urinColor.any((e) => element.title == e));
      if (urinColor.any((e) => element.title == e)) {
        element.value = true;
      }
    });

    // --- Urin Smell ---//

    print(jsonDecode(model.data!.urineSmell!));
    List urinSmell = jsonDecode(model.data!.urineSmell!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print("Urin Smell : $urinSmell");
    urinSmellList.forEach((element) {
      print('${element.title} ${urinSmell[0]}');
      print(urinSmell.any((e) => element.title == e));
      if (urinSmell.any((e) => element.title == e)) {
        element.value = true;
      }
    });

    //  --- Urine Look --- //

    print(jsonDecode(model.data!.urineLookLike!));
    List urinLook = jsonDecode(model.data!.urineLookLike!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print("urinLook : $urinLook");
    urinLooksList.forEach((element) {
      print('${element.title} ${urinLook[0]}');
      print(urinLook.any((e) => element.title == e));
      if (urinLook.any((e) => element.title == e)) {
        element.value = true;
      }
    });

    // --- interventions --- //

    print(jsonDecode(model.data!.anyMedicalIntervationDoneBefore!));
    List interventions =
        jsonDecode(model.data!.anyMedicalIntervationDoneBefore!)
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',');
    print("interventions : $interventions");
    medicalInterventionsDoneBeforeList.forEach((element) {
      print('${element.title} ${interventions[0]}');
      print(interventions.any((e) => element.title == e));
      if (interventions.any((e) => element.title == e)) {
        element.value = true;
      }
    });
  }
}
