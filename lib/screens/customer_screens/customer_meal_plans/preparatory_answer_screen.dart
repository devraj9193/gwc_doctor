import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controller/preparatory_answer_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';

class PreparatoryAnswerScreen extends StatefulWidget {
  final String days;
  const PreparatoryAnswerScreen({Key? key, required this.days})
      : super(key: key);

  @override
  State<PreparatoryAnswerScreen> createState() =>
      _PreparatoryAnswerScreenState();
}

class _PreparatoryAnswerScreenState extends State<PreparatoryAnswerScreen> {
  PreparatoryAnswerController preparatoryAnswerController =
      Get.put(PreparatoryAnswerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 38.h),
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
                        '${widget.days} Days Preparatory',
                        style:TabBarText().bottomSheetHeadingText(),
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
              color: lightTextColor,
            ),
            buildStatus(),
          ],
        ),
      ),
    );
  }

  buildStatus() {
    return Expanded(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: preparatoryAnswerController.fetchUserProfile(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return buildNoData();
              } else if (snapshot.hasData) {
                var data = snapshot.data;
                return LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      buildRadioButton("Has your hunger improved?", data.trackingPrepMeals.hungerImproved),
                      buildRadioButton("Has your appetite improved?", data.trackingPrepMeals.appetiteImproved),
                      buildRadioButton("Are you feeling light?", data.trackingPrepMeals.feelingLight),
                      buildRadioButton("Are you feeling energetic?", data.trackingPrepMeals.feelingEnergetic),
                      buildRadioButton(
                          "Are you feeling a mild reduction in your primary symptoms?",
                          data.trackingPrepMeals.mildReduction),
                    ],
                  );
                });
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: buildCircularIndicator(),
              );
            }),
      ),
    );
  }

  buildRadioButton(String question, String radio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: EvaluationText().questionText(),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Radio(
              value: "Yes",
              activeColor: gSecondaryColor,
              groupValue: radio,
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              onChanged: (value) {},
            ),
            Text(
              'Yes',
              style: EvaluationText().answerText()
            ),
            SizedBox(width: 2.w),
            Radio(
              value: "No",
              activeColor: gSecondaryColor,
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              //  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              groupValue: radio,
              onChanged: (value) {},
            ),
            Text(
              'No',
              style: EvaluationText().answerText()
            ),
          ],
        ),
        Container(
          height: 1.0,
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}
