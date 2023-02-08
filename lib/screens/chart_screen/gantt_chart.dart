import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';

class GanttChart extends StatefulWidget {
  const GanttChart({
    Key? key,
  }) : super(key: key);
  @override
  State<GanttChart> createState() => _GanttChartState();
}

class _GanttChartState extends State<GanttChart> {
  List<int> list = [];

  late ScrollController _horizontalController1;
  late ScrollController _horizontalController2;
  late ScrollController _verticalController1;
  late ScrollController _verticalController2;
  double height = 50;
  double width = 100;
  Grid grid = Grid.none;

  List chartHeadings = [
    {
      "title": "Consultation Pending",
      "id": 1,
    },
    {
      "title": "Reports Awaited",
      "id": 2,
    },
    {
      "title": "MR & CS Pending",
      "id": 3,
    },
    {
      "title": "Meal Plan Pending",
      "id": 4,
    },
    {
      "title": "Meal Kit Shipped",
      "id": 5,
    },
    {
      "title": "Active User",
      "id": 6,
    },
    {
      "title": "Post Program Consultation",
      "id": 7,
    },
    {
      "title": "Transition Phase",
      "id": 8,
    },
    {
      "title": "GMC Phase",
      "id": 9,
    },
  ];

  List customerDetails = [
    Task(
        startTask: "Consultation Pending",
        endTask: "Active User",
        taskTitle: 'Active User',
        title: 'Amith K'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Transition Phase",
        taskTitle: 'Transition Phase',
        title: 'Ganesh H'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Active User",
        taskTitle: 'Active User',
        title: 'Bhogesh P'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Active User",
        taskTitle: 'Active User',
        title: 'Vilayat K'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Transition Phase",
        taskTitle: 'Transition Phase',
        title: 'Nagaraj D'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Seetha M'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Harsh H'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Xyz Xyz'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Nicchu R'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Seetha Mani'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Swr Lth'),
    Task(
        startTask: "Consultation Pending",
        endTask: "Meal Kit Shipped",
        taskTitle: 'Meal Kit Shipped',
        title: 'Preethi NS'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask: "Meal Kit Shipped",
    //     taskTitle:
    //         'Получение отзыва научного руководителя и заключения предприятия, где выполнялась работа',
    //     title: 'task13'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask:"Meal Kit Shipped",
    //     taskTitle:
    //         'Допуск работы к защите в ГЭК заведующего выпускающей кафедрой',
    //     title: 'task14'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask: "Meal Kit Shipped",
    //     taskTitle:
    //         'Получение внешней рецензии и передача работы на выпускающую кафедру (по необходимости)',
    //     title: 'task16'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask: "Meal Kit Shipped",
    //     taskTitle: 'Защита дипломной работы в ГЭК',
    //     title: 'task17'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask: "Meal Kit Shipped",
    //     taskTitle: 'Защита дипломной работы в ГЭК',
    //     title: 'task18'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask:"Meal Kit Shipped",
    //     taskTitle: 'Защита дипломной работы в ГЭК',
    //     title: 'task19'),
    // Task(
    //     startTask:"Consultation Pending",
    //     endTask: "Meal Kit Shipped",
    //     taskTitle: 'Защита дипломной работы в ГЭК',
    //     title: 'task20'),
    // Task(
    //     startTask: "Consultation Pending",
    //     endTask:"Meal Kit Shipped",
    //     taskTitle: 'Защита дипломной работы в ГЭК',
    //     title: 'task21'),
  ];

  Color randomColorGenerator() {
    var r = Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  @override
  void initState() {
    _horizontalController1 = ScrollController();
    _horizontalController2 = ScrollController();
    _verticalController1 = ScrollController();
    _verticalController2 = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = randomColorGenerator();

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Column(children: <Widget>[
            SizedBox(
              height: height,
              child: Row(
                children: <Widget>[
                  Container(
                    height: height,
                    width: width,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 2,
                          color: Color(0xffECF0F4),
                        ),
                        bottom: BorderSide(
                          width: 2,
                          color: Color(0xffECF0F4),
                        ),
                      ),
                    ),
                    child: Text(
                      "User\nName",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gBlackColor,
                        fontFamily: "GothamMedium",
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _horizontalController2,
                    child: Row(
                      children: <Widget>[
                        ...chartHeadings
                            .map(
                              (e) => Container(
                                height: height,
                                width: width,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 2,
                                      color: Color(0xffECF0F4),
                                    ),
                                    bottom: BorderSide(
                                      width: 2,
                                      color: Color(0xffECF0F4),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    e["title"].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: gBlackColor,
                                      fontFamily: "GothamMedium",
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: width,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _verticalController2,
                      child: Column(children: <Widget>[
                        ...customerDetails
                            .asMap()
                            .map(
                              (index, value) => MapEntry(
                                index,
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: height,
                                      width: width,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            width: 2,
                                            color: Color(0xffECF0F4),
                                          ),
                                          bottom: BorderSide(
                                            width: 2,
                                            color: Color(0xffECF0F4),
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            value.title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 9.sp,
                                              color: gBlackColor,
                                              fontFamily: "GothamMedium",
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          _horizontalController2
                              .jumpTo(_horizontalController1.offset);
                          _verticalController2
                              .jumpTo(_verticalController1.offset);
                        }
                        return false;
                      },
                      child: SingleChildScrollView(
                        controller: _horizontalController1,
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          controller: _verticalController1,
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ...customerDetails
                                  .asMap()
                                  .map((index, value) => MapEntry(
                                      index,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ...List.generate(
                                            0,
                                            // value.startTask
                                            //         .difference(widget
                                            //             .startDate)
                                            //         .inDays +
                                            //     1,
                                            (index) => Container(
                                              height: height,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffECF0F4),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 3.5.h,
                                            width:
                                                calculateWidth(value.endTask),
                                            padding: const EdgeInsets.only(
                                                top: 3,
                                                left: 3,
                                                bottom: 3,
                                                right: 10),
                                            margin: EdgeInsets.only(
                                                left: 2.w,right: 2.w, top: 1.h),
                                            decoration: BoxDecoration(
                                              color: color.withAlpha(30),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: color.withAlpha(200),
                                                  ),
                                                  child: Text(
                                                    getInitials(value.title, 2),
                                                    style: TextStyle(
                                                        fontSize: 7.sp,
                                                        fontFamily:
                                                            "GothamBook",
                                                        color: gWhiteColor),
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                Text(
                                                  value.taskTitle,
                                                  style: TextStyle(
                                                      fontSize: 7.sp,
                                                      fontFamily: "GothamBook",
                                                      color: gBlackColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...List.generate(
                                            9,
                                            (index) => Container(
                                              height: height,
                                              width: width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffECF0F4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                                  .values
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }

  static String getInitials(String string, int limitTo) {
    var buffer = StringBuffer();
    var wordList = string.trim().split(' ');

    if (string.isEmpty) {
      return string;
    }

    if (wordList.length <= 1) {
      return string.characters.first;
    }

    if (limitTo > wordList.length) {
      for (var i = 0; i < wordList.length; i++) {
        buffer.write(wordList[i][0]);
      }
      return buffer.toString();
    }

    // Handle all other cases
    for (var i = 0; i < (limitTo); i++) {
      buffer.write(wordList[i][0]);
    }
    return buffer.toString();
  }

  double calculateWidth(endTask) {
    double size = 0;
    for (var element in chartHeadings) {
      if (element['title'] == endTask) {
        size = width * element['id'];
      }
    }
    return size;
  }
}

class Task {
  final String startTask;
  final String endTask;
  final String title;
  final String taskTitle;

  Task(
      {required this.startTask,
      required this.endTask,
      required this.title,
      required this.taskTitle});
}

enum Grid { horizontal, vertical, both, none }
