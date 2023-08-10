import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app_new/screens/nutri_delight_screens/daily_progress_screens/symptom_tracker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../repository/api_service.dart';
import '../../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../../model/combined_meal_model/dailyProgressMealPlanModel.dart';
import '../../../model/combined_meal_model/detox_nourish_model/detox_healing_common_model/child_meal_plan_details_model1.dart';
import '../../../model/error_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/widgets.dart';

class DailyProgressMealPlan extends StatefulWidget {
  final String selectedDay;
  final String detoxOrHealing;

  const DailyProgressMealPlan({
    Key? key,
    required this.selectedDay,
    required this.detoxOrHealing,
  }) : super(key: key);

  @override
  State<DailyProgressMealPlan> createState() => _DailyProgressMealPlanState();
}

class _DailyProgressMealPlanState extends State<DailyProgressMealPlan> {
  DailyProgressMealPlanModel? dailyProgressMealPlanModel;
  bool showProgress = false;
  Color? textColor;
  Map<String, List<ChildMealPlanDetailsModel1>> mealPlanData1 = {};

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
      mealPlanData1 = model.data!;
      print("meal plan : $mealPlanData1");
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
      backgroundColor: gWhiteColor,
      appBar: buildAppBar(() {
        Navigator.pop(context);
      }),
      body: buildUI(),
    );
  }

  buildUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "Day ",
                  style: MealPlan().subHeadingText(),
                ),
                TextSpan(
                  text: widget.selectedDay,
                  style: MealPlan().headingText(),
                ),
                TextSpan(
                  text: " Meal Plan",
                  style: MealPlan().subHeadingText(),
                ),
              ]),
            ),
          ],
        ),
        (showProgress)
            ? Center(
                child: buildCircularIndicator(),
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...groupList(),
                      // dailyProgressMealPlanModel?.userProgramStatusTracker ==
                      //         null
                      //     ? const SizedBox.shrink()
                      //     : IntrinsicWidth(
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             Navigator.of(context).push(
                      //               MaterialPageRoute(
                      //                 builder: (ct) => SymptomTracker(
                      //                   selectedDay: widget.selectedDay, detoxOrHealing: widget.detoxOrHealing,
                      //
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //           child: Container(
                      //             margin: EdgeInsets.symmetric(
                      //                 horizontal: 0.w, vertical: 3.h),
                      //             padding: EdgeInsets.symmetric(
                      //                 vertical: 1.2.h, horizontal: 3.w),
                      //             decoration: BoxDecoration(
                      //               color: gSecondaryColor,
                      //               borderRadius: BorderRadius.circular(10),
                      //             ),
                      //             child: Center(
                      //               child: Text(
                      //                 'Day ${widget.selectedDay} Tracker',
                      //                 style: TextStyle(
                      //                   fontFamily: "GothamMedium",
                      //                   color: gWhiteColor,
                      //                   fontSize: 10.sp,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       )
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  groupList() {
    List<Column> data = [];

    mealPlanData1.forEach((dayTime, value) {
      print("dayTime ===> $dayTime");
      for (var element in value) {
        print("values ==> ${element.toJson()}");
      }
      data.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
            child: Text(
              dayTime,
              style: MealPlan().titleText(),
            ),
          ),
          ...value
              .map(
                (e) => Column(
                  children: [
                    Container(
                      height: 120,
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.w, vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child:
                                (e.itemImage != null && e.itemImage!.isNotEmpty)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: e.itemImage!,
                                          errorWidget: (ctx, _, __) {
                                            return Image.asset(
                                              'assets/images/meal_placeholder.png',
                                              fit: BoxFit.fill,
                                            );
                                          },
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          'assets/images/meal_placeholder.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e.name ?? 'Morning Yoga',
                                        maxLines: 2,
                                        overflow: TextOverflow.visible,
                                        style: MealPlan().headingText(),
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    (e.status == "followed")
                                        ? buildMealPlanStatus(
                                            "Followed",
                                            "assets/images/followed2.png",
                                            gPrimaryColor)
                                        : buildMealPlanStatus(
                                            "Missed It",
                                            "assets/images/unfollowed.png",
                                            gSecondaryColor),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                (e.benefits!.isNotEmpty)
                                    ? Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ...e.benefits!
                                                    .split(' *')
                                                    .map((element) {
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Icon(
                                                          Icons.circle_sharp,
                                                          color: gGreyColor,
                                                          size: 1.h,
                                                        ),
                                                      ),
                                                      SizedBox(width: 1.w),
                                                      Expanded(
                                                        child: Text(
                                                          element.replaceAll(
                                                              "* ", ""),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: MealPlan()
                                                              .subHeadingText(),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(height: 0.5.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
              .toList(),
        ],
      ));
    });
    return data;
  }

  buildMealPlanStatus(String status, String image, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(eUser().buttonBorderRadius),
          color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            status,
            style: TextStyle(
                fontSize: 8.sp, fontFamily: kFontMedium, color: gWhiteColor),
          ),
          SizedBox(width: 1.w),
          Image.asset(
            image,
            height: 2.h,
          )
        ],
      ),
    );
  }

  Color? buildTextColor(String status) {
    if (status == "followed") {
      return textColor = gPrimaryColor;
    } else if (status == "unfollowed") {
      return textColor = gSecondaryColor;
    } else if (status == "Alternative without Doctor") {
      return textColor = gMainColor;
    } else if (status == "Alternative with Doctor") {
      return textColor = gTextColor;
    }
    return textColor;
  }

  getRowHeight() {
    print("MEALPLAN : ${mealPlanData1.values.length}");
    if (mealPlanData1.values.length > 1) {
      return 10.h;
    } else {
      return 6.h;
    }
  }
}
