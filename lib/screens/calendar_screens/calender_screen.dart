import 'package:doctor_app_new/screens/active_screens/active_screen.dart';
import 'package:doctor_app_new/screens/consultation_screen/consultation_screen.dart';
import 'package:doctor_app_new/screens/post_programs_screens/post_programs_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import '../../model/calendar_model.dart';
import '../../model/error_model.dart';
import '../../repository/api_service.dart';
import '../../repository/calendar_repo/calendar_repository.dart';
import '../../services/calendar_services/calendar_service.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../meal_plans_screens/meal_plans_screen.dart';
import 'calendar_customer_details.dart';

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
      _timeDetails = '',
      _meetingType = '';

  List newList = [];

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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  bool showProgress = false;
  CalendarModel? calendarModel;

  late final CalendarListService calendarListService =
      CalendarListService(repository: repository);

  @override
  void initState() {
    super.initState();
    getCalendarList();
  }

  getCalendarList() async {
    setState(() {
      showProgress = true;
    });

    callProgressStateOnBuild(true);
    final result = await calendarListService.getCalendarListService();
    print("result: $result");

    if (result.runtimeType == CalendarModel) {
      print("Follow UP Calls List");
      CalendarModel model = result as CalendarModel;

      calendarModel = model;

      List<Meeting> consultation = calendarModel?.data ?? [];
      List<FollowUpSchedule> followUpCalls =
          calendarModel?.followUpSchedule ?? [];

      setState(() {
        newList = List.from(consultation)..addAll(followUpCalls);
      });

      print("newList : $newList");
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    setState(() {
      showProgress = false;
    });
    print(result);
  }

  callProgressStateOnBuild(bool value) {
    Future.delayed(Duration.zero).whenComplete(() {
      setState(() {
        showProgress = value;
      });
    });
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await calendarListService.getCalendarListService();
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
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
        // buildCalender();
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
            Expanded(child: buildCalender()),
            // buildDetails(),
          ],
        ),
      ),
    );
  }

  buildCalender() {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 2.w, top: 2.h, right: 1.w, bottom: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: gWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: (showProgress)
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: buildCircularIndicator(),
            )
          : SfCalendar(
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
              dataSource: MeetingDataSource(_getDataSource(newList)),
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
            ),
    );
  }

  List _getDataSource(List data) {
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
      var appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.type == "1"
          ? appointmentDetails.title
          : appointmentDetails.type == "2"
              ? appointmentDetails.title
              : appointmentDetails.teamPatients.patient.user.name.toString();
      _meetingType = appointmentDetails.type == "1"
          ? "Pre Consultation"
          : appointmentDetails.type == "2"
              ? "Post Consultation"
              : "Follow_up Call";
      _dateText = appointmentDetails.type == "1"
          ? DateFormat('MMMM dd, yyyy')
              .format(appointmentDetails.start)
              .toString()
          : appointmentDetails.type == "2"
              ? DateFormat('MMMM dd, yyyy')
                  .format(appointmentDetails.start)
                  .toString()
              : DateFormat('MMMM dd, yyyy')
                  .format(DateTime.parse(appointmentDetails.date))
                  .toString();
      _startTimeText = appointmentDetails.type == "1"
          ? DateFormat('hh:mm a').format(appointmentDetails.start).toString()
          : appointmentDetails.type == "2"
              ? DateFormat('hh:mm a')
                  .format(appointmentDetails.start)
                  .toString()
              : DateFormat('hh:mm a')
                  .format(DateTime.parse(
                      "${appointmentDetails.date} ${appointmentDetails.slotStartTime}"))
                  .toString();
      _endTimeText = appointmentDetails.type == "1"
          ? DateFormat('hh:mm a').format(appointmentDetails.end).toString()
          : appointmentDetails.type == "2"
              ? DateFormat('hh:mm a').format(appointmentDetails.end).toString()
              : DateFormat('hh:mm a')
                  .format(DateTime.parse(
                      "${appointmentDetails.date} ${appointmentDetails.slotEndTime}"))
                  .toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
      // if (appointmentDetails.allDay) {
      //   _timeDetails = 'All day';
      // } else {
      //   _timeDetails = '$_startTimeText - $_endTimeText';
      // }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '$_meetingType',
                style: TextStyle(
                  fontFamily: fontBold,
                  color: newBlackColor,
                  fontSize: fontSize12,
                ),
              ),
              content: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: gWhiteColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$_subjectText',
                      style: TextStyle(
                        fontFamily: fontMedium,
                        color: newBlackColor,
                        fontSize: fontSize11,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      '$_dateText',
                      style: TextStyle(
                        fontFamily: fontMedium,
                        color: newBlackColor,
                        fontSize: fontSize10,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _timeDetails!,
                      style: TextStyle(
                        fontFamily: fontBook,
                        color: newBlackColor,
                        fontSize: fontSize09,
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            //     NutriDelightScreen(
                            //   userId: appointmentDetails.userId,
                            //   tabIndex: 0,
                            //   userName: appointmentDetails.title,
                            //   age: '',
                            //   appointmentDetails:
                            //       "$_dateText / $_startTimeText",
                            //   status: '',
                            //   finalDiagnosis: '',
                            //   preparatoryCurrentDay: '',
                            //   transitionCurrentDay: '',
                            //   isPrepCompleted: '',
                            //   isProgramStatus: '',
                            //   programDaysStatus: '',
                            // ),
                            CalendarCustomerDetails(
                          userId: appointmentDetails.type == "1"
                              ? appointmentDetails.userId
                              : appointmentDetails.type == "2"
                                  ? appointmentDetails.userId
                                  : appointmentDetails.teamPatients.patient.user.id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: gSecondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'View',
                      style: LoginScreen().buttonText(whiteTextColor),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
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

  saveUserId(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_id", userId);
    print("userId : ${preferences.getString("user_id")}");
  }

  final CalendarListRepo repository = CalendarListRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List source) {
    print("meeting source : $source");

    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).type == "1"
        ? _getMeetingData(index).start
        : _getMeetingData(index).type == "2"
            ? _getMeetingData(index).start
            : DateTime.parse(
                "${_getMeetingData(index).date} ${_getMeetingData(index).slotStartTime}");
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).type == "1"
        ? _getMeetingData(index).end
        : _getMeetingData(index).type == "2"
            ? _getMeetingData(index).end
            : DateTime.parse(
                "${_getMeetingData(index).date} ${_getMeetingData(index).slotEndTime}");
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).type == "1"
        ? _getMeetingData(index).title
        : _getMeetingData(index).type == "2"
            ? _getMeetingData(index).title
            : _getMeetingData(index).teamPatients.patient.user.name.toString();
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).type == "1"
        ? gSecondaryColor.withOpacity(0.7)
        : _getMeetingData(index).type == "2"
            ? Colors.blueAccent
            : gMainColor;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).type == "1"
        ? _getMeetingData(index).allDay
        : _getMeetingData(index).type == "2"
            ? _getMeetingData(index).allDay
            : false;
  }

  @override
  set appointments(List? appointments) {
    super.appointments = appointments;
  }

  _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meeting;
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
