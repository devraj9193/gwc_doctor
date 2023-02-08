import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../controller/evaluation_details_controller.dart';
import '../../../../model/evaluation_details_model.dart';
import '../../../../utils/check_box_settings.dart';
import '../../../../utils/constants.dart';

class LifestyleDetails extends StatefulWidget {
  const LifestyleDetails({Key? key}) : super(key: key);

  @override
  State<LifestyleDetails> createState() => _LifestyleDetailsState();
}

class _LifestyleDetailsState extends State<LifestyleDetails> {
  bool habitOtherSelected = false;

  final habitCheckBox = [
    CheckBoxSettings(title: "Alcohol"),
    CheckBoxSettings(title: "Smoking"),
    CheckBoxSettings(title: "Coffee"),
    CheckBoxSettings(title: "Tea"),
    CheckBoxSettings(title: "Soft Drinks/Carbonated Drinks"),
    CheckBoxSettings(title: "Drugs"),
  ];

  EvaluationDetailsController evaluationDetailsController =
      Get.put(EvaluationDetailsController());

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FutureBuilder(
          future: evaluationDetailsController.fetchEvaluationDetails(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              getDetails(data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextStyle("Habits Or Addiction "),
                  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: [
                          ...habitCheckBox
                              .map(buildWrapingCheckBox)
                              .toList(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              child: Checkbox(
                                activeColor: kPrimaryColor,
                                value: habitOtherSelected,
                                onChanged: (v) {
                                  setState(() {
                                    habitOtherSelected = v!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Other :',
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: gBlackColor,
                                fontFamily: "GothamBook",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        data.data.anyHabbitOrAddictionOther ?? "",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: gBlackColor,
                          fontFamily: "GothamBook",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                ],
              );
            }
            return Container();
            //   Padding(
            //   padding: EdgeInsets.symmetric(vertical: 20.h),
            //   child: buildCircularIndicator(),
            // );
          }),
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
          SizedBox(width: 2.w),
          Text(
            healthCheckBox.title.toString(),
            style: TextStyle(
              fontSize: 9.sp,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
        ],
      ),
    );
  }

  void getDetails(EvaluationDetailsModel model) {
    print(jsonDecode(model.data!.anyHabbitOrAddiction!));
    List lifeStyle = jsonDecode(model.data!.anyHabbitOrAddiction!)
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',');
    print(lifeStyle);
    habitCheckBox.forEach((element) {
      print('${element.title} ${lifeStyle[0]}');
      print(lifeStyle.any((e) => element.title == e));
      if (lifeStyle.any((e) => element.title == e)) {
        element.value = true;
      }
    });
    if(lifeStyle.any((element) => element.toString().contains("Other"))){
      habitOtherSelected = true;
    }
  }
}
