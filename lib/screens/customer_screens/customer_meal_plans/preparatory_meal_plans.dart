import 'dart:convert';

import 'package:doctor_app_new/screens/customer_screens/customer_meal_plans/preparatory_answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../model/preparatory_transition_model.dart';
import '../../../utils/app_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/gwc_apis.dart';
import '../../../widgets/common_screen_widgets.dart';
import '../../../widgets/widgets.dart';

class PreparatoryMealPlan extends StatefulWidget {
  final String preparatoryCurrentDay;
  final String ppCurrentDay;
  final String presDay;
  const PreparatoryMealPlan(
      {Key? key,
      required this.preparatoryCurrentDay,
      required this.ppCurrentDay,
      required this.presDay})
      : super(key: key);

  @override
  State<PreparatoryMealPlan> createState() => _PreparatoryMealPlanState();
}

class _PreparatoryMealPlanState extends State<PreparatoryMealPlan> {
  PreparatoryTransitionModel? preparatoryTransitionModel;

  Map<String, List<Preparatory>> tabs = {};

  Map<String, SubItems> slotNamesForTabs = {};

  List subItemNames = [];
  bool showLoading = true;

  int selectedIndex = 0;
  List<String> list = [];

  Map<String, List<Preparatory>> transition = {};
  final pageController = PageController();

  String selectedSubTab = "";
  List<Map<String, List<Preparatory>>> selectedTabs = [];

  @override
  void initState() {
    super.initState();
    getTransitionMeals();
  }

  getTransitionMeals() async {
    dynamic res;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString(AppConfig().bearerToken)!;
    var userId = preferences.getString("user_id")!;
    print(userId);

    final response = await http
        .get(Uri.parse("${GwcApi.preparatoryApiUrl}/$userId"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("meal: ${response.body}");
      res = jsonDecode(response.body);
      preparatoryTransitionModel = PreparatoryTransitionModel.fromJson(res);
      print("object: ${preparatoryTransitionModel?.data}");

      final dataList = preparatoryTransitionModel?.data ?? {};

      slotNamesForTabs.addAll(dataList);

      slotNamesForTabs.forEach((key, value) {
        list.add(key);

        print("LENGTH : $key ==> ${value.subItems!.length}");
      });

      updateTabSize();
    }
    setState(() {
      showLoading = false;
    });
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

    selectedSubTab = selectedTabs.first.keys.first;

    print("selectedTabs: $selectedTabs");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        showLoading
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: buildCircularIndicator(),
                ),
              )
            : Expanded(
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
                              text:
                                  "${preparatoryTransitionModel?.days ?? " "} ",
                              style: MealPlan().headingText(),
                            ),
                            TextSpan(
                              text: "Days preparatory",
                              style: MealPlan().subHeadingText(),
                            ),
                          ]),
                        ),
                        SizedBox(height: 1.h),
                        (widget.presDay == widget.ppCurrentDay &&
                                (widget.presDay.isNotEmpty) &&
                                widget.ppCurrentDay.isNotEmpty)
                            ? Text(
                                "Preparatory Plan Completed by user",
                                style: TextStyle(
                                    fontFamily: fontMedium,
                                    color: gSecondaryColor,
                                    fontSize: fontSize08),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 2.h),
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
                        GestureDetector(
                          onTap: () {
                            buildPreparatory(
                                "${preparatoryTransitionModel?.days}", context);
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
                        ),
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
            List<Preparatory> lst = (e.value);
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
                          SizedBox(width: 1.w),
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
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
