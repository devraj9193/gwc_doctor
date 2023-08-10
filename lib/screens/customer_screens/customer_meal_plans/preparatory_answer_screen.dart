import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../model/combined_meal_model/all_day_tracker_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';

class PreparatoryAnswerScreen extends StatefulWidget {
  final String days;
  const PreparatoryAnswerScreen({Key? key, required this.days})
      : super(key: key);

  @override
  State<PreparatoryAnswerScreen> createState() =>
      _PreparatoryAnswerScreenState();
}

class _PreparatoryAnswerScreenState extends State<PreparatoryAnswerScreen> {
  AllDayTrackerModel? allDayTrackerModel;
  Preparatory? preparatory;
  bool isLoading = false;

  getProgramData() async {
    setState(() {
      isLoading = true;
    });
    final result =
        await ProgramService(repository: repository).getAllDayTrackerService();
    print("result: $result");

    if (result.runtimeType == AllDayTrackerModel) {
      print("meal plan");
      AllDayTrackerModel model = result as AllDayTrackerModel;
      preparatory = model.preparatory!;

      print("Detox Tracker : ${model.detox}");
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

  final ProgramRepository repository = ProgramRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: 38.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: const BoxDecoration(
          color: gWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '${widget.days} Days Preparatory',
                        style: TabBarText().bottomSheetHeadingText(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: mediumTextColor, width: 1),
                      ),
                      child: Icon(
                        Icons.clear,
                        color: mediumTextColor,
                        size: 1.6.h,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
              height: 1,
              color: lightTextColor,
            ),
            buildStatus(),
          ],
        ),
      ),
    );
  }

  buildStatus() {
    return   Expanded(
      child: SingleChildScrollView(
        child: (isLoading)
            ? Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: buildCircularIndicator(),
        )
            : Column(
          children: [
            buildRadioButton("Has your hunger improved?",
                "${preparatory?.hungerImproved}"),
            buildRadioButton("Has your appetite improved?","${preparatory?.appetiteImproved}"),
            buildRadioButton("Are you feeling light?","${preparatory?.feelingLight}"),
            buildRadioButton("Are you feeling energetic?","${preparatory?.feelingEnergetic}"),
            buildRadioButton(
                "Are you feeling a mild reduction in your primary symptoms?","${preparatory?.mildReduction}"),
          ],
        ),
      ),
    );
  }

  buildRadioButton(String question, String radio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: EvaluationText().questionText(),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Radio(
              value: "Yes",
              activeColor: gSecondaryColor,
              groupValue: radio,
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              onChanged: (value) {},
            ),
            Text('Yes', style: EvaluationText().answerText()),
            SizedBox(width: 2.w),
            Radio(
              value: "No",
              activeColor: gSecondaryColor,
              visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              //  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              groupValue: radio,
              onChanged: (value) {},
            ),
            Text('No', style: EvaluationText().answerText()),
          ],
        ),
        Container(
          height: 1.0,
          margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}
