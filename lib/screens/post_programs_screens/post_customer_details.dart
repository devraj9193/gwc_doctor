import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../controller/guide_meal_plan_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import 'package:get/get.dart';

import 'medical_feedback_answer.dart';

class PostCustomerDetails extends StatefulWidget {
  const PostCustomerDetails({Key? key}) : super(key: key);

  @override
  State<PostCustomerDetails> createState() => _PostCustomerDetailsState();
}

class _PostCustomerDetailsState extends State<PostCustomerDetails> {
  List types = ['Do', "Don't Do", 'none'];

  GuideMealPlanController guideMealPlanController =
      Get.put(GuideMealPlanController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gWhiteColor,
          appBar: buildAppBar(() {
            Navigator.pop(context);
          }),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  labelColor: tapSelectedColor,
                  unselectedLabelColor: tapUnSelectedColor,
                  labelStyle: TabBarText().selectedText(),
                  unselectedLabelStyle: TabBarText().unSelectedText(),
                  isScrollable: true,
                  indicatorColor: tapIndicatorColor,
                  labelPadding: EdgeInsets.only(
                      right: 15.w, left: 2.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 10.w),
                  tabs: const [
                    Text('Medical Feedback'),
                    // Text('Lunch'),
                    // Text('Dinner'),
                  ]),
              const Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      MedicalFeedbackAnswer(),
                      // buildBreakFast(),
                      // buildLunch(),
                      // buildDinner(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTile(String lottie, String title, {String? mainText}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          Row(
            children: [
              SizedBox(
                height: 3.h,
                child: Lottie.asset(lottie),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: "GothamBook",
                    color: gBlackColor,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            width: double.maxFinite,
            height: 1,
            color: gGreyColor.withOpacity(0.3),
          ),
          SizedBox(height: 0.5.h),
          Text(
            mainText ??
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
            style: TextStyle(
              height: 1.5,
              fontSize: 8.sp,
              color: gBlackColor,
              fontFamily: "GothamBook",
            ),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }

  buildBreakFast() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: guideMealPlanController.fetchBreakFastPlan(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 35.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              print("Do: $data");
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(height: 2.h),
                  buildTile('assets/lottie/loading_tick.json', types[0],
                      mainText: data.data.dataDo.the0.name ?? ''),
                  buildTile('assets/lottie/loading_wrong.json', types[1],
                      mainText: data.data.doNot.the0.name ?? ""),
                  buildTile('assets/lottie/loading_wrong.json', types[2],
                      mainText: ''),
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

  buildLunch() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: guideMealPlanController.fetchLunchPlan(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 35.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              print("Do: $data");
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(height: 2.h),
                  buildTile('assets/lottie/loading_tick.json', types[0],
                      mainText: data.data.dataDo.the0.name ?? ''),
                  buildTile('assets/lottie/loading_wrong.json', types[1],
                      mainText: data.data.doNot.the0.name ?? ""),
                  buildTile('assets/lottie/loading_wrong.json', types[2],
                      mainText: ''),
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

  buildDinner() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder(
          future: guideMealPlanController.fetchDinnerPlan(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Image(
                  image: const AssetImage("assets/images/Group 5294.png"),
                  height: 35.h,
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  SizedBox(height: 2.h),
                  buildTile('assets/lottie/loading_tick.json', types[0],
                      mainText: data.data.dataDo.the0.name ?? ''),
                  buildTile('assets/lottie/loading_wrong.json', types[1],
                      mainText: data.data.doNot.the0.name ?? ""),
                  buildTile('assets/lottie/loading_wrong.json', types[2],
                      mainText: ''),
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
}
