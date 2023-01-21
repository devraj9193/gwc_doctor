// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   static const maxCount = 100;
//   static const double maxHeight = 1000;
//   final random = math.Random();
//   final scrollDirection = Axis.vertical;
//
//   late AutoScrollController controller;
//   late List<List<int>> randomList;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = AutoScrollController(
//         viewportBoundaryGetter: () =>
//             Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//         axis: scrollDirection);
//     randomList = List.generate(maxCount,
//             (index) => <int>[index, (maxHeight * random.nextDouble()).toInt()]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() => counter = 0);
//               _scrollToCounter();
//             },
//             icon: Text('First'),
//           ),
//           IconButton(
//             onPressed: () {
//               setState(() => counter = maxCount - 1);
//               _scrollToCounter();
//             },
//             icon: Text('Last'),
//           )
//         ],
//       ),
//       body: ListView(
//         scrollDirection: scrollDirection,
//         controller: controller,
//         children: randomList.map<Widget>((data) {
//           return Padding(
//             padding: EdgeInsets.all(8),
//             child: _getRow(data[0], math.max(data[1].toDouble(), 50.0)),
//           );
//         }).toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _nextCounter,
//         tooltip: 'Increment',
//         child: Text(counter.toString()),
//       ),
//     );
//   }
//
//   int counter = -1;
//   Future _nextCounter() {
//     setState(() => counter = (counter + 1) % maxCount);
//     return _scrollToCounter();
//   }
//
//   Future _scrollToCounter() async {
//     await controller.scrollToIndex(counter,
//         preferPosition: AutoScrollPosition.begin);
//     controller.highlight(counter);
//   }
//
//   Widget _getRow(int index, double height) {
//     return _wrapScrollTag(
//         index: index,
//         child: Container(
//           padding: EdgeInsets.all(8),
//           alignment: Alignment.topCenter,
//           height: height,
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.lightBlue, width: 4),
//               borderRadius: BorderRadius.circular(12)),
//           child: Text('index: $index, height: $height'),
//         ));
//   }
//
//   Widget _wrapScrollTag({required int index, required Widget child}) =>
//       AutoScrollTag(
//         key: ValueKey(index),
//         controller: controller,
//         index: index,
//         child: child,
//         highlightColor: Colors.black.withOpacity(0.1),
//       );
// }
//
// // import 'package:circular_progress_bar_with_lines/circular_progress_bar_with_lines.dart';
// // import 'package:flutter/material.dart';
// // import 'package:sizer/sizer.dart';
// //
// // import '../../utils/constants.dart';
// //
// // class CommonWidgets extends StatefulWidget {
// //   final String points;
// //   final String value1;
// //   final String value2;
// //   final String value3;
// //   final String value4;
// //   final String comments;
// //   const CommonWidgets(
// //       {Key? key,
// //       required this.points,
// //       required this.value1,
// //       required this.value2,
// //       required this.value3,
// //       required this.value4,
// //       required this.comments})
// //       : super(key: key);
// //
// //   @override
// //   State<CommonWidgets> createState() => _CommonWidgetsState();
// // }
// //
// // class _CommonWidgetsState extends State<CommonWidgets> {
// //   final double _percent = 100;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "Reward Points",
// //           style: TextStyle(
// //               fontFamily: "GothamBold", color: gMainColor, fontSize: 10.sp),
// //         ),
// //         Padding(
// //           padding:
// //               EdgeInsets.only(right: 5.w, left: 2.w, top: 2.h, bottom: 2.h),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               CircularProgressBarWithLines(
// //                 radius: 60,
// //                 linesLength: 6,
// //                 linesWidth: 2,
// //                 linesColor: gPrimaryColor,
// //                 percent: _percent,
// //                 centerWidgetBuilder: (context) => Text(
// //                   widget.points,
// //                   style: TextStyle(
// //                     fontFamily: "GothamBook",
// //                     color: gMainColor,
// //                     fontSize: 11.sp,
// //                   ),
// //                 ),
// //               ),
// //               Column(
// //                 children: [
// //                   RichText(
// //                     text: TextSpan(
// //                       children: <TextSpan>[
// //                         TextSpan(
// //                           text: "${widget.value1} ",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: Colors.lightBlue,
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: "Lorem Ipsum",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: gTextColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 2.h),
// //                   RichText(
// //                     text: TextSpan(
// //                       children: <TextSpan>[
// //                         TextSpan(
// //                           text: "${widget.value2} ",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: Colors.lightBlue,
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: "Lorem Ipsum",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: gTextColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 2.h),
// //                   RichText(
// //                     text: TextSpan(
// //                       children: <TextSpan>[
// //                         TextSpan(
// //                           text: "${widget.value3} ",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: Colors.lightBlue,
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: "Lorem Ipsum",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: gTextColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 2.h),
// //                   RichText(
// //                     text: TextSpan(
// //                       children: <TextSpan>[
// //                         TextSpan(
// //                           text: "${widget.value4} ",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: Colors.lightBlue,
// //                           ),
// //                         ),
// //                         TextSpan(
// //                           text: "Lorem Ipsum",
// //                           style: TextStyle(
// //                             fontSize: 11.sp,
// //                             fontFamily: "GothamBook",
// //                             color: gTextColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //         Text(
// //           widget.comments,
// //           style: TextStyle(
// //             fontSize: 9.sp,
// //             height: 1.5,
// //             fontFamily: "GothamBook",
// //             color: gTextColor,
// //           ),
// //         ),
// //         SizedBox(height: 2.h),
// //       ],
// //     );
// //   }
// // }
