import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';
import '../../controller/protocol_graph_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class PostProgramProgress extends StatefulWidget {
  const PostProgramProgress({Key? key}) : super(key: key);

  @override
  State<PostProgramProgress> createState() => _PostProgramProgressState();
}

class _PostProgramProgressState extends State<PostProgramProgress> {
  int _bottomNavIndex = 0;

  ProtocolGraphController protocolGuideController =
      Get.put(ProtocolGraphController());
  List graph = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,

    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildAppBar(() {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                    Navigator.pop(context);
                  }),
                  PopupMenuButton(
                    offset: const Offset(0, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    itemBuilder: (context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "11 - 20 days",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: gTextColor,
                                    fontSize: 8.sp),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              height: 1,
                              color: gGreyColor.withOpacity(0.3),
                            ),
                            GestureDetector(
                              child: Text(
                                "21 - 30 days",
                                style: TextStyle(
                                    fontFamily: "PoppinsRegular",
                                    color: gTextColor,
                                    fontSize: 8.sp),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: gWhiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(2, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            "01 - 10 days",
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                color: gTextColor,
                                fontSize: 8.sp),
                          ),
                          SizedBox(width: 5.w),
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
                child: buildGraph(),
              ),
              buildTile(),
            ],
          ),
        ),
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget buildTabView({
    required int index,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        onChangedTab(index);
        Get.back();
      },
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "PoppinsRegular",
          color: (_bottomNavIndex == index) ? gPrimaryColor : gTextColor,
          fontSize: 7.sp,
        ),
      ),
    );
  }

  buildTile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(5),
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
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Score : ',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontFamily: "GothamBook",
                    color: gBlackColor,
                  ),
                ),
                TextSpan(
                  text: "380",
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontFamily: "GothamMedium",
                    color: gBlackColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 13.w),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Percentage : ',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontFamily: "GothamBook",
                    color: gBlackColor,
                  ),
                ),
                TextSpan(
                  text: "64%",
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontFamily: "GothamMedium",
                    color: gBlackColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 13.w),
          Expanded(
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontFamily: "GothamBook",
                color: gBlackColor,
                fontSize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildGraph() {
    return FutureBuilder(
        future: protocolGuideController.fetchProtocolGraph("10"),
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
            graph = jsonEncode(data.data) as List;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: graph.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: VerticalBarIndicator(
                        width: 2.w,
                        height: double.maxFinite,
                        footerStyle: TextStyle(
                            fontSize: 8.sp,
                            fontFamily: "GothamMedium",
                            color: gPrimaryColor),
                        footer: "Day${dailyProgress[index]}",
                        animationDuration: const Duration(seconds: 2),
                        circularRadius: 0,
                        percent: buildBar(graph[index].breakfast),
                        color: buildTextColor(graph[index].breakfast),
                      ),
                    );
                  }),
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: buildCircularIndicator(),
          );
        });
  }

  buildTextColor(double value) {
    if (0.3 > value) {
      return [gSecondaryColor, gSecondaryColor];
    } else if (0.6 > value) {
      return [gMainColor, gMainColor];
    } else if (1.0 >= value) {
      return [gPrimaryColor, gPrimaryColor];
    }
  }

  buildCenterText(double data) {
    if (100 < data) {
      return Text(
        "100 %",
        style: TextStyle(
            fontSize: 8.sp, fontFamily: "GothamBook", color: gMainColor),
      );
    } else {
      return Text(
        "${data.toStringAsFixed(2)} %",
        style: TextStyle(
            fontSize: 8.sp, fontFamily: "GothamBook", color: gMainColor),
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
}
