import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../controller/evaluation_details_controller.dart';
import '../../../../utils/constants.dart';

class BowelTypeDetails extends StatefulWidget {
  const BowelTypeDetails({Key? key}) : super(key: key);

  @override
  State<BowelTypeDetails> createState() => _BowelTypeDetailsState();
}

class _BowelTypeDetailsState extends State<BowelTypeDetails> {
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
    return FutureBuilder(
        future: evaluationDetailsController.fetchEvaluationDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextStyle("What is your after meal Preference? "),
                Row(
                  children: [
                    Radio(
                        value: mealPreferenceList[0],
                        groupValue:
                            data.data.afterMealPreference.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        mealPreferenceList[0],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: mealPreferenceList[1],
                        groupValue:
                            data.data.afterMealPreference.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        mealPreferenceList[1],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: mealPreferenceList[2],
                        groupValue:
                            data.data.afterMealPreference.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        mealPreferenceList[2],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  data.data.afterMealPreferenceOther ?? "",
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: gTextColor,
                    fontFamily: "GothamBook",
                  ),
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Hunger pattern "),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Radio(
                        value: hungerPatternList[0],
                        groupValue: data.data.hungerPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        hungerPatternList[0],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: hungerPatternList[1],
                        groupValue: data.data.hungerPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        hungerPatternList[1],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: hungerPatternList[2],
                        groupValue: data.data.hungerPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        hungerPatternList[2],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: hungerPatternList[3],
                        groupValue: data.data.hungerPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        hungerPatternList[3],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  data.data.hungerPatternOther ?? "",
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: gTextColor,
                    fontFamily: "GothamBook",
                  ),
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Bowel Pattern "),
                Row(
                  children: [
                    Radio(
                        value: bowelPatternList[0],
                        groupValue: data.data.bowelPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        bowelPatternList[0],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: bowelPatternList[1],
                        groupValue: data.data.bowelPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        bowelPatternList[1],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: bowelPatternList[2],
                        groupValue: data.data.bowelPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        bowelPatternList[2],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: bowelPatternList[3],
                        groupValue: data.data.bowelPattern.toString(),
                        activeColor: gPrimaryColor,
                        onChanged: (value) {}),
                    Expanded(
                      child: Text(
                        bowelPatternList[3],
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 9.sp,
                          color: gTextColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  data.data.bowelPatternOther ?? "",
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: gTextColor,
                    fontFamily: "GothamBook",
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            );
          }
          return Container();
          //   Padding(
          //   padding: EdgeInsets.symmetric(vertical: 20.h),
          //   child: buildCircularIndicator(),
          // );
        });
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
}
