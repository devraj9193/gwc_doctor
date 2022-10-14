import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../controller/day_plan_list_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'package:get/get.dart';

import 'meal_pdf.dart';

class DayPlanDetails extends StatefulWidget {
  const DayPlanDetails({Key? key}) : super(key: key);

  @override
  State<DayPlanDetails> createState() => _DayPlanDetailsState();
}

class _DayPlanDetailsState extends State<DayPlanDetails> {
  Color? textColor;
  String selectedDay = "1";

  var items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
  ];

  DayPlanListController dayPlanListController =
      Get.put(DayPlanListController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Day $selectedDay Meal Plan',
              style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: "GothamMedium",
                  color: gPrimaryColor),
            ),
            DropdownButton(
              value: selectedDay,
              style: TextStyle(
                  fontSize: 8.sp, fontFamily: "GothamBook", color: gBlackColor),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text("Day $items"),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: buildMealPlan(),
          ),
        ),
      ],
    );
  }

  buildMealPlan() {
    return FutureBuilder(
        future: dayPlanListController.fetchDayPlanList(selectedDay),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Text("");
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(2, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 5.h,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          gradient: LinearGradient(colors: [
                            Color(0xffE06666),
                            Color(0xff93C47D),
                            Color(0xffFFD966),
                          ], begin: Alignment.topLeft, end: Alignment.topRight),
                        ),
                      ),
                      DataTable(
                        headingTextStyle: TextStyle(
                          color: gWhiteColor,
                          fontSize: 10.sp,
                          fontFamily: "GothamMedium",
                        ),
                        headingRowHeight: 5.h,
                        horizontalMargin: 2.w,
                       // columnSpacing: 50,
                        dataRowHeight: 6.h,
                        // headingRowColor:
                        //     MaterialStateProperty.all(const Color(0xffE06666)),
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Time')),
                          DataColumn(label: Text('Meal/Yoga')),
                          DataColumn(label: Text('  Status  ')),
                        ],
                        rows: List.generate(data.data.length, (index) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  data.data[index].mealTime.toString(),
                                  style: TextStyle(
                                    height: 1.5,
                                    color: gTextColor,
                                    fontSize: 8.sp,
                                    fontFamily: "GothamBold",
                                  ),
                                ),
                              ),
                              DataCell(
                                  Row(
                                    children: [
                                      data.data[index].type == "yoga"
                                          ? Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Image(
                                                    image: const AssetImage(
                                                        "assets/images/noun-play-1832840.png"),
                                                    height: 2.h,
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                              ],
                                            )
                                          : Container(),
                                      Expanded(
                                        child: Text(
                                          data.data[index].name.toString(),
                                          maxLines: 3,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 1.5,
                                            color: gTextColor,
                                            fontSize: 8.sp,
                                            fontFamily: "GothamBook",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  placeholder: true, onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ct) => MealPdf(
                                      pdfLink: data.data[index].url.toString(),
                                    ),
                                  ),
                                );
                              }),
                              DataCell(
                                Container(
                                  width: 18.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 0.5.h),
                                  decoration: BoxDecoration(
                                    color: gWhiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: gMainColor, width: 1),
                                  ),
                                  child: Text(
                                    data.data[index].status.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "GothamBook",
                                        // color: buildTextColor(
                                        //     data[index].status.toString()),
                                        fontSize: 8.sp),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                //  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(2, 10),
                      ),
                    ],
                  ),
                  child: Text(
                    data.comment ?? "",
                   // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
                    style: TextStyle(
                        fontSize: 10.sp,
                        height: 1.3,
                        fontFamily: "GothamBook",
                        color: gTextColor),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: buildCircularIndicator(),
          );
        });
  }

  Color? buildTextColor(String status) {
    if (status == "Followed") {
      textColor = gPrimaryColor;
    } else if (status == "UnFollowed") {
      textColor = gSecondaryColor;
    } else if (status == "Alternative without Doctor") {
      textColor = gMainColor;
    } else if (status == "Alternative with Doctor") {
      textColor = gTextColor;
    }
    return textColor!;
  }
}
