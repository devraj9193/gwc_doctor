import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import '../../../model/day_progress_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'all_day_tracker.dart';
import 'daily_progress_meal_plan.dart';

class ProgressDetails extends StatefulWidget {
  final int userId;
  const ProgressDetails({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProgressDetails> createState() => _ProgressDetailsState();
}

class _ProgressDetailsState extends State<ProgressDetails> {
  Color? textColor;
  DayProgressModel? dayProgressModel;
  bool isLoading = false;
  List<double> detoxData = [];
  List<double> healingData = [];

  getProgramData() async {
    setState(() {
      isLoading = true;
    });
    final result = await ProgramService(repository: repository)
        .getProgressService("${widget.userId}");
    print("result: $result");

    if (result.runtimeType == DayProgressModel) {
      print("meal plan");
      DayProgressModel model = result as DayProgressModel;
      dayProgressModel = model;

      setState(() {
        detoxData = dayProgressModel?.detoxDayWiseProgress ?? [];
        healingData = dayProgressModel?.healingDayWiseProgress ?? [];
      });
      print("dayProgressModel : $dayProgressModel");
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    setState(() {
      isLoading = false;
    });
    print(result);
  }

  @override
  void initState() {
    super.initState();
    getProgramData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: isLoading
          ? Padding(
        padding:  EdgeInsets.symmetric(vertical: 15.h),
        child: buildCircularIndicator(),
      )
          : Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          buildHealingProgress(detoxData, "Detox"),
          // SizedBox(height: 2.h),
          // buildTrackerButton("Detox Tracker","0"),
          buildHealingProgress(healingData, "Healing"),
          // SizedBox(height: 2.h),
          // buildTrackerButton("Healing Tracker","1"),
          SizedBox(height: 4.h),
          buildTrackerButton("Tracker","0"),
        ],
      ),
    );
  }

  Color? buildTextColor(double value) {
    if (0.3 > value) {
      textColor = gSecondaryColor;
    } else if (0.6 > value) {
      textColor = gMainColor;
    } else if (1.0 >= value) {
      textColor = gPrimaryColor;
    } else if (1.0 < value) {
      textColor = gPrimaryColor;
    }
    return textColor;
  }

  buildCenterText(double data) {
    if (100 < data) {
      return Text(
        "100 %",
        style: TextStyle(
            fontSize: 8.sp, fontFamily: "GothamBook", color: gBlackColor),
      );
    } else {
      return Text(
        "${data.toStringAsFixed(2)} %",
        style: TextStyle(
            fontSize: 8.sp, fontFamily: "GothamBook", color: gBlackColor),
      );
    }
  }

  buildBar(double y) {
    if (1.0 < y) {
      return 1.0;
    } else {
      return y;
    }
  }

  buildHealingProgress(List<double> healing, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          "$title Progress",
          style: AllListText().headingText(),
        ),
        SizedBox(height: 1.h),
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: healing.length,
          itemBuilder: ((context, index) {
            double y = healing[index] / 100.toDouble();
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ct) => DailyProgressMealPlan(
                        selectedDay: "${index + 1}",
                        detoxOrHealing: (title == "Detox") ? '1' : "2",
                      ),
                    ),
                  );
                },
                child: LinearPercentIndicator(
                  leading: Text(
                    "Day - ${index + 1}",
                    style: TextStyle(
                        fontSize: fontSize09,
                        fontFamily: fontMedium,
                        color: newBlackColor),
                  ),
                  animation: true,
                  lineHeight: 2.h,
                  animationDuration: 5000,
                  percent: buildBar(y),
                  center: buildCenterText(healing[index]),
                  backgroundColor: const Color(0xffECF0FA),
                  progressColor: buildTextColor(y),
                  barRadius: const Radius.circular(10),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  buildTrackerButton(String title,String index){
    return IntrinsicWidth(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  AllDayTracker(tabIndex: index,),
            ),
          );
        },
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 5.w),
          decoration: BoxDecoration(
            color: gSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: LoginScreen().buttonText(whiteTextColor),
            ),
          ),
        ),
      ),
    );
  }

  final ProgramRepository repository = ProgramRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

}
