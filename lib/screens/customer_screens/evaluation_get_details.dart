import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/evaluation_details_controller.dart';
import '../../model/error_model.dart';
import '../../model/evaluation_details_model.dart';
import '../../utils/check_box_settings.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'evaluation_form_screens/personal_details.dart';

class EvaluationGetDetails extends StatefulWidget {
  const EvaluationGetDetails({Key? key}) : super(key: key);

  @override
  State<EvaluationGetDetails> createState() => _EvaluationGetDetailsState();
}

class _EvaluationGetDetailsState extends State<EvaluationGetDetails> {
  EvaluationDetailsModel? evaluationDetailsModel;
  String tongueCoatingRadio = "";
  String urinationValue = "";
  String urineColorValue = "";
  String urineLookLikeValue = "";

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

  List selectedHealthCheckBox1 = [];

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

  final foodCheckBox = [
    CheckBoxSettings(title: "North Indian"),
    CheckBoxSettings(title: "South Indian"),
    CheckBoxSettings(title: "Continental"),
    CheckBoxSettings(title: "Mediterranean"),
  ];

  final sleepCheckBox = [
    CheckBoxSettings(title: "I Toss& Turn Alot In Bed"),
    CheckBoxSettings(title: "I Get The Feeling Refreshed"),
    CheckBoxSettings(title: "I Have Difficulty Falling Asleep"),
    CheckBoxSettings(title: "I Sleep Deep"),
    CheckBoxSettings(title: "I Wake Up Feeling Heavy"),
  ];

  final lifeStyleCheckBox = [
    CheckBoxSettings(title: "Drugs"),
    CheckBoxSettings(title: "Cigarettes"),
    CheckBoxSettings(title: "Alcohol"),
    CheckBoxSettings(title: "Others"),
    CheckBoxSettings(title: "None"),
  ];

  final gutTypeCheckBox = [
    CheckBoxSettings(title: "Dry Mouth"),
    CheckBoxSettings(title: "Astringent/Pungent/Sour Taste In The Mouth"),
    CheckBoxSettings(title: "Severe Thrist"),
    CheckBoxSettings(title: "Burning Sensation In Your Chest"),
    CheckBoxSettings(title: "Acid Reflux/Belching/Acidic Regurgitation"),
    CheckBoxSettings(title: "Severe Sweet Cravings In The Evening/Night"),
    CheckBoxSettings(title: "Bad Breathe"),
    CheckBoxSettings(title: "Chest Burning With Nausia"),
    CheckBoxSettings(title: "Heavy Stomach"),
    CheckBoxSettings(title: "Bloating"),
    CheckBoxSettings(title: "A Lot Of Salivation"),
    CheckBoxSettings(title: "Sweet/Salty/Sour Taste In Your Mouth"),
    CheckBoxSettings(title: "Severe Bitter craving During The Day"),
    CheckBoxSettings(title: "Dryness In The Mouth Inspite Of Salivation"),
    CheckBoxSettings(title: "Gassiness"),
    CheckBoxSettings(title: "Gurgling Noise In Your Tummy"),
    CheckBoxSettings(title: "Hypersalivation While Feeling Nauseous"),
    CheckBoxSettings(
        title: "Cannot Start My Day Without A Hot Beverage Once I'm Up"),
    CheckBoxSettings(title: "None Of The Above"),
    CheckBoxSettings(title: "None"),
  ];
  List selectedHealthCheckBox2 = [];

  //********** not used*************

  final urinFrequencyList = [
    CheckBoxSettings(title: "Increased"),
    CheckBoxSettings(title: "Decreased"),
    CheckBoxSettings(title: "No Change"),
  ];
  List selectedUrinFrequencyList = [];
  //*********************************

  //********** not used*************

  final urinColorList = [
    CheckBoxSettings(title: "Clear"),
    CheckBoxSettings(title: "Pale Yello"),
    CheckBoxSettings(title: "Red"),
    CheckBoxSettings(title: "Black"),
    CheckBoxSettings(title: "Yellow"),
  ];
  List selectedUrinColorList = [];
  bool urinColorOtherSelected = false;
  // *******************************

  final urinSmellList = [
    CheckBoxSettings(title: "Normal urine odour"),
    CheckBoxSettings(title: "Fruity"),
    CheckBoxSettings(title: "Ammonia"),
  ];
  List selectedUrinSmellList = [];
  bool urinSmellOtherSelected = false;

  //********** not used*************

  final urinLooksList = [
    CheckBoxSettings(title: "Clear/Transparent"),
    CheckBoxSettings(title: "Foggy/cloudy"),
  ];

  List selectedUrinLooksList = [];
  bool urinLooksLikeOtherSelected = false;
  //***********************************

  final medicalInterventionsDoneBeforeList = [
    CheckBoxSettings(title: "Surgery"),
    CheckBoxSettings(title: "Stents"),
    CheckBoxSettings(title: "Implants"),
  ];
  bool medicalInterventionsOtherSelected = false;
  List selectedmedicalInterventionsDoneBeforeList = [];

  String selectedStoolMatch = '';

  List<PlatformFile> medicalRecords = [];

  /// this is used when showdata is true
  List showMedicalReport = [];

  final habitCheckBox = [
    CheckBoxSettings(title: "Alcohol"),
    CheckBoxSettings(title: "Smoking"),
    CheckBoxSettings(title: "Coffee"),
    CheckBoxSettings(title: "Tea"),
    CheckBoxSettings(title: "Soft Drinks/Carbonated Drinks"),
    CheckBoxSettings(title: "Drugs"),
  ];
  bool habitOtherSelected = false;
  List selectedHabitCheckBoxList = [];

  final habitOtherController = TextEditingController();
  final mealPreferenceController = TextEditingController();
  final hungerPatternController = TextEditingController();
  final bowelPatternController = TextEditingController();

  final mealPreferenceList = [
    "To eat something sweet within 2 hrs of having food.",
    "To have something bitter or astringent within an hour of having food",
    "Other:"
  ];
  String mealPreferenceSelected = "";

  final hungerPatternList = [
    "Intense, however, tend to eat small or large portions which differ. Also tend to eat frequently, like every 2hrs than eat large meals.",
    "Intense and prefer to eat large meals when i eat. The gaps between meals may be long or short",
    "Not so intense. Tend to eat small portions when hungry. I am fine with long, unpredictable gaps between my meals.",
    "Other:"
  ];
  String hungerPatternSelected = "";

  final bowelPatternList = [
    "I sometimes have soft stools and/or sometimes constipated dry stools",
    "I have soft well formed and/or watery stools",
    "I am usually constipated with either well formed stools or hard stools",
    "Other:"
  ];
  String bowelPatternSelected = "";

  EvaluationDetailsController evaluationDetailsController =
      Get.put(EvaluationDetailsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              const Opacity(
                opacity: 0.2,
                child: Image(
                  image: AssetImage("assets/images/Group 10082.png"),
                  fit: BoxFit.fill,
                ),
              ),
              FutureBuilder(
                  future: evaluationDetailsController.fetchEvaluationDetails(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      print(snapshot.data.runtimeType);
                      if (snapshot.data.runtimeType == EvaluationDetailsModel) {
                        EvaluationDetailsModel model =
                            snapshot.data as EvaluationDetailsModel;
                        EvaluationDetailsModel? model1 = snapshot.data;
                        getDetails(model1);
                        return buildEvaluationForm(model: model1);
                      } else {
                        ErrorModel model = snapshot.data as ErrorModel;
                        print(model.message);
                      }
                    } else if (snapshot.hasError) {
                      print("snapshot.error: ${snapshot.error}");
                    }
                    return buildCircularIndicator();
                  }),
            ],
          );
        }),
      ),
    );
  }

  buildEvaluationForm({EvaluationDetailsModel? model}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          const PersonalDetails(),
          SizedBox(height: 1.h),
          buildHealthDetails(model),
          SizedBox(height: 1.h),
          buildFoodHabitsDetails(model),
          SizedBox(height: 1.h),
          buildLifeStyleDetails(model),
          SizedBox(height: 1.h),
          buildBowelDetails(model),
        ],
      ),
    );
  }

  buildContainer(String title) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      // width: double.maxFinite,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: gGreyColor.withOpacity(0.5),
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(8),
      //   color: gWhiteColor,
      // ),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: "GothamBook", color: gBlackColor, fontSize: 9.sp),
      ),
    );
  }

  buildHealthDetails(EvaluationDetailsModel? model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Health",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "PoppinsBold",
                      color: kPrimaryColor,
                      fontSize: 15.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            Text(
              "Important For Your Doctors To Know What You Have Been Through Or Are Going Through At The Moment",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "PoppinsRegular",
                  color: gMainColor,
                  fontSize: 9.sp),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        buildLabelTextField('Weight In Kgs'),
        buildContainer(model?.data?.weight ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField('Height In Feet & Inches'),
        buildContainer(model?.data?.height ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            'Brief Paragraph About Your Current Complaints Are & What You Are Looking To Heal Here'),
        buildContainer(model?.data?.healthProblem ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField('Please Check All That Apply To You'),
        SizedBox(height: 1.h),
        showSelectedHealthBox(),
        buildContainer(model?.data?.listProblemsOther ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField('Please Check All That Apply To You'),
        SizedBox(height: 1.h),
        showSelectedHealthBox2(),
        SizedBox(height: 1.h),
        buildLabelTextField('Tongue Coating'),
        SizedBox(height: 1.h),
        Column(
          children: [
            Row(
              children: [
                Radio(
                    value: "Clear",
                    groupValue: model?.data?.tongueCoating,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {}),
                Text(
                  "Clear",
                  style: buildTextStyle(),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: "Coated with white layer",
                    groupValue: model?.data?.tongueCoating,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {}),
                Text(
                  "Coated with white layer",
                  style: buildTextStyle(),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                    value: "Coated with yellow layer",
                    groupValue: model?.data?.tongueCoating,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {}),
                Text(
                  "Coated with yellow layer",
                  style: buildTextStyle(),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                    value: "Coated with black layer",
                    groupValue: model?.data?.tongueCoating,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {}),
                Text(
                  "Coated with black layer",
                  style: buildTextStyle(),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                    value: "Other",
                    groupValue: model?.data?.tongueCoating,
                    activeColor: kPrimaryColor,
                    onChanged: (value) {}),
                Text(
                  "Other:",
                  style: buildTextStyle(),
                ),
              ],
            ),
          ],
        ),
        buildContainer(model?.data?.tongueCoatingOther ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            "Has Frequency Of Urination Increased Or Decreased In The Recent Past"),
        SizedBox(height: 1.h),
        buildUrination("${model?.data?.anyUrinationIssue}"),
        buildLabelTextField("Urin Color"),
        SizedBox(height: 1.h),
        buildUrineColorRadioButton("${model?.data?.urineColor}"),
        buildContainer(model?.data?.urineColorOther ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField("Urine Smell"),
        SizedBox(height: 1.h),
        showSelectedUrinSmellList(),
        buildContainer(model?.data?.urineSmellOther ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField("What Does Your Urine Look Like"),
        SizedBox(height: 1.h),
        buildUrineLookRadioButton("${model?.data?.urineLookLike}"),
        buildContainer("${model?.data?.urineLookLikeOther}" ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField("Which one is the closest match to your stool"),
        SizedBox(height: 1.h),
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 18.h,
              child: const Image(
                image: AssetImage("assets/images/stool_image.png"),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 1.h),
            Column(
              children: [
                Row(
                  children: [
                    Radio(
                        value: "Seperate hard lumps",
                        groupValue: model?.data?.closestStoolType,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Seperate hard lumps",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "Lumpy & sausage like",
                        groupValue: model?.data?.closestStoolType,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Lumpy & sausage like",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "Sausage shape with cracks on the surface",
                        groupValue: model?.data?.closestStoolType,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Sausage shape with cracks on the surface",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "Smooth, soft sausage or snake",
                        groupValue: model?.data?.closestStoolType,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Smooth, soft sausage or snake",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "Soft blobs with clear cut edges",
                        groupValue: model?.data?.closestStoolType,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Soft blobs with clear cut edges",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: "liquid consistency with no solid pieces",
                        groupValue: model?.data?.closestStoolType,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {}),
                    Text(
                      "liquid consistency with no solid pieces",
                      style: buildTextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 1.h),
        buildLabelTextField("Medical Interventions Done Before"),
        SizedBox(height: 1.h),
        showSelectedMedicalInterventionsList(),
        buildContainer(model?.data?.anyMedicalIntervationDoneBeforeOther ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            'Any Medications/Supplements/Inhalers/Contraceptives You Consume At The Moment'),
        buildContainer(model?.data?.anyMedicationConsumeAtMoment ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            'Holistic/Alternative Therapies You Have Been Through & When (Ayurveda, Homeopathy) '),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.anyTherapiesHaveDoneBefore ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField("Uploaded Files"),
        SizedBox(height: 2.h),
      ],
    );
  }

  buildFoodHabitsDetails(EvaluationDetailsModel? model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Food Habits",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "PoppinsBold",
                      color: kPrimaryColor,
                      fontSize: 15.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            Text(
              "To Make Your Meal Plans As Simple & Easy For You To Follow As Possible",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "PoppinsRegular",
                  color: gMainColor,
                  fontSize: 9.sp),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        buildLabelTextField(
            "Do Certain Food Affect Your Digestion? If So Please Provide Details."),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.mentionIfAnyFoodAffectsYourDigesion ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            "Do You Follow Any Special Diet(Keto,Etc)? If So Please Provide Details"),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.anySpecialDiet ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            "Do You Have Any Known Food Allergy? If So Please Provide Details."),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.anyFoodAllergy ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            "Do You Have Any Known Intolerance? If So Please Provide Details."),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.anyIntolerance ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            "Do You Have Any Severe Food Cravings? If So Please Provide Details."),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.anySevereFoodCravings ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField(
            "Do You Dislike Any Food?Please Mention All Of Them"),
        SizedBox(height: 1.h),
        buildContainer(model?.data?.anyDislikeFood ?? ""),
        SizedBox(height: 1.h),
        buildLabelTextField("How Many Glasses Of Water Do You Have A Day?"),
        SizedBox(height: 1.h),
        Row(
          children: [
            Radio(
              value: "1-2",
              activeColor: kPrimaryColor,
              groupValue: model?.data?.noGalssesDay,
              onChanged: (value) {},
            ),
            Text(
              '1-2',
              style: buildTextStyle(),
            ),
            SizedBox(width: 3.w),
            Radio(
              value: "3-4",
              activeColor: kPrimaryColor,
              groupValue: model?.data?.noGalssesDay,
              onChanged: (value) {},
            ),
            Text(
              '3-4',
              style: buildTextStyle(),
            ),
            SizedBox(width: 3.w),
            Radio(
                value: "6-8",
                groupValue: model?.data?.noGalssesDay,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "6-8",
              style: buildTextStyle(),
            ),
            SizedBox(width: 3.w),
            Radio(
                value: "9+",
                groupValue: model?.data?.noGalssesDay,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "9+",
              style: buildTextStyle(),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  buildLifeStyleDetails(EvaluationDetailsModel? model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Life Style",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "PoppinsBold",
                      color: kPrimaryColor,
                      fontSize: 15.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            Text(
              "This Tells Us How Your Gut Is & Has Been Treated",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "PoppinsRegular",
                  color: gMainColor,
                  fontSize: 9.sp),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        buildLabelTextField("Habits Or Addiction"),
        SizedBox(height: 1.h),
        showSelectedHabitsList(),
        buildContainer(model?.data?.anyHabbitOrAddictionOther ?? ""),
        SizedBox(height: 2.h),
      ],
    );
  }

  buildBowelDetails(EvaluationDetailsModel? model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bowel Type",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "PoppinsBold",
                      color: kPrimaryColor,
                      fontSize: 15.sp),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            Text(
              "Is a Barometer For Your Gut Health",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "PoppinsRegular",
                  color: gMainColor,
                  fontSize: 9.sp),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        buildLabelTextField("What is your after meal preference?"),
        SizedBox(height: 1.h),
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Radio(
                  value: mealPreferenceList[0],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.afterMealPreference,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    mealPreferenceList[0],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: mealPreferenceList[1],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.afterMealPreference,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    mealPreferenceList[1],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: mealPreferenceList[2],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.afterMealPreference,
                  onChanged: (value) {},
                ),
                Text(
                  mealPreferenceList[2],
                  style: buildTextStyle(),
                ),
              ],
            ),
            buildContainer(model?.data?.afterMealPreferenceOther ?? ""),
          ],
        ),
        SizedBox(height: 1.h),
        buildLabelTextField("Hunger Pattern"),
        SizedBox(height: 1.h),
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Radio(
                  value: hungerPatternList[0],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.hungerPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    hungerPatternList[0],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: hungerPatternList[1],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.hungerPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    hungerPatternList[1],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: hungerPatternList[2],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.hungerPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    hungerPatternList[2],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: hungerPatternList[3],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.hungerPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    hungerPatternList[3],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            buildContainer(model?.data?.hungerPatternOther ?? ""),
          ],
        ),
        SizedBox(height: 1.h),
        buildLabelTextField("Bowel Pattern"),
        SizedBox(height: 1.h),
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Radio(
                  value: bowelPatternList[0],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.bowelPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    bowelPatternList[0],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: bowelPatternList[1],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.bowelPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    bowelPatternList[1],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: bowelPatternList[2],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.bowelPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    bowelPatternList[2],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: bowelPatternList[3],
                  activeColor: kPrimaryColor,
                  groupValue: model?.data?.bowelPattern,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    bowelPatternList[3],
                    style: buildTextStyle(),
                  ),
                ),
              ],
            ),
            buildContainer(model?.data?.bowelPatternOther ?? ""),
          ],
        ),
        SizedBox(height: 1.h),
      ],
    );
  }

  buildLabelTextField(String name) {
    return RichText(
      text: TextSpan(
        text: name,
        style: TextStyle(
          fontSize: 11.sp,
          color: gBlackColor,
          fontFamily: "GothamMedium",
        ),
        children: [
          TextSpan(
            text: ' *',
            style: TextStyle(
              fontSize: 9.sp,
              color: gGreyColor,
              fontFamily: "PoppinsSemiBold",
            ),
          ),
        ],
      ),
    );
  }

  buildUrination(String anyUrinationIssue) {
    print("Urination: $anyUrinationIssue");
    selectedUrinFrequencyList
        .addAll(List.from(jsonDecode(anyUrinationIssue ?? '')));
    selectedUrinFrequencyList = List.from(
        (selectedUrinFrequencyList[0].split(',') as List)
            .map((e) => e)
            .toList());
    urinationValue = selectedUrinFrequencyList.first;

    return Row(
      children: [
        Radio(
          value: "Increased",
          activeColor: kPrimaryColor,
          groupValue: urinationValue,
          onChanged: (value) {
            setState(() {
              urinationValue = value as String;
            });
          },
        ),
        Text('Increased', style: buildTextStyle()),
        SizedBox(
          width: 3.w,
        ),
        Radio(
          value: "Decreased",
          activeColor: kPrimaryColor,
          groupValue: urinationValue,
          onChanged: (value) {
            setState(() {
              urinationValue = value as String;
            });
          },
        ),
        Text(
          'Decreased',
          style: buildTextStyle(),
        ),
        SizedBox(
          width: 3.w,
        ),
        Radio(
            value: "No Change",
            groupValue: urinationValue,
            activeColor: kPrimaryColor,
            onChanged: (value) {
              setState(() {
                urinationValue = value as String;
              });
            }),
        Text(
          "No Change",
          style: buildTextStyle(),
        ),
      ],
    );
  }

  buildUrineColorRadioButton(String title) {
    print("UrinColor: $title");
    selectedUrinColorList.addAll(List.from(jsonDecode(title ?? '')));
    selectedUrinColorList = List.from(
        (selectedUrinColorList[0].split(',') as List).map((e) => e).toList());
    urineColorValue = selectedUrinColorList.first;

    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: "Clear",
              activeColor: kPrimaryColor,
              groupValue: urineColorValue,
              onChanged: (value) {},
            ),
            Text('Clear', style: buildTextStyle()),
            SizedBox(
              width: 3.w,
            ),
            Radio(
              value: "Pale Yello",
              activeColor: kPrimaryColor,
              groupValue: urineColorValue,
              onChanged: (value) {},
            ),
            Text(
              'Pale Yello',
              style: buildTextStyle(),
            ),
            SizedBox(
              width: 3.w,
            ),
            Radio(
                value: "Red",
                groupValue: urineColorValue,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "Red",
              style: buildTextStyle(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: "Black",
              activeColor: kPrimaryColor,
              groupValue: urineColorValue,
              onChanged: (value) {},
            ),
            Text('Black', style: buildTextStyle()),
            SizedBox(
              width: 3.w,
            ),
            Radio(
              value: "Yellow",
              activeColor: kPrimaryColor,
              groupValue: urineColorValue,
              onChanged: (value) {},
            ),
            Text(
              'Yellow',
              style: buildTextStyle(),
            ),
            SizedBox(
              width: 3.w,
            ),
            Radio(
                value: "Other",
                groupValue: urineColorValue,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "Other",
              style: buildTextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  buildUrineLookRadioButton(String urineLookLike) {
    print("UrineLookLike: $urineLookLike");
    selectedUrinLooksList.addAll(List.from(jsonDecode(urineLookLike ?? '')));
    selectedUrinLooksList = List.from(
        (selectedUrinLooksList[0].split(',') as List).map((e) => e).toList());
    urineLookLikeValue = selectedUrinLooksList.first;
    print("value: $urineLookLikeValue");
    return Column(
      children: [
        Row(
          children: [
            Radio(
                value: "Clear/Transparent",
                groupValue: urineLookLikeValue,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "Clear/Transparent",
              style: buildTextStyle(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                value: "Foggy/cloudy",
                groupValue: urineLookLikeValue,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "Foggy/cloudy",
              style: buildTextStyle(),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                value: "Other",
                groupValue: urineLookLikeValue,
                activeColor: kPrimaryColor,
                onChanged: (value) {}),
            Text(
              "Other",
              style: buildTextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  showSelectedHealthBox() {
    print("selectedHealthCheckBox1: $selectedHealthCheckBox1");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedHealthCheckBox1.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.check_box_outlined,
            color: gSecondaryColor,
          ),
          title: Text(
            selectedHealthCheckBox1[index] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              height: 1.3,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
        );
      },
    );
  }

  showSelectedHealthBox2() {
    print("selectedHealthCheckBox2: $selectedHealthCheckBox2");
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedHealthCheckBox2.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.check_box_outlined,
            color: gSecondaryColor,
          ),
          title: Text(
            selectedHealthCheckBox2[index] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              height: 1.3,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
        );
      },
    );
  }

  showSelectedUrinSmellList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedUrinSmellList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.check_box_outlined,
            color: gSecondaryColor,
          ),
          title: Text(
            selectedUrinSmellList[index] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              height: 1.3,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
        );
      },
    );
  }

  showSelectedMedicalInterventionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedmedicalInterventionsDoneBeforeList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.check_box_outlined,
            color: gSecondaryColor,
          ),
          title: Text(
            selectedmedicalInterventionsDoneBeforeList[index] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              height: 1.3,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
        );
      },
    );
  }

  showSelectedHabitsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedHabitCheckBoxList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(
            Icons.check_box_outlined,
            color: gSecondaryColor,
          ),
          title: Text(
            selectedHabitCheckBoxList[index] ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              height: 1.3,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
        );
      },
    );
  }

  void getDetails(EvaluationDetailsModel? model) {
    //---- health checkbox1 ----//
    print(model?.data?.listProblems);
    List lifeStyle = jsonDecode("${model?.data?.listProblems}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle);
    selectedHealthCheckBox1 = lifeStyle;
    print("selectedHealthCheckBox1: $selectedHealthCheckBox1");

    //---- health checkbox2 ----//
    print(model?.data?.listBodyIssues);
    List lifeStyle1 = jsonDecode("${model?.data?.listBodyIssues}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle1);
    selectedHealthCheckBox2 = lifeStyle1;
    print("selectedHealthCheckBox2: $selectedHealthCheckBox2");

    //---- urineSmell ----//
    print(model?.data?.urineSmell);
    List lifeStyle2 = jsonDecode("${model?.data?.urineSmell}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle2);
    selectedUrinSmellList = lifeStyle2;
    print("selectedUrinSmellList: $selectedUrinSmellList");

    //---- anyMedicalIntervationDoneBefore ----//
    print(model?.data?.anyMedicalIntervationDoneBefore);
    List lifeStyle3 =
        jsonDecode("${model?.data?.anyMedicalIntervationDoneBefore}")
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(',');
    print(lifeStyle3);
    selectedmedicalInterventionsDoneBeforeList = lifeStyle3;
    print(
        "selectedmedicalInterventionsDoneBeforeList: $selectedmedicalInterventionsDoneBeforeList");

    //---- selectedHabitCheckBoxList ----//
    print(model?.data?.anyHabbitOrAddiction);
    List lifeStyle4 = jsonDecode("${model?.data?.anyHabbitOrAddiction}")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle4);
    selectedHabitCheckBoxList = lifeStyle4;
    print("selectedHabitCheckBoxList: $selectedHabitCheckBoxList");
  }
}
