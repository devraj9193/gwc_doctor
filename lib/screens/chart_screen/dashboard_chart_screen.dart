import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../utils/doctor_details_storage.dart';
import '../../widgets/common_screen_widgets.dart';
import '../active_screens/active_screen.dart';
import '../notification_screens/notification_screen.dart';
import '../calendar_screens/calender_screen.dart';
import '../consultation_screen/consultation_screen.dart';
import '../meal_plans_screens/meal_plans_screen.dart';
import '../post_programs_screens/post_programs_screen.dart';
import '../customer_status_screens/customer_status_screen.dart';
import '../follow_up_calls/follow_up_calls.dart';
import 'models.dart';
import 'package:get/get.dart';

class GanttChartScreen extends StatefulWidget {
  const GanttChartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GanttChartScreenState();
  }
}

class GanttChartScreenState extends State<GanttChartScreen>
    with TickerProviderStateMixin {
  final _pref = AppConfig().preferences!;
  late AnimationController animationController;

  DateTime fromDate = DateTime(2018, 1, 1);
  DateTime toDate = DateTime(2019, 1, 1);

  late List<User> usersInChart;
  late List<Project> projectsInChart;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(microseconds: 2000), vsync: this);
    animationController.forward();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    projectsInChart = projects;
    usersInChart = users;
    //  quickbloxLoginSession();
  }

  // quickbloxLoginSession() async {
  //   print(_pref?.getInt(AppConfig.GET_QB_SESSION) == null || _pref?.getBool(AppConfig.IS_QB_LOGIN) == null || _pref?.getBool(AppConfig.IS_QB_LOGIN) == false);
  //   final _qbService = Provider.of<QuickBloxService>(context, listen:  false);
  //   print(await _qbService.getSession());
  //   if(_pref?.getInt(AppConfig.GET_QB_SESSION) == null || await _qbService.getSession() == true || _pref?.getBool(AppConfig.IS_QB_LOGIN) == null || _pref?.getBool(AppConfig.IS_QB_LOGIN) == false){
  //     _qbService.login("${_pref?.getString(AppConfig.QB_USERNAME)!}");
  //   }
  // }

  List doctorDetails = [
    {
      "title": "Consultations",
      "image": "assets/images/Group 3009.png",
      "id": "1",
    },
    {
      "title": "Meal Plans",
      "image": "assets/images/Group 3007.png",
      "id": "2",
    },
    {
      "title": "Active",
      "image": "assets/images/Group 3011.png",
      "id": "3",
    },
    {
      "title": "Post Programs",
      "image": "assets/images/Group 3013.png",
      "id": "4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: chartBackGroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        title: Image(
          image: const AssetImage("assets/images/Gut wellness logo.png"),
          height: 5.h,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: InkWell(
              child: const Icon(
                Icons.notifications_none_sharp,
                color: gBlackColor,
              ),
              onTap: () {
                Get.to(() => const NotificationScreen());
              },
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     buildCalendar(context);
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 0.w, top: 2.h,right: 4.w,bottom: 2.h),
          //     child: const Image(
          //       image: AssetImage("assets/images/noun-calendar-5347015.png"),
          //       color: gBlackColor,
          //     ),
          //   ),
          // ),
        ],
      ),
      backgroundColor: chartBackGroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Text(
                "Hi,Welcome back Dr. ${_pref.getString(DoctorDetailsStorage.doctorDetailsName)}",
                style: DashBoardScreen().headingTextField(),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: gWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.h),
                child:
                 const CalenderScreen(),
                  // const GanttChart(),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const CustomerStatusScreen());
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 3.w),
                        margin: EdgeInsets.only(bottom: 1.h,left: 3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: gSecondaryColor,
                          //border: Border.all(color: gMainColor, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(2, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              height: 3.h,
                              image:
                              const AssetImage("assets/images/Group 3011.png"),
                              color: whiteTextColor,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "Customer Status",
                              style: DashBoardScreen().gridTextField(),
                            ),
                          ],
                        )),
                  ),
                ),
                IntrinsicWidth(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const FollowUpCallsScreen());
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 3.w),
                        margin: EdgeInsets.only(bottom: 1.h,left: 3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: gSecondaryColor,
                          //border: Border.all(color: gMainColor, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(2, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              height: 3.h,
                              image:
                              const AssetImage("assets/images/Group 3011.png"),
                              color: whiteTextColor,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "Follow Up Calls",
                              style: DashBoardScreen().gridTextField(),
                            ),
                          ],
                        )),
                  ),
                ),

              ],
            ),
            // buildDetails(),
            //     SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  void buildCalendar(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: gWhiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Calendar',
                      style: TextStyle(
                          fontFamily: "GothamBold",
                          color: gBlackColor,
                          fontSize: 12.sp),
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
                      border: Border.all(color: gBlackColor, width: 1),
                    ),
                    child: Icon(
                      Icons.clear,
                      color: gBlackColor,
                      size: 1.6.h,
                    ),
                  ),
                ),
                SizedBox(width: 2.w)
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 20.w),
              height: 1,
              color: gGreyColor.withOpacity(0.5),
            ),
            SizedBox(height: 1.h),
            const Expanded(child: CalenderScreen()),
          ],
        ),
      ),
    );
  }

  buildDetails() {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 6,
          mainAxisExtent: 6.h,
        ),
        itemCount: doctorDetails.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (doctorDetails[index]["id"] == "1") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => const ConsultationScreen(),
                  ),
                );
              } else if (doctorDetails[index]["id"] == "2") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => const MealPlansScreen(),
                  ),
                );
              } else if (doctorDetails[index]["id"] == "3") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => const ActiveScreen(),
                  ),
                );
              } else if (doctorDetails[index]["id"] == "4") {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ct) => const PostProgramsScreen(),
                  ),
                );
              }
            },
            child: buildCustomBadge(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: gSecondaryColor,
                    //border: Border.all(color: gMainColor, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(2, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 3.h,
                        image: AssetImage(doctorDetails[index]["image"]),
                        color: whiteTextColor,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        doctorDetails[index]["title"],
                        style: DashBoardScreen().gridTextField(),
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  buildCustomBadge({required Widget child}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        // Positioned(
        //   top: -8,
        //   right: -5,
        //   child: Container(
        //     padding: const EdgeInsets.all(5.0),
        //     decoration: const BoxDecoration(
        //         color: gSecondaryColor, shape: BoxShape.circle),
        //     child: Text(
        //       "2",
        //       style: TextStyle(
        //         fontFamily: "GothamBook",
        //         color: gWhiteColor,
        //         fontSize: 7.5.sp,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// class GanttChart extends StatelessWidget {
//   final AnimationController animationController;
//   final DateTime fromDate;
//   final DateTime toDate;
//   final List<Project> data;
//   final List<User> usersInChart;
//   final Widget rowSeparatorWidget;
//   final Function? onRefresh;
//
//   int viewRange = 0;
//   int viewRangeToFitScreen = 6;
//   // Animation<double> width ;
//
//   GanttChart({
//     super.key,
//     required this.animationController,
//     required this.fromDate,
//     required this.toDate,
//     required this.data,
//     required this.usersInChart,
//     this.onRefresh,
//     this.rowSeparatorWidget = const Divider(
//       color: Colors.transparent,
//       height: 0.0,
//       thickness: 0.0,
//     ),
//   }) {
//     viewRange = calculateNumberOfMonthsBetween(fromDate, toDate);
//   }
//
//   Color randomColorGenerator() {
//     var r = Random();
//     return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
//   }
//
//   int calculateNumberOfMonthsBetween(DateTime from, DateTime to) {
//     return to.month - from.month + 12 * (to.year - from.year) + 1;
//   }
//
//   int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
//     if (projectStartedAt.compareTo(fromDate) <= 0) {
//       return 0;
//     } else {
//       return calculateNumberOfMonthsBetween(fromDate, projectStartedAt) - 1;
//     }
//   }
//
//   int calculateRemainingWidth(
//       DateTime projectStartedAt, DateTime projectEndedAt) {
//     int projectLength =
//         calculateNumberOfMonthsBetween(projectStartedAt, projectEndedAt);
//     if (projectStartedAt.compareTo(fromDate) >= 0 &&
//         projectStartedAt.compareTo(toDate) <= 0) {
//       if (projectLength <= viewRange) {
//         return projectLength;
//       } else {
//         return viewRange -
//             calculateNumberOfMonthsBetween(fromDate, projectStartedAt);
//       }
//     } else if (projectStartedAt.isBefore(fromDate) &&
//         projectEndedAt.isBefore(fromDate)) {
//       return 0;
//     } else if (projectStartedAt.isBefore(fromDate) &&
//         projectEndedAt.isBefore(toDate)) {
//       return projectLength -
//           calculateNumberOfMonthsBetween(projectStartedAt, fromDate);
//     } else if (projectStartedAt.isBefore(fromDate) &&
//         projectEndedAt.isAfter(toDate)) {
//       return viewRange;
//     }
//     return 0;
//   }
//
//   List<Widget> buildChartBars(
//       List<Project> data, double chartViewWidth, Color color) {
//     List<Widget> chartBars = [];
//
//     for (int i = 0; i < data.length; i++) {
//       var remainingWidth =
//           calculateRemainingWidth(data[i].startTime, data[i].endTime);
//       if (remainingWidth > 0) {
//         chartBars.add(Container(
//           decoration: BoxDecoration(
//               color: color.withAlpha(30),
//               borderRadius: BorderRadius.circular(100.0)),
//           height: 5.h,
//           width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
//           margin: EdgeInsets.only(
//               left: 10.0,
//               // left: calculateDistanceToLeftBorder(data[i].startTime) *
//               //     chartViewWidth /
//               //     viewRangeToFitScreen,
//               top: i == 0 ? 4.0 : 2.0,
//               bottom: i == data.length - 1 ? 4.0 : 2.0),
//           alignment: Alignment.centerLeft,
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: color.withAlpha(100),
//                 ),
//                 child: Text(
//                   "GW",
//                   style: TextStyle(
//                       fontSize: 7.sp,
//                       fontFamily: "GothamBook",
//                       color: gBlackColor),
//                 ),
//               ),
//               SizedBox(width: 2.w),
//               Text(
//                 data[i].name,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                     fontSize: 8.sp,
//                     fontFamily: "GothamBook",
//                     color: gBlackColor),
//               ),
//             ],
//           ),
//         ));
//       }
//     }
//
//     return chartBars;
//   }
//
//   Widget buildHeader(double chartViewWidth, Color color) {
//     List<Widget> headerItems = [];
//
//     DateTime tempDate = fromDate;
//
//     headerItems.add(
//       SizedBox(
//         width: chartViewWidth / viewRangeToFitScreen,
//         child: Text(
//           'USER NAME',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 8.sp,
//             fontFamily: "GothamMedium",
//             color: gBlackColor,
//           ),
//         ),
//       ),
//     );
//
//     for (int i = 0; i < viewRange; i++) {
//       headerItems.add(SizedBox(
//         width: chartViewWidth / viewRangeToFitScreen,
//         child: Text(
//           '${tempDate.month}/${tempDate.year}',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 8.sp,
//             fontFamily: "GothamMedium",
//             color: gBlackColor,
//           ),
//         ),
//       ));
//       // tempDate = Utils.nextMonth(tempDate);
//     }
//
//     return Container(
//       height: 25.0,
//       color: color.withAlpha(100),
//       margin: EdgeInsets.symmetric(vertical: 1.h),
//       child: Row(
//         children: headerItems,
//       ),
//     );
//   }
//
//   Widget buildGrid(double chartViewWidth) {
//     List<Widget> gridColumns = [];
//
//     for (int i = 0; i <= viewRange; i++) {
//       gridColumns.add(Container(
//         decoration: const BoxDecoration(
//             border: Border(
//                 right: BorderSide(color: Color(0xffECF0F4), width: 2.0))),
//         width: chartViewWidth / viewRangeToFitScreen,
//         //height: 300.0,
//       ));
//     }
//
//     return Row(
//       children: gridColumns,
//     );
//   }
//
//   Widget buildGrid1() {
//     List<Widget> gridRows = [];
//
//     for (int i = 0; i <= viewRange; i++) {
//       gridRows.add(Container(
//         decoration: const BoxDecoration(
//           border: Border(
//             bottom: BorderSide(color: Color(0xffECF0F4), width: 2.0),
//           ),
//         ),
//         height: 2,
//         //height: 300.0,
//       ));
//     }
//
//     return Column(
//       children: gridRows,
//     );
//   }
//
//   Widget buildChartForEachUser(
//       List<Project> userData, double chartViewWidth, User user) {
//     Color color = randomColorGenerator();
//     var chartBars = buildChartBars(userData, chartViewWidth, color);
//     return SizedBox(
//       height: chartBars.length * 50.0 + 35.0 + 5.0,
//       child: Stack(
//         fit: StackFit.loose,
//         children: <Widget>[
//           buildGrid(chartViewWidth),
//           buildHeader(chartViewWidth, gWhiteColor),
//           Container(
//             margin: const EdgeInsets.only(top: 25.0),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Container(
//                         width: chartViewWidth / viewRangeToFitScreen,
//                         height: chartBars.length * 29.0 + 4.0,
//                         //   color: color.withAlpha(100),
//                         margin: EdgeInsets.only(top: 2.h),
//                         child: Center(
//                           child: RotatedBox(
//                             quarterTurns:
//                                 chartBars.length * 29.0 + 4.0 > 50 ? 0 : 0,
//                             child: Text(
//                               user.name,
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         )),
//                     Container(
//                       margin: EdgeInsets.only(top: 2.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: chartBars,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> buildChartContent(double chartViewWidth) {
//     List<Widget> chartContent = [];
//
//     for (var user in usersInChart) {
//       List<Project> projectsOfUser = [];
//
//       projectsOfUser = projects
//           .where((project) => project.participants.contains(user.id))
//           .toList();
//
//       if (projectsOfUser.isNotEmpty) {
//         chartContent
//             .add(buildChartForEachUser(projectsOfUser, chartViewWidth, user));
//       }
//     }
//
//     return chartContent;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var chartViewWidth = MediaQuery.of(context).size.width;
//     var screenOrientation = MediaQuery.of(context).orientation;
//
//     screenOrientation == Orientation.landscape
//         ? viewRangeToFitScreen = 12
//         : viewRangeToFitScreen = 6;
//
//     return MediaQuery.removePadding(
//       removeTop: true,
//       context: context,
//       child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: buildChartContent(chartViewWidth)),
//     );
//   }
// }

var users = [
  User(id: 1, name: 'Smith'),
  User(id: 2, name: 'Leila'),
  User(id: 3, name: 'Alex'),
  User(id: 4, name: 'Ryan'),
  User(id: 5, name: 'Steve'),
  User(id: 6, name: 'Leila'),
  User(id: 7, name: 'Alex'),
  User(id: 8, name: 'Ryan'),
];

var projects = [
  Project(
      id: 1,
      name: 'Consultation',
      startTime: DateTime(2017, 3, 1),
      endTime: DateTime(2018, 6, 1),
      participants: [1, 2, 3]),
  // Project(
  //     id: 2,
  //     name: 'CENTTO',
  //     startTime: DateTime(2018, 4, 1),
  //     endTime: DateTime(2018, 6, 1),
  //     participants: [2, 3]),
  // Project(
  //     id: 3,
  //     name: 'Uber',
  //     startTime: DateTime(2017, 5, 1),
  //     endTime: DateTime(2018, 9, 1),
  //     participants: [1, 2, 4]),
  // Project(
  //     id: 4,
  //     name: 'Grab',
  //     startTime: DateTime(2018, 6, 1),
  //     endTime: DateTime(2018, 10, 1),
  //     participants: [1, 4, 3]),
  // Project(
  //     id: 5,
  //     name: 'GO-JEK',
  //     startTime: DateTime(2017, 3, 1),
  //     endTime: DateTime(2018, 11, 1),
  //     participants: [4, 2, 3]),
  // Project(
  //     id: 6,
  //     name: 'Lyft',
  //     startTime: DateTime(2018, 4, 1),
  //     endTime: DateTime(2018, 7, 1),
  //     participants: [4, 2, 3]),
  // Project(
  //     id: 7,
  //     name: 'San Jose',
  //     startTime: DateTime(2018, 5, 1),
  //     endTime: DateTime(2018, 12, 1),
  //     participants: [1, 2, 4]),
];
