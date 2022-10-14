import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/evaluation_details_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

class FoodHabitsDetails extends StatefulWidget {
  const FoodHabitsDetails({Key? key}) : super(key: key);

  @override
  State<FoodHabitsDetails> createState() => _FoodHabitsDetailsState();
}

class _FoodHabitsDetailsState extends State<FoodHabitsDetails> {
  EvaluationDetailsController evaluationDetailsController =
      Get.put(EvaluationDetailsController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
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
                    buildTextStyle(
                        "'Do Certain Food Affect Your Digestion? If So Please Provide Details. "),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.mentionIfAnyFoodAffectsYourDigesion ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle(
                        'Do You Follow Any Special Diet(Keto,Etc)? If So Please Provide Details. '),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.anySpecialDiet ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle(
                        'Do You Have Any Known Food Allergy? If So Please Provide Details. '),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.anyFoodAllergy ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle(
                        'Do You Have Any Known Intolerance? If So Please Provide Details. '),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.anyIntolerance ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle(
                        'Do You Have Any Severe Food Cravings? If So Please Provide Details. '),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.anySevereFoodCravings ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle(
                        'Do You Dislike Any Food?Please Mention All Of Them.'),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.anyDislikeFood ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle(
                        'How Many Glasses Of Water Do You Have A Day? '),
                    Row(
                      children: [
                        Radio(
                          value: "1-2",
                          activeColor: gPrimaryColor,
                          groupValue: data.data.noGalssesDay.toString(),
                          onChanged: (value) {},
                        ),
                        Text(
                          '1-2',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Radio(
                          value: "3-4",
                          activeColor: gPrimaryColor,
                          groupValue: data.data.noGalssesDay.toString(),
                          onChanged: (value) {},
                        ),
                        Text(
                          '3-4',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Radio(
                            value: "6-8",
                            groupValue: data.data.noGalssesDay.toString(),
                            activeColor: gPrimaryColor,
                            onChanged: (value) {}),
                        Text(
                          "6-8",
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Radio(
                            value: "9+",
                            groupValue: data.data.noGalssesDay.toString(),
                            activeColor: gPrimaryColor,
                            onChanged: (value) {}),
                        Text(
                          "9+",
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: buildCircularIndicator(),
              );
            }),
      ),
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
}
