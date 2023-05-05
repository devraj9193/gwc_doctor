import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/medical_feedback_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';

class MedicalFeedbackAnswer extends StatefulWidget {
  const MedicalFeedbackAnswer({Key? key}) : super(key: key);

  @override
  State<MedicalFeedbackAnswer> createState() => _MedicalFeedbackAnswerState();
}

class _MedicalFeedbackAnswerState extends State<MedicalFeedbackAnswer> {
  MedicalFeedbackController medicalFeedbackController =
      Get.put(MedicalFeedbackController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: buildMedicalFeedbackForm(),
    );
    //   UnfocusWidget(
    //   child: Container(
    //     decoration: const BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage("assets/images/eval_bg.png"),
    //         fit: BoxFit.fitWidth,
    //         colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.lighten),
    //       ),
    //     ),
    //     child: SafeArea(
    //       child: Scaffold(
    //         backgroundColor: Colors.transparent,
    //         body: showUI(context),
    //       ),
    //     ),
    //   ),
    // );
  }

  showUI(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(() {
                  Navigator.pop(context);
                }),
              ],
            )),
        SizedBox(
          height: 3.h,
        ),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 2, color: Colors.grey.withOpacity(0.5))
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: buildMedicalFeedbackForm(),
          ),
        ),
      ],
    );
  }

  buildMedicalFeedbackForm() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: medicalFeedbackController.fetchMedicalFeedback(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return buildNoData();
            } else if (snapshot.hasData) {
              var data = snapshot.data.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Medical Feedback form ",
                        textAlign: TextAlign.start,
                        style: EvaluationText().headingText(),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: newLightGreyColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "I hope your detoxification process went well. Please update us on your health's development.",
                    textAlign: TextAlign.start,
                    style: EvaluationText().subHeadingText(),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  buildLabelTextField(
                      'What were the RESOLVED digestive health issues after the program? Please list them below along with the % of improvement. '),
                  SizedBox(height: 1.h),
                  buildContainer(data.resolvedDigestiveIssue ?? ""),
                  SizedBox(height: 2.h),
                  buildLabelTextField(
                      'What were the UNRESOLVED digestive health issues after the program? Please list them below '),
                  SizedBox(height: 1.h),
                  buildContainer(data.unresolvedDigestiveIssue ?? ""),
                  SizedBox(height: 2.h),
                  buildLabelTextField(
                      'Tell us (the current status) about your after meal preferences '),
                  buildRadioContainer(data.mealPreferences ?? ""),
                  buildLabelTextField(
                      'Tell us (the current status) about your hunger pattern '),
                  buildRadioContainer(data.hungerPattern ?? ""),
                  buildLabelTextField(
                      'Tell us (the current status) about your bowel pattern '),
                  buildRadioContainer(data.bowelPattern ?? ""),
                  buildLabelTextField(
                      'Have your food cravings and lifestyle habits changed for the better? '),
                  buildRadioContainer(data.lifestyleHabits ?? ""),
                ],
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  buildContainer(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          margin: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
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
            style: EvaluationText().answerText(),
          ),
        ),
        Container(
          height: 1,
          margin: EdgeInsets.only(bottom: 1.h),
          color: newLightGreyColor,
        ),
      ],
    );
  }

  buildRadioContainer(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 1.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.radio_button_checked,
            color: gSecondaryColor,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: EvaluationText().answerText(),
            ),
          ),
        ],
      ),
    );
  }
}
