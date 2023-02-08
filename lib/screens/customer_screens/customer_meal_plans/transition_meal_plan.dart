import 'package:doctor_app_new/screens/customer_screens/customer_meal_plans/transition_answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/transition_controller.dart';
import '../../../model/preparatory_transition_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';
import '../../meal_plans_screens/meal_pdf.dart';

class TransitionMealPlan extends StatefulWidget {
  final String transitionCurrentDay;
  final bool isTransition;
  const TransitionMealPlan(
      {Key? key, required this.transitionCurrentDay, this.isTransition = false})
      : super(key: key);

  @override
  State<TransitionMealPlan> createState() => _TransitionMealPlanState();
}

class _TransitionMealPlanState extends State<TransitionMealPlan> {
  Color? textColor;

  Map<String, List<Preparatory>> transition = {};
  final pageController = PageController();

  TransitionController transitionController = Get.put(TransitionController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
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
    return Column(
      children: [
        FutureBuilder(
            future: transitionController.fetchDayPlanList(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Text("");
              } else if (snapshot.hasData) {
                var data = snapshot.data;
                transition = data.data;
                return (data.data == null)
                    ? buildNoData()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),
                          Text(
                            '${data.days ?? ""} Days Transition',
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: "GothamMedium",
                                color: gBlackColor),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Current Day : ${widget.transitionCurrentDay}',
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: "GothamMedium",
                                color: gPrimaryColor),
                          ),
                          SizedBox(height: 1.h),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
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
                                  columnSpacing: 100,
                                  headingRowHeight: 5.h,
                                  horizontalMargin: 5.w,
                                  dataRowHeight: getRowHeight(),
                                  columns: const <DataColumn>[
                                    DataColumn(label: Text('Time')),
                                    DataColumn(label: Text('Meal/Yoga')),
                                    //    DataColumn(label: Text('Status')),
                                  ],
                                  rows: dataRowWidget(),
                                ),
                              ],
                            ),
                          ),
                          (widget.isTransition)
                              ? GestureDetector(
                                  onTap: () {
                                    buildPreparatory(data.days ?? "",
                                        widget.transitionCurrentDay, context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.2.h),
                                    decoration: BoxDecoration(
                                      color: gPrimaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: gMainColor, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Transition Tracker',
                                        style: TextStyle(
                                          fontFamily: "GothamMedium",
                                          color: gMainColor,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      );
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: buildCircularIndicator(),
              );
            }),
      ],
    );
  }

  List<DataRow> dataRowWidget() {
    List<DataRow> data = [];
    transition.forEach((dayTime, value) {
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
                            onTap: () {
                              Get.to(
                                () => MealPdf(pdfLink: e.recipeUrl),
                              );
                            },
                            child: Row(
                              children: [
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
    if (transition.values.length > 1) {
      return 8.h;
    } else {
      return 6.h;
    }
  }

  void buildPreparatory(String days, String currentDay, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => TransitionAnswerScreen(
              days: days,
              currentDay: currentDay,
            ));
  }
}
