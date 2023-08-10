import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/day_plan_list_controller.dart';
import '../../../model/day_plan_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import 'package:get/get.dart';

import '../../meal_plans_screens/meal_pdf.dart';

class DayPlanDetails extends StatefulWidget {

  const DayPlanDetails({Key? key}) : super(key: key);

  @override
  State<DayPlanDetails> createState() => _DayPlanDetailsState();
}

class _DayPlanDetailsState extends State<DayPlanDetails> {
  Color? textColor;
  String selectedDay = "1";

  Map<String, List<DayPlan>> mealPlanData1 = {};
  final pageController = PageController();

  DayPlanListController dayPlanListController =
      Get.put(DayPlanListController());

  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  buildUI() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                text: selectedDay,
                style: MealPlan().headingText(),
              ),
              TextSpan(
                text: " Meal Plan",
                style: MealPlan().subHeadingText(),
              ),
            ]),
          ),
          PopupMenuButton(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            offset: const Offset(0, 30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...dailyProgress
                        .map(
                          (e) => Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    changedIndex(e);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Day $e",
                                  style: TextStyle(
                                      fontFamily: "PoppinsRegular",
                                      color: gTextColor,
                                      fontSize: 8.sp),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                height: 1,
                                color: gGreyColor.withOpacity(0.3),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: gWhiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    "Day $selectedDay",
                    style: TextStyle(
                      fontFamily: "PoppinsRegular",
                      color: gTextColor,
                      fontSize: 8.sp,
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: gGreyColor,
                    size: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder(
              future: dayPlanListController.fetchDayPlanList(selectedDay),
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
                      ],
                    ),
                  );
                  // Column(
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.symmetric(horizontal: 1.w),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(8),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.3),
                  //             blurRadius: 20,
                  //             offset: const Offset(2, 10),
                  //           ),
                  //         ],
                  //       ),
                  //       child: Stack(
                  //         children: [
                  //           Container(
                  //             height: 5.h,
                  //             padding: EdgeInsets.symmetric(horizontal: 5.w),
                  //             decoration: const BoxDecoration(
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(8),
                  //                   topRight: Radius.circular(8)),
                  //               color: gSecondaryColor,
                  //             ),
                  //           ),
                  //           DataTable(
                  //             headingTextStyle: MealPlan().subHeadingText(),
                  //             headingRowHeight: 5.h,
                  //             horizontalMargin: 2.w,
                  //             dataRowHeight: getRowHeight(),
                  //             columns: const <DataColumn>[
                  //               DataColumn(label: Text('Time')),
                  //               DataColumn(label: Text('Meal/Yoga')),
                  //               DataColumn(label: Text('Status')),
                  //             ],
                  //             rows: dataRowWidget(),
                  //             // List.generate(data.data.length, (index) {
                  //             //   print(
                  //             //       "Plan ${data.data[index]["mealTime"].toString()}");
                  //             //   return DataRow(
                  //             //     cells: [
                  //             //       DataCell(
                  //             //         Text(
                  //             //           data.data["B/W 6-8am"][index].mealTime
                  //             //               .toString(),
                  //             //           style: TextStyle(
                  //             //             height: 1.5,
                  //             //             color: gTextColor,
                  //             //             fontSize: 8.sp,
                  //             //             fontFamily: "GothamBold",
                  //             //           ),
                  //             //         ),
                  //             //       ),
                  //             //       DataCell(
                  //             //           Row(
                  //             //             children: [
                  //             //               data.data["B/W 6-8am"][index].type ==
                  //             //                       "yoga"
                  //             //                   ? Row(
                  //             //                       children: [
                  //             //                         GestureDetector(
                  //             //                           onTap: () {},
                  //             //                           child: Image(
                  //             //                             image: const AssetImage(
                  //             //                                 "assets/images/noun-play-1832840.png"),
                  //             //                             height: 2.h,
                  //             //                           ),
                  //             //                         ),
                  //             //                         SizedBox(width: 2.w),
                  //             //                       ],
                  //             //                     )
                  //             //                   : Container(),
                  //             //               Expanded(
                  //             //                 child: Text(
                  //             //                   data.data["B/W 6-8am"][index].name
                  //             //                       .toString(),
                  //             //                   maxLines: 3,
                  //             //                   textAlign: TextAlign.start,
                  //             //                   overflow: TextOverflow.ellipsis,
                  //             //                   style: TextStyle(
                  //             //                     height: 1.5,
                  //             //                     color: gTextColor,
                  //             //                     fontSize: 8.sp,
                  //             //                     fontFamily: "GothamBook",
                  //             //                   ),
                  //             //                 ),
                  //             //               ),
                  //             //             ],
                  //             //           ),
                  //             //           placeholder: true, onTap: () {
                  //             //         Navigator.of(context).push(
                  //             //           MaterialPageRoute(
                  //             //             builder: (ct) => MealPdf(
                  //             //               pdfLink: data.data["B/W 6-8am"][index].url
                  //             //                   .toString(),
                  //             //             ),
                  //             //           ),
                  //             //         );
                  //             //       }),
                  //             //       DataCell(
                  //             //         Container(
                  //             //           width: 18.w,
                  //             //           padding: EdgeInsets.symmetric(
                  //             //               horizontal: 2.w, vertical: 0.5.h),
                  //             //           decoration: BoxDecoration(
                  //             //             color: gWhiteColor,
                  //             //             borderRadius: BorderRadius.circular(5),
                  //             //             border:
                  //             //                 Border.all(color: gMainColor, width: 1),
                  //             //           ),
                  //             //           child: Text(
                  //             //             data.data["B/W 6-8am"][index].status
                  //             //                 .toString(),
                  //             //             overflow: TextOverflow.ellipsis,
                  //             //             style: TextStyle(
                  //             //                 fontFamily: "GothamBook",
                  //             //                 // color: buildTextColor(
                  //             //                 //     data[index].status.toString()),
                  //             //                 fontSize: 8.sp),
                  //             //           ),
                  //             //         ),
                  //             //       ),
                  //             //     ],
                  //             //   );
                  //             // }).toList(),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     (data.comment == "")
                  //         ? const SizedBox()
                  //         : Container(
                  //             width: double.maxFinite,
                  //             margin: EdgeInsets.symmetric(
                  //                 horizontal: 1.w, vertical: 1.h),
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 3.w, vertical: 1.h),
                  //             decoration: BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.circular(8),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Colors.grey.withOpacity(0.3),
                  //                   blurRadius: 20,
                  //                   offset: const Offset(2, 10),
                  //                 ),
                  //               ],
                  //             ),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   "Comments : ",
                  //                   // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
                  //                   style: MealPlan().mealText(),
                  //                 ),
                  //                 SizedBox(height: 1.h),
                  //                 Text(
                  //                   data.comment ?? "",
                  //                   // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
                  //                   style: MealPlan().subHeadingText(),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //   ],
                  // );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: buildCircularIndicator(),
                );
              }),
        ),
      ),
    ]);
  }

  void changedIndex(String index) {
    setState(() {
      selectedDay = index;
      print("selectedDay : $selectedDay");
    });
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
  // buildMealPlan() {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 70.h,
  //         width: double.maxFinite,
  //         child: PageView(
  //           controller: pageController,
  //           children: [
  //             ...dailyProgress
  //                 .map(
  //                   (e) => FutureBuilder(
  //                       future: dayPlanListController.fetchDayPlanList(e),
  //                       builder: (BuildContext context,
  //                           AsyncSnapshot<dynamic> snapshot) {
  //                         if (snapshot.hasError) {
  //                           return const Text("");
  //                         } else if (snapshot.hasData) {
  //                           var data = snapshot.data;
  //                           mealPlanData1 = data.data;
  //                           return SingleChildScrollView(
  //                             physics: const BouncingScrollPhysics(),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 SizedBox(height: 2.h),
  //                                 Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Text(
  //                                       'Day $e Meal Plan',
  //                                       style: MealPlan().headingText(),
  //                                     ),
  //                                     // DropdownButton(
  //                                     //   value: selectedDay,
  //                                     //   style: TextStyle(
  //                                     //       fontSize: 8.sp,
  //                                     //       fontFamily: "GothamBook",
  //                                     //       color: gBlackColor),
  //                                     //   items:
  //                                     //       dailyProgress.map((String items) {
  //                                     //     return DropdownMenuItem(
  //                                     //       value: items,
  //                                     //       child: Text("Day $items"),
  //                                     //     );
  //                                     //   }).toList(),
  //                                     //   onChanged: (String? newValue) {
  //                                     //     setState(() {
  //                                     //       selectedDay = newValue!;
  //                                     //     });
  //                                     //     e = selectedDay;
  //                                     //   },
  //                                     // ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 2.h),
  //                                 Container(
  //                                   margin:
  //                                       EdgeInsets.symmetric(horizontal: 1.w),
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.white,
  //                                     borderRadius: BorderRadius.circular(8),
  //                                     boxShadow: [
  //                                       BoxShadow(
  //                                         color: Colors.grey.withOpacity(0.3),
  //                                         blurRadius: 20,
  //                                         offset: const Offset(2, 10),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   child: Stack(
  //                                     children: [
  //                                       Container(
  //                                         height: 5.h,
  //                                         padding: EdgeInsets.symmetric(
  //                                             horizontal: 5.w),
  //                                         decoration: const BoxDecoration(
  //                                           borderRadius: BorderRadius.only(
  //                                               topLeft: Radius.circular(8),
  //                                               topRight: Radius.circular(8)),
  //                                           color: gSecondaryColor,
  //                                         ),
  //                                       ),
  //                                       DataTable(
  //                                         headingTextStyle:
  //                                             MealPlan().subHeadingText(),
  //                                         headingRowHeight: 5.h,
  //                                         horizontalMargin: 2.w,
  //                                         dataRowHeight: getRowHeight(),
  //                                         columns: const <DataColumn>[
  //                                           DataColumn(label: Text('Time')),
  //                                           DataColumn(
  //                                               label: Text('Meal/Yoga')),
  //                                           DataColumn(label: Text('Status')),
  //                                         ],
  //                                         rows: dataRowWidget(),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 (data.comment == "")
  //                                     ? const SizedBox()
  //                                     : Container(
  //                                         width: double.maxFinite,
  //                                         margin: EdgeInsets.symmetric(
  //                                             horizontal: 1.w, vertical: 1.h),
  //                                         padding: EdgeInsets.symmetric(
  //                                             horizontal: 3.w, vertical: 1.h),
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.white,
  //                                           borderRadius:
  //                                               BorderRadius.circular(8),
  //                                           boxShadow: [
  //                                             BoxShadow(
  //                                               color: Colors.grey
  //                                                   .withOpacity(0.3),
  //                                               blurRadius: 20,
  //                                               offset: const Offset(2, 10),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               "Comments : ",
  //                                               // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
  //                                               style: MealPlan().mealText(),
  //                                             ),
  //                                             SizedBox(height: 1.h),
  //                                             Text(
  //                                               data.comment ?? "",
  //                                               // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
  //                                               style:
  //                                                   MealPlan().subHeadingText(),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                               ],
  //                             ),
  //                           );
  //                         }
  //                         return Padding(
  //                           padding: EdgeInsets.symmetric(vertical: 10.h),
  //                           child: buildCircularIndicator(),
  //                         );
  //                       }),
  //                 )
  //                 .toList(),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 1.h),
  //       SmoothPageIndicator(
  //         controller: pageController,
  //         count: dailyProgress.length,
  //         axisDirection: Axis.horizontal,
  //         effect: ScrollingDotsEffect(
  //           dotColor: Colors.amberAccent,
  //           activeDotColor: gSecondaryColor,
  //           dotHeight: 1.h,
  //           dotWidth: 2.w,
  //           //jumpScale: 2,
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
              placeholder: true,
            ),
            DataCell(
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...value
                      .map((e) => GestureDetector(
                            onTap: () => MealPdf(
                              pdfLink: e.url!,
                              heading: '',
                            ),
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
              placeholder: true,
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
    print("MEALPLAN : ${mealPlanData1.values.length}");
    if (mealPlanData1.values.length > 1) {
      return 10.h;
    } else {
      return 6.h;
    }
  }
}
