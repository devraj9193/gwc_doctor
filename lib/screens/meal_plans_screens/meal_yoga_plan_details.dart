import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/day_plan_model.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import 'package:get/get.dart';
import '../../controller/day_plan_list_controller.dart';
import '../nutri_delight_screens/daily_progress_screens/day_tracker.dart';
import 'meal_pdf.dart';

class MealYogaPlanDetails extends StatefulWidget {
  final String selectedDay;
  const MealYogaPlanDetails({Key? key, required this.selectedDay})
      : super(key: key);

  @override
  State<MealYogaPlanDetails> createState() => _MealYogaPlanDetailsState();
}

class _MealYogaPlanDetailsState extends State<MealYogaPlanDetails> {
  Color? textColor;

  Map<String, List<DayPlan>> mealPlanData1 = {};

  DayPlanListController dayPlanListController =
      Get.put(DayPlanListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: buildAppBar(() {
          Navigator.pop(context);
        }),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
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
              SizedBox(height: 2.h),
              buildMealPlan(),
            ],
          ),
        ),
      ),
    );
  }

  buildMealPlan() {
    return Expanded(
      child: FutureBuilder(
          future: dayPlanListController.fetchDayPlanList(widget.selectedDay),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text("");
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              mealPlanData1 = data.data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...groupList(),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (ct) => DayMealTracerUI(
                        //       day: widget.selectedDay,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
                        padding: EdgeInsets.symmetric(vertical: 1.2.h),
                        decoration: BoxDecoration(
                          color: gSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Day Tracker',
                            style: TextStyle(
                              fontFamily: "GothamMedium",
                              color: gWhiteColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: buildCircularIndicator(),
            );
          }),
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
                        (e.itemPhoto != null && e.itemPhoto!.isNotEmpty)
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: e.itemPhoto!,
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
                                                element.replaceAll("* ",""),
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
                const Divider()
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

  List<DataRow> dataRowWidget() {
    List<DataRow> data = [];
    mealPlanData1.forEach((dayTime, value) {
      data.add(
        DataRow(
          cells: [
            DataCell(
              Text(
                dayTime,
                style: MealPlan().timeText(),
              ),
            ),
            DataCell(
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...value
                      .map((e) => GestureDetector(
                            onTap: () => MealPdf(pdfLink: e.url!, heading: '',),
                            child: Expanded(
                              child: Text(
                                " ${e.name.toString()}",
                                maxLines: 3,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: MealPlan().mealText(),
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
              placeholder: true,
            ),
            DataCell(
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...value.map((e) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: Container(
                        width: 18.w,
                        margin: EdgeInsets.symmetric(vertical: 0.2.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: gWhiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: lightTextColor, width: 1),
                        ),
                        child: Text(
                          e.status.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: fontBook,
                              color: buildTextColor(e.status.toString()),
                              fontSize: fontSize08),
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ],
        ),
      );
    });
    return data;
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
    if (mealPlanData1.values.length > 1) {
      return 8.h;
    } else {
      return 6.h;
    }
  }
}
