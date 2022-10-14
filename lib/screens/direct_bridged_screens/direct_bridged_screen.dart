import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/pop_up_menu_widget.dart';

class DirectBridgedScreen extends StatefulWidget {
  const DirectBridgedScreen({Key? key}) : super(key: key);

  @override
  State<DirectBridgedScreen> createState() => _DirectBridgedScreenState();
}

class _DirectBridgedScreenState extends State<DirectBridgedScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              SizedBox(
                height: 8.h,
                child: const Image(
                  image:
                  AssetImage("assets/images/Gut wellness logo green.png"),
                ),
              ),
              TabBar(
                  labelColor: gPrimaryColor,
                  unselectedLabelColor: gTextColor,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  isScrollable: true,
                  indicatorColor: gPrimaryColor,
                  labelPadding:
                      EdgeInsets.only(right: 10.w, top: 1.h, bottom: 1.h),
                  indicatorPadding: EdgeInsets.only(right: 7.w),
                  labelStyle: TextStyle(
                      fontFamily: "GothamMedium",
                      color: gPrimaryColor,
                      fontSize: 11.sp),
                  tabs: const [
                    Text('Direct'),
                    Text('Bridged'),
                  ]),
              Expanded(
                child: TabBarView(children: [
                  buildDirect(),
                  buildBridged(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildDirect() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 2.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 2.h,
                          backgroundImage:
                              const AssetImage("assets/images/Ellipse 232.png"),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lorem ipsum dadids",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 10.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "24 F",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 8.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "09th Sep 2022 / 08:30 PM",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    color: gTextColor,
                                    fontSize: 8.sp),
                              ),
                            ],
                          ),
                        ),
                        const PopUpMenuWidget(),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  buildBridged() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 2.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 2.h,
                          backgroundImage:
                              const AssetImage("assets/images/Ellipse 232.png"),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lorem ipsum dadids",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 10.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "24 F",
                                style: TextStyle(
                                    fontFamily: "GothamMedium",
                                    color: gTextColor,
                                    fontSize: 8.sp),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "09th Sep 2022 / 08:30 PM",
                                style: TextStyle(
                                    fontFamily: "GothamBook",
                                    color: gTextColor,
                                    fontSize: 8.sp),
                              ),
                            ],
                          ),
                        ),
                        const PopUpMenuWidget(),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
