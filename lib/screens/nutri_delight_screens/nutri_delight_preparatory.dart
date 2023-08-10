import 'package:doctor_app_new/screens/customer_screens/customer_meal_plans/preparatory_answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../model/combined_meal_model/combined_meal_model.dart';
import '../../model/combined_meal_model/new_prep_model.dart';
import '../../model/error_model.dart';
import '../../repository/api_service.dart';
import '../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../services/nutri_delight_service/nutri_delight_service.dart';
import 'package:http/http.dart' as http;

import '../../widgets/widgets.dart';

class NutriDelightPreparatory extends StatefulWidget {
  final int userId;
  const NutriDelightPreparatory({
    Key? key, required this.userId,
  }) : super(key: key);

  @override
  State<NutriDelightPreparatory> createState() =>
      _NutriDelightPreparatoryState();
}

class _NutriDelightPreparatoryState extends State<NutriDelightPreparatory> {
  bool showProgress = false;
 String? totalDaysOfPreparatory;
 String? isPrepCompleted;
 String? currentDay;

  getProgramData() async {
    setState(() {
      showProgress = true;
    });
    final result =
    await ProgramService(repository: repository).getCombinedMealService(widget.userId.toString());
    print("result: $result");

    if (result.runtimeType == CombinedMealModel) {
      print("meal plan");
      CombinedMealModel model = result as CombinedMealModel;

      print('prep.values:${model.prep!.childPrepModel!.details}');
      _childPrepModel = model.prep!.childPrepModel;
      totalDaysOfPreparatory = model.prep?.totalDays.toString();
      isPrepCompleted = model.prep?.childPrepModel?.isPrepCompleted.toString();
      currentDay = model.prep?.childPrepModel?.currentDay.toString();

      getPrepItemsAndStore();
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
  void initState() {
    super.initState();
    getProgramData();
  }

  ChildPrepModel? _childPrepModel;
  Map<String, SubItems> slotNamesForTabs = {};

  List subItemNames = [];
  bool showLoading = true;

  int selectedIndex = 0;
  List<String> list = [];

  Map<String, List<MealSlot>> transition = {};
  final pageController = PageController();

  String selectedSubTab = "";
  List<Map<String, List<MealSlot>>> selectedTabs = [];

   void getPrepItemsAndStore() {
    print("prep--");
    print(_childPrepModel!.toJson());
    if (_childPrepModel != null) {
      slotNamesForTabs.addAll(_childPrepModel!.details!);

      print(slotNamesForTabs);

      final dataList = _childPrepModel?.details ?? {};

      slotNamesForTabs.addAll(dataList);

      slotNamesForTabs.forEach((key, value) {
        list.add(key);
        print("list$list");

        print("LENGTH : $key ==> ${value.subItems!.length}");
      });

      updateTabSize();
    }
  }

  updateTabSize() {
    selectedTabs.clear();
    slotNamesForTabs.forEach((key, value) {
      if (list[selectedIndex] == key) {
        print("tabSize: ${value.subItems!.length}");
        setState(() {
          transition = value.subItems!;
          selectedTabs.add(value.subItems!);
        });
      }
    });

    selectedSubTab = selectedTabs.isEmpty ? "0" :selectedTabs.first.keys.first;

    print("selectedTabs: $selectedTabs");
  }

  @override
  Widget build(BuildContext context) {
    return (showProgress)
        ? Center(
      child: buildCircularIndicator(),
    )
        :  slotNamesForTabs.isEmpty ? buildNoData() :Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: StatefulBuilder(builder: (_, setstate) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "$totalDaysOfPreparatory ",
                        style: MealPlan().headingText(),
                      ),
                      TextSpan(
                        text: "Days preparatory",
                        style: MealPlan().subHeadingText(),
                      ),
                    ]),
                  ),
                 currentDay == "null" ? SizedBox() : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Current Day : ",
                        style: MealPlan().headingText(),
                      ),
                      TextSpan(
                        text: "$currentDay ",
                        style: MealPlan().subHeadingText(),
                      ),

                    ]),
                  ),
                  buildPreparatoryStatus(
                      "$isPrepCompleted"),
                  // (widget.presDay == widget.ppCurrentDay &&
                  //         (widget.presDay.isNotEmpty) &&
                  //         widget.ppCurrentDay.isNotEmpty)
                  //     ? Text(
                  //         "Preparatory Plan Completed by user",
                  //         style: TextStyle(
                  //             fontFamily: fontMedium,
                  //             color: gSecondaryColor,
                  //             fontSize: fontSize08),
                  //       )
                  //     : const SizedBox(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (selectedIndex == 0) {
                            } else {
                              setstate(() {
                                if (selectedIndex > 0) {
                                  selectedIndex--;
                                }
                                updateTabSize();
                                print(selectedIndex);
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: gBlackColor,
                            size: 2.5.h,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            list[selectedIndex],
                            style: MealPlan().tabText(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setstate(() {
                              if (selectedIndex == list.length - 1) {
                              } else {
                                if (selectedIndex >= 0 &&
                                    selectedIndex != list.length - 1) {
                                  selectedIndex++;
                                }
                                print(selectedIndex);
                                updateTabSize();
                                print(selectedIndex);
                              }
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: gBlackColor,
                            size: 2.5.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildPreparatoryMealPlan(),
                  isPrepCompleted == "1"
                      ? GestureDetector(
                          onTap: () {
                            buildPreparatory(
                                "$totalDaysOfPreparatory",
                                context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
                            padding: EdgeInsets.symmetric(vertical: 1.2.h),
                            decoration: BoxDecoration(
                              color: gSecondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Preparatory Status',
                                style: LoginScreen().buttonText(whiteTextColor),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  buildPreparatoryMealPlan() {
    print("transition : $transition");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ...transition.entries.map((e) {
            List<MealSlot> lst = (e.value);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    e.key.toUpperCase(),
                    style: MealPlan().titleText(),
                  ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lst.length,
                  itemBuilder: (_, index) {
                    return SizedBox(
                      height: 15.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 85,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: (lst[index].itemPhoto == null)
                                  ? Image.asset(
                                      'assets/images/meal_placeholder.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      lst[index].itemPhoto ?? '',
                                      errorBuilder: (_, widget, child) {
                                        return Image.asset(
                                          'assets/images/meal_placeholder.png',
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 0.5.h),
                                  RichText(
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor,
                                    text: TextSpan(
                                        text: lst[index].name,
                                        style: MealPlan().headingText(),
                                        children: [
                                          TextSpan(
                                            text: (lst[index].subtitle == null)
                                                ? ''
                                                : '\t\t\t*${lst[index].subtitle}',
                                            style: MealPlan().subtitleText(),
                                          )
                                        ]),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  (lst[index].benefits != null)
                                      ? Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ...lst[index]
                                                    .benefits!
                                                    .split(' -')
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
                                                              "-", ""),
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
                                        )
                                      : const SizedBox(),
                                  SizedBox(height: 0.5.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    // if(index.isEven){
                    return orFiled();
                    // }
                    // else return SizedBox();
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  orFiled() {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              '------------ ',
              style: TextStyle(fontFamily: kFontBold, color: gBlackColor),
            ),
            Text(
              'OR',
              style: TextStyle(fontFamily: kFontBold, color: gBlackColor),
            ),
            Text(
              ' ------------',
              style: TextStyle(fontFamily: kFontBold, color: gBlackColor),
            ),
          ],
        ),
      ),
    );
  }

  buildPreparatoryStatus(String isPrepCompleted) {
    return (isPrepCompleted == "1") && (isPrepCompleted != "null")
        ? Text(
            "Preparatory Plan Completed by user",
            style: TextStyle(
                height: 1.3,
                fontFamily: fontMedium,
                color: gSecondaryColor,
                fontSize: fontSize08),
          )
        : const SizedBox();
  }

  void buildPreparatory(String days, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PreparatoryAnswerScreen(
        days: days,
      ),
    );
  }
}
