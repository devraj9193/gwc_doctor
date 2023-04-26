import 'package:doctor_app_new/screens/active_screens/active_screen.dart';
import 'package:doctor_app_new/screens/consultation_screen/consultation_screen.dart';
import 'package:doctor_app_new/screens/post_programs_screens/post_programs_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../controller/calendar_details_controller.dart';
import '../../controller/user_profile_controller.dart';
import '../../model/calendar_model.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../meal_plans_screens/meal_plans_screen.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  //String? doctorName = "";

  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';

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

  CalendarDetailsController calendarDetailsController =
      Get.put(CalendarDetailsController());

  UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
   // doctorData();
  }

  // doctorData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   doctorName = preferences.getString("doctor_name");
  //   print(doctorName);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return
        //  buildCalender();
        SafeArea(
      child: Scaffold(
        backgroundColor: chartBackGroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: 3.w,top: 1.h,bottom: 1.h),
            //   child: SizedBox(
            //     height: 5.h,
            //     child: const Image(
            //       image:
            //           AssetImage("assets/images/Gut wellness logo.png"),
            //     ),
            //   ),
            // ),
            buildDoctor(),

            Expanded(child: buildCalender()),
            // buildDetails(),
          ],
        ),
      ),
    );
  }

  buildDoctor() {
    return FutureBuilder(
        future: userProfileController.fetchUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(""),
              //Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Text(
                "Hi,Welcome back Dr. ${ data.data.name ?? ""}",
                style: DashBoardScreen().headingTextField(),
              ),
            );
          }
          return Container();
        });
  }

  buildCalender() {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: gWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FutureBuilder(
          future: calendarDetailsController.fetchCalendarList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(""),
                //Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return SfCalendar(
                view: CalendarView.week,
                showDatePickerButton: true,
                cellBorderColor: chartBackGroundColor,
                headerHeight: 30, firstDayOfWeek: 7,
                //   headerDateFormat: "yMMMMEEEEd",
                onTap: calendarTapped,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  startHour: 8,
                  endHour: 22,
                  nonWorkingDays: <int>[DateTime.friday, DateTime.monday],
                ),
                showWeekNumber: true,
                showNavigationArrow: true,
                showCurrentTimeIndicator: true,
                allowViewNavigation: true,
                allowDragAndDrop: false,
                appointmentTextStyle: TextStyle(
                  fontFamily: fontMedium,
                  height: 1.2,
                  color: gWhiteColor,
                  fontSize: fontSize07,
                ),
                dataSource: MeetingDataSource(_getDataSource(data)),
                headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontFamily: fontMedium,
                    color: newBlackColor,
                    fontSize: fontSize10,
                  ),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    fontFamily: fontBold,
                    color: newBlackColor,
                    fontSize: fontSize09,
                  ),
                  dateTextStyle: TextStyle(
                    fontFamily: fontBook,
                    color: newBlackColor,
                    fontSize: fontSize09,
                  ),
                ),
                todayHighlightColor: gSecondaryColor,
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: buildCircularIndicator(),
            );
          }),
    );
  }

  List<Meeting> _getDataSource(List<Meeting> data) {
    // final List<Meeting> meetings = <Meeting>[];
    // final DateTime today = DateTime.now();
    // final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));
    // // meetings.add(Meeting(title: data., date: null, start: null, end: null, color: null, allDay: null));
    return data;
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.title;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.start)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.start).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.end).toString();
      if (appointmentDetails.allDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '$_subjectText',
                style: TextStyle(
                  fontFamily: fontBold,
                  color: newBlackColor,
                  fontSize: fontSize13,
                ),
              ),
              content: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: gWhiteColor),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$_dateText',
                      style: TextStyle(
                        fontFamily: fontMedium,
                        color: newBlackColor,
                        fontSize: fontSize12,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _timeDetails!,
                      style: TextStyle(
                        fontFamily: fontBook,
                        color: newBlackColor,
                        fontSize: fontSize11,
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: gSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'close',
                      style: LoginScreen().buttonText(whiteTextColor),
                    ),
                  ),
                ),
              ],
            );
          });
    }
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

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).start;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).end;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).title;
  }

  @override
  Color getColor(int index) {
    return gSecondaryColor;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).allDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

// /// Custom business object class which contains properties to hold the detailed
// /// information about the event data which will be rendered in calendar.
// class Meeting {
//   /// Creates a meeting class with required details.
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   /// Event name which is equivalent to subject property of [Appointment].
//   String eventName;
//
//   /// From which is equivalent to start time property of [Appointment].
//   DateTime from;
//
//   /// To which is equivalent to end time property of [Appointment].
//   DateTime to;
//
//   /// Background which is equivalent to color property of [Appointment].
//   Color background;
//
//   /// IsAllDay which is equivalent to isAllDay property of [Appointment].
//   bool isAllDay;
// }
