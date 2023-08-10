import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../../model/combined_meal_model/all_day_tracker_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';
import 'package:http/http.dart' as http;

class AllDayTracker extends StatefulWidget {
  final String tabIndex;
  const AllDayTracker({
    Key? key,
    required this.tabIndex,
  }) : super(key: key);

  @override
  State<AllDayTracker> createState() => _AllDayTrackerState();
}

class _AllDayTrackerState extends State<AllDayTracker>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  AllDayTrackerModel? allDayTrackerModel;
  List<Detox> detoxTracker = [];
  List<Detox> healingTracker = [];
  List<Detox> nourishTracker = [];

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
      detoxTracker = model.detox!;
      healingTracker = model.healing!;
      nourishTracker = model.nourish!;

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
    tabController = TabController(
      initialIndex: int.parse(widget.tabIndex),
      length: 3,
      vsync: this,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    tabController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  final ProgramRepository repository = ProgramRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: gWhiteColor,
        appBar: buildAppBar(() {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          Navigator.pop(context);
        }),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: tabController,
                labelColor: eUser().userFieldLabelColor,
                unselectedLabelColor: eUser().userTextFieldColor,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                isScrollable: true,
                indicatorColor: gSecondaryColor,
                labelStyle: TextStyle(
                  fontFamily: kFontMedium,
                  color: gPrimaryColor,
                  fontSize: 12.sp,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: kFontBook,
                  color: gHintTextColor,
                  fontSize: 10.sp,
                ),
                labelPadding: EdgeInsets.only(
                    right: 10.w, left: 2.w, top: 1.h, bottom: 1.h),
                indicatorPadding: EdgeInsets.only(right: 7.w),
                tabs: const [
                  Text('Detox'),
                  Text('Healing'),
                  Text('Nourish'),
                ],
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 5.w, bottom: 2.h),
                color: gGreyColor.withOpacity(0.3),
                width: double.maxFinite,
              ),
              (isLoading)
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: buildCircularIndicator(),
                    )
                  : Expanded(
                      child: TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          buildDetoxTracker(),
                          buildHealingTracker(),
                          buildNourishTracker(),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  buildDetoxTracker() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DataTable(
            headingRowHeight: 15.h,
            dataRowHeight: 15.h,
            // horizontalMargin: 0,
            columnSpacing: 5.w,
            dataTextStyle: MealPlan().trackerAnswer(),
            border: TableBorder.all(
              width: 1.0,
              color: gGreyColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    textAlign: TextAlign.start,
                    'Questions',
                    style: MealPlan().trackerHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Withdrawal Symptoms From Detox Today?',
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Detoxification / Healing Signs And Symptoms Happen To You Today?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Have Any Other Worries',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Did You Eat Something Other Than Meal Plan?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Did You Complete The Calm And Move Modules ?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Any Medications During The Program?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Attachments',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
            ],
            rows: List.generate(detoxTracker.length, (index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text("Day ${detoxTracker[index].day}"),
                  ),
                  DataCell(withdrawalText(
                      "${detoxTracker[index].withdrawalSymptoms}")),
                  DataCell(detoxificationText(
                      '${detoxTracker[index].detoxification}')),
                  DataCell(Text('${detoxTracker[index].haveAnyOtherWorries}')),
                  DataCell(Text('${detoxTracker[index].eatSomethingOther}')),
                  DataCell(
                      Text('${detoxTracker[index].completedCalmMoveModules}')),
                  DataCell(Text(
                      '${detoxTracker[index].hadAMedicalExamMedications}')),
                  DataCell(
                    attachmentsImages(
                        '${detoxTracker[index].trackingAttachmentFullPath}'),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  buildHealingTracker() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DataTable(
            headingRowHeight: 15.h,
            dataRowHeight: 15.h,
            // horizontalMargin: 0,
            columnSpacing: 5.w,
            dataTextStyle: MealPlan().trackerAnswer(),
            border: TableBorder.all(
              width: 1.0,
              color: gGreyColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    textAlign: TextAlign.start,
                    'Questions',
                    style: MealPlan().trackerHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Withdrawal Symptoms From Detox Today?',
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Detoxification / Healing Signs And Symptoms Happen To You Today?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Have Any Other Worries',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Did You Eat Something Other Than Meal Plan?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Did You Complete The Calm And Move Modules ?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Any Medications During The Program?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Attachments',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
            ],
            rows: List.generate(healingTracker.length, (index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text("Day ${healingTracker[index].day}"),
                  ),
                  DataCell(withdrawalText(
                      "${healingTracker[index].withdrawalSymptoms}")),
                  DataCell(detoxificationText(
                      '${healingTracker[index].detoxification}')),
                  DataCell(
                      Text('${healingTracker[index].haveAnyOtherWorries}')),
                  DataCell(Text('${healingTracker[index].eatSomethingOther}')),
                  DataCell(Text(
                      '${healingTracker[index].completedCalmMoveModules}')),
                  DataCell(Text(
                      '${healingTracker[index].hadAMedicalExamMedications}')),
                  DataCell(
                    attachmentsImages(
                        '${healingTracker[index].trackingAttachmentFullPath}'),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  buildNourishTracker() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DataTable(
            headingRowHeight: 15.h,
            dataRowHeight: 15.h,
            // horizontalMargin: 0,
            columnSpacing: 5.w,
            dataTextStyle: MealPlan().trackerAnswer(),
            border: TableBorder.all(
              width: 1.0,
              color: gGreyColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    textAlign: TextAlign.start,
                    'Questions',
                    style: MealPlan().trackerHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Withdrawal Symptoms From Detox Today?',
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Detoxification / Healing Signs And Symptoms Happen To You Today?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Have Any Other Worries',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Did You Eat Something Other Than Meal Plan?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Did You Complete The Calm And Move Modules ?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Any Medications During The Program?',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    softWrap: true,
                    'Attachments',
                    style: MealPlan().trackerSubHeading(),
                  ),
                ),
              ),
            ],
            rows: List.generate(nourishTracker.length, (index) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text("Day ${nourishTracker[index].day}"),
                  ),
                  DataCell(withdrawalText(
                      "${nourishTracker[index].withdrawalSymptoms}")),
                  DataCell(detoxificationText(
                      '${nourishTracker[index].detoxification}')),
                  DataCell(
                      Text('${nourishTracker[index].haveAnyOtherWorries}')),
                  DataCell(Text('${nourishTracker[index].eatSomethingOther}')),
                  DataCell(Text(
                      '${nourishTracker[index].completedCalmMoveModules}')),
                  DataCell(Text(
                      '${nourishTracker[index].hadAMedicalExamMedications}')),
                  DataCell(
                    attachmentsImages(
                        '${nourishTracker[index].trackingAttachmentFullPath}'),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget withdrawalText(String title) {
    var tex = title.replaceAll(RegExp(r'[^\w\s]+'), ' ');
    print("$tex");
    return Text("$tex");
  }

  Widget detoxificationText(String title) {
    var tex = title.replaceAll(RegExp(r'[^\w\s]+'), ' ');
    print("$tex");
    return Text("$tex");
  }

  attachmentsImages(String title) {
    print("attachments : $title");
    return title == "null" ? Text("") : GestureDetector(
      onTap: () {
        imageDialog(title);
      },
      child: Container(
        height: 7.h,
        width: 12.w,
        decoration: BoxDecoration(
          color: gGreyColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image(
          image: NetworkImage(
            title,
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  imageDialog(String imageUrl) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0.sp),
          ),
        ),
        contentPadding: EdgeInsets.only(top: 1.h),
        content: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(
              imageUrl,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
