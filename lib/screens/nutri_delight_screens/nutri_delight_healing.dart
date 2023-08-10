import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app_new/screens/nutri_delight_screens/recipe_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../model/combined_meal_model/combined_meal_model.dart';
import '../../model/combined_meal_model/detox_nourish_model/child_detox_model.dart';
import '../../model/combined_meal_model/detox_nourish_model/detox_healing_common_model/child_meal_plan_details_model1.dart';
import '../../model/combined_meal_model/detox_nourish_model/detox_healing_common_model/detox_healing_model.dart';
import '../../model/combined_meal_model/new_healing_model.dart';
import '../../model/error_model.dart';
import '../../repository/api_service.dart';
import '../../repository/nutri_delight_repo/nutri_delight_repository.dart';
import '../../services/nutri_delight_service/nutri_delight_service.dart';
import '../../widgets/widgets.dart';
import 'daily_progress_screens/all_day_tracker.dart';
import 'package:http/http.dart' as http;

class NutriDelightHealing extends StatefulWidget {
  final int userId;
  const NutriDelightHealing({Key? key, required this.userId}) : super(key: key);

  @override
  State<NutriDelightHealing> createState() => _NutriDelightHealingState();
}

class _NutriDelightHealingState extends State<NutriDelightHealing> {
  bool showProgress = false;
  NewHealingModel? healing;
  String? currentDay;

  getProgramData() async {
    setState(() {
      showProgress = true;
    });
    final result = await ProgramService(repository: repository)
        .getCombinedMealService(widget.userId.toString());
    print("result: $result");

    if (result.runtimeType == CombinedMealModel) {
      print("meal plan");
      CombinedMealModel model = result as CombinedMealModel;
      healing = model.healing;
      if (model.healing != null) {
        _childDetoxModel = model.healing?.value;

        getDetoxItems();
      }
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

  Color? textColor;
  String selectedDay = "1";
  String isDayCompleted = "";

  List listOfDays = [];
  int selectedIndex = 0;

  ChildDetoxModel? _childDetoxModel;
  Map<String, DetoxHealingModel> getDetoxDetails = {};
  Map<String, List<ChildMealPlanDetailsModel1>> mealPlanData1 = {};

  List<Map<String, List<ChildMealPlanDetailsModel1>>> selectedTabs = [];

  void getDetoxItems() {
    print("prep--");
    print(_childDetoxModel!.toJson());
    if (_childDetoxModel != null) {
      getDetoxDetails.addAll(_childDetoxModel!.details!);

      print(getDetoxDetails);

      final dataList = _childDetoxModel?.details ?? {};

      getDetoxDetails.addAll(dataList);

      getDetoxDetails.forEach((key, value) {
        listOfDays.add(key);
        print("list$listOfDays");

        // mealPlanData1.addAll(value.data!);
      });
    }

    updateDayMealPlans();
  }

  updateDayMealPlans() {
    selectedTabs.clear();
    // mealPlanData1.clear();
    getDetoxDetails.forEach((key, value) {
      if (listOfDays[selectedIndex] == key) {
        print("tabSize: ${value.data!.length}");
        setState(() {
          isDayCompleted = value.isDayCompleted.toString();
          mealPlanData1 = value.data!;
          selectedTabs.add(value.data!);
          print("mealPlanData1 : $mealPlanData1");
          print("DetoxMeal Plan : $selectedTabs");
        });
      }
    });
    currentDay = _childDetoxModel?.currentDay;
    // selectedSubTab = selectedTabs.first.keys.first;

    print("selectedTabs: $selectedTabs");
  }

  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  buildUI() {
    return (showProgress)
        ? Center(
            child: buildCircularIndicator(),
          )
        : healing == null
            ? buildNoData()
            : Column(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          currentDay == "null"
                              ? SizedBox()
                              : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "Current Day : ",
                                      style: MealPlan().subHeadingText(),
                                    ),
                                    TextSpan(
                                      text: "$currentDay ",
                                      style: MealPlan().headingText(),
                                    ),
                                  ]),
                                ),
                        ],
                      ),
                      PopupMenuButton(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        offset: const Offset(0, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...listOfDays
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
                                            margin: EdgeInsets.symmetric(
                                                vertical: 1.h),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...groupList(),
                          isDayCompleted == "1"
                              ? IntrinsicWidth(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ct) => AllDayTracker(
                                            tabIndex: '1',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0.w, vertical: 3.h),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.2.h, horizontal: 3.w),
                                      decoration: BoxDecoration(
                                        color: gSecondaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Day $selectedDay Tracker',
                                          style: TextStyle(
                                            fontFamily: "GothamMedium",
                                            color: gWhiteColor,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }

  void changedIndex(String index) {
    setState(() {
      selectedDay = index;
      selectedIndex = int.parse(index) - 1;
      print("selectedDay : $selectedDay");
      print("selectedIndex : $selectedIndex");
      updateDayMealPlans();
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MealPlanRecipeDetails(
                                     mealPlanRecipe: e,
                                    isFromProgram: true,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: (e.itemImage != null &&
                                      e.itemImage!.isNotEmpty)
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
                                        : (e.status == "unfollowed")
                                            ? buildMealPlanStatus(
                                                "Missed It",
                                                "assets/images/unfollowed.png",
                                                gSecondaryColor)
                                            : const SizedBox(),
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
