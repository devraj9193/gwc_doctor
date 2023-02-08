import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../model/day_plan_model.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'package:get/get.dart';
import '../../controller/day_plan_list_controller.dart';
import '../customer_screens/customers_details/daily_progress_screens/day_tracker.dart';
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
        appBar: buildAppBar(() {
          Navigator.pop(context);
        }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                'Day ${widget.selectedDay} Meal Plan',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: "GothamMedium",
                    color: gPrimaryColor),
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: buildMealPlan(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => DayMealTracerUI(
                      day: widget.selectedDay,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 1.h),
                padding: EdgeInsets.symmetric(vertical: 1.2.h),
                decoration: BoxDecoration(
                  color: gPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gMainColor, width: 1),
                ),
                child: Center(
                  child: Text(
                    'Day Tracker',
                    style: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gMainColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildMealPlan() {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: dayPlanListController.fetchDayPlanList(widget.selectedDay),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text("");
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              mealPlanData1 = data.data;
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
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
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffE06666),
                                  Color(0xff93C47D),
                                  Color(0xffFFD966),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight),
                          ),
                        ),
                        DataTable(
                          headingTextStyle: TextStyle(
                            color: gWhiteColor,
                            fontSize: 9.sp,
                            fontFamily: "GothamMedium",
                          ),
                          headingRowHeight: 5.h,
                          horizontalMargin: 2.w,
                          dataRowHeight: getRowHeight(),
                          columns: const <DataColumn>[
                            DataColumn(label: Text('Time')),
                            DataColumn(label: Text('Meal/Yoga')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: dataRowWidget(),
                        ),
                      ],
                    ),
                  ),
                  (data.comment == "")
                      ? const SizedBox()
                      : Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Comments : ",
                                // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    height: 1.3,
                                    fontFamily: "GothamBook",
                                    color: gPrimaryColor),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                data.comment ?? "",
                                // 'Lorem ipsum is simply dummy text of the printing and typesetting industry.Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type.',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    height: 1.3,
                                    fontFamily: "GothamBook",
                                    color: gTextColor),
                              ),
                            ],
                          ),
                        ),
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

  List<DataRow> dataRowWidget() {
    List<DataRow> data = [];
    mealPlanData1.forEach((dayTime, value) {
      data.add(
        DataRow(
          cells: [
            DataCell(
              Text(
                dayTime,
                style: TextStyle(
                  height: 1.5,
                  color: gTextColor,
                  fontSize: 8.sp,
                  fontFamily: "GothamBold",
                ),
              ),
            ),
            DataCell(
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...value
                      .map((e) => GestureDetector(
                            onTap: () => MealPdf(pdfLink: e.url!),
                            child: Row(
                              children: [
                                e.type == 'yoga'
                                    ? GestureDetector(
                                        onTap: () {},
                                        child: Image(
                                          image: const AssetImage(
                                              "assets/images/noun-play-1832840.png"),
                                          height: 2.h,
                                        ),
                                      )
                                    : const SizedBox(),
                                if (e.type == 'yoga') SizedBox(width: 2.w),
                                Expanded(
                                  child: Text(
                                    " ${e.name.toString()}",
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
                          border: Border.all(color: gMainColor, width: 1),
                        ),
                        child: Text(
                          e.status.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "GothamBook",
                              color: buildTextColor(e.status.toString()),
                              fontSize: 8.sp),
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
