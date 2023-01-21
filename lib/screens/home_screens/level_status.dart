// import 'package:flutter/material.dart';
// import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
// import 'package:sizer/sizer.dart';
// import '../../utils/constants.dart';
// import '../../widgets/widgets.dart';
// import 'common_widget.dart';
// import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';
//
// class LevelStatus extends StatefulWidget {
//   const LevelStatus({Key? key}) : super(key: key);
//
//   @override
//   State<LevelStatus> createState() => _LevelStatusState();
// }
//
// class _LevelStatusState extends State<LevelStatus> {
//   List data = [
//     22.22,
//     32.33,
//     10.00,
//     100.00,
//     77.77,
//     55.05,
//     77.08,
//     66.09,
//     99.99,
//     10.00,
//     80.00,
//     90.09,
//     40.04,
//     33.33,
//     67.76,
//   ];
//
//   List status = [1, 2, 3, 4, 5, 6, 7];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: gPrimaryColor,
//       child: SafeArea(
//         child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: Column(
//               children: [
//                 buildPercentage(),
//                 Expanded(
//                   child: Container(
//                     width: double.maxFinite,
//                     padding: EdgeInsets.only(
//                         right: 3.w, left: 3.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                             blurRadius: 2, color: Colors.grey.withOpacity(0.5))
//                       ],
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(height:3.h),
//                           //buildStatus(),
//                         //  buildEvaluationDone(),
//                           //  buildConsultationBooked(),
//                           //buildConsultationDone(),
//                           //  buildTracker(),
//                           // buildMealPlan(),
//                           // buildPPBooked(),
//                           buildPPConsultation(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
//
//   buildPercentage() {
//     return Padding(
//       padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.h, bottom: 3.h),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Evaluation Done",
//             style: TextStyle(
//               fontFamily: "GothamBook",
//               color: gWhiteColor,
//               fontSize: 10.sp,
//             ),
//           ),
//           SizedBox(height: 2.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () {},
//                 child: Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                   color: gWhiteColor.withOpacity(0.7),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: gWhiteColor,
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: const [
//                     BoxShadow(
//                       blurRadius: 10,
//                       color: gBlackColor,
//                       offset: Offset(2, 5),
//                     ),
//                   ],
//                 ),
//                 child: SimpleCircularProgressBar(
//                     size: 100,
//                     startAngle: 100,
//                     progressStrokeWidth: 3,
//                     valueNotifier: ValueNotifier(58.0),
//                     backColor: gPrimaryColor.withOpacity(0.1),
//                     progressColors: const [gPrimaryColor, gPrimaryColor],
//                     onGetText: (double value) {
//                       return Text(
//                         "50%\nComplete",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           height: 1,
//                           fontFamily: "GothamBook",
//                           color: gMainColor,
//                           fontSize: 8.sp,
//                         ),
//                       );
//                     }),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Icon(
//                   Icons.arrow_forward_ios_outlined,
//                   color: gWhiteColor.withOpacity(0.7),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   buildEvaluationDone() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "Evaluation",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 1.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.01),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Image(
//                     image: const AssetImage("assets/images/5358621.png"),
//                     height: 4.h,
//                   ),
//                   SizedBox(width: 3.w),
//                   Expanded(
//                     child: Text(
//                       "View Evaluation",
//                       style: TextStyle(
//                           fontFamily: "GothamBook",
//                           color: gBlackColor,
//                           fontSize: 9.sp),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: gMainColor,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 2.h),
//                 width: double.maxFinite,
//                 height: 1,
//                 color: gGreyColor.withOpacity(0.5),
//               ),
//               Row(
//                 children: [
//                   Image(
//                     image: const AssetImage("assets/images/5358621.png"),
//                     height: 4.h,
//                   ),
//                   SizedBox(width: 3.w),
//                   Expanded(
//                     child: Text(
//                       "View Report",
//                       style: TextStyle(
//                           fontFamily: "GothamBook",
//                           color: gBlackColor,
//                           fontSize: 9.sp),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: const Icon(
//                       Icons.arrow_forward_ios_outlined,
//                       color: gMainColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   buildConsultationBooked() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "Consultation Booked",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 1.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               children: <TextSpan>[
//                 TextSpan(
//                   text: "Your Slot Has Been Booked @ ",
//                   style: TextStyle(
//                     height: 1.5,
//                     fontSize: 11.sp,
//                     fontFamily: "GothamBook",
//                     color: gBlackColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "11:00 AM",
//                   style: TextStyle(
//                     height: 1.5,
//                     fontSize: 11.sp,
//                     fontFamily: "GothamMedium",
//                     color: gBlackColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: " on the ",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     height: 1.5,
//                     fontFamily: "GothamBook",
//                     color: gBlackColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "28th March 2022",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     height: 1.5,
//                     fontFamily: "GothamMedium",
//                     color: gBlackColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: ", Has Been Confirmed",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     height: 1.5,
//                     fontFamily: "GothamBook",
//                     color: gBlackColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//             width: double.maxFinite,
//             padding: EdgeInsets.symmetric(vertical: 1.h),
//             margin: EdgeInsets.symmetric(vertical: 2.h),
//             decoration: BoxDecoration(
//               color: gWhiteColor,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: gMainColor, width: 1),
//             ),
//             child: Center(
//               child: Text(
//                 'Join',
//                 style: TextStyle(
//                   fontFamily: "GothamBold",
//                   color: gSecondaryColor,
//                   fontSize: 13.sp,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   buildConsultationDone() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "Consultation Done",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         // Container(
//         //   margin: EdgeInsets.symmetric(vertical: 2.h),
//         //   padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
//         //   decoration: BoxDecoration(
//         //     gradient: LinearGradient(
//         //         colors: [gSecondaryColor, gWhiteColor.withOpacity(1)],
//         //         begin: Alignment.topCenter,
//         //         end: Alignment.bottomRight),
//         //     borderRadius: BorderRadius.circular(8),
//         //   ),
//         //   child: Text(
//         //     "Your Consultation has been rejected our success team will get back to you soon",
//         //     textAlign: TextAlign.center,
//         //     style: TextStyle(
//         //       height: 1.5,
//         //         fontFamily: "GothamBook",
//         //         color: gWhiteColor,
//         //         fontSize: 11.sp),
//         //   ),
//         // ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 2.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [Color(0xff5CAf33), gWhiteColor.withOpacity(1)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomRight),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             "You Have Successfully Completed Your Consultation",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 height: 1.5,
//                 fontFamily: "GothamBook",
//                 color: gWhiteColor,
//                 fontSize: 11.sp),
//           ),
//         ),
//         // Container(
//         //   margin: EdgeInsets.symmetric(vertical: 1.h),
//         //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
//         //   decoration: BoxDecoration(
//         //     color: gBlackColor.withOpacity(0.05),
//         //     borderRadius: BorderRadius.circular(8),
//         //   ),
//         //   child: RichText(
//         //     textAlign: TextAlign.center,
//         //     text: TextSpan(
//         //       children: <TextSpan>[
//         //         TextSpan(
//         //           text: "Your Slot Has Been Booked @ ",
//         //           style: TextStyle(
//         //             height: 1.5,
//         //             fontSize: 11.sp,
//         //             fontFamily: "GothamBook",
//         //             color: gBlackColor,
//         //           ),
//         //         ),
//         //         TextSpan(
//         //           text: "11:00 AM",
//         //           style: TextStyle(
//         //             height: 1.5,
//         //             fontSize: 11.sp,
//         //             fontFamily: "GothamMedium",
//         //             color: gBlackColor,
//         //           ),
//         //         ),
//         //         TextSpan(
//         //           text: " on the ",
//         //           style: TextStyle(
//         //             fontSize: 11.sp,
//         //             height: 1.5,
//         //             fontFamily: "GothamBook",
//         //             color: gBlackColor,
//         //           ),
//         //         ),
//         //         TextSpan(
//         //           text: "28th March 2022",
//         //           style: TextStyle(
//         //             fontSize: 11.sp,
//         //             height: 1.5,
//         //             fontFamily: "GothamMedium",
//         //             color: gBlackColor,
//         //           ),
//         //         ),
//         //         TextSpan(
//         //           text: ", Has Been Confirmed",
//         //           style: TextStyle(
//         //             fontSize: 11.sp,
//         //             height: 1.5,
//         //             fontFamily: "GothamBook",
//         //             color: gBlackColor,
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         GestureDetector(
//           onTap: () {},
//           child: Container(
//             width: double.maxFinite,
//             padding: EdgeInsets.symmetric(vertical: 1.5.h),
//             decoration: BoxDecoration(
//               color: gWhiteColor,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: gMainColor, width: 1),
//             ),
//             child: Center(
//               child: Text(
//                 'View MR Report',
//                 style: TextStyle(
//                   fontFamily: "GothamBold",
//                   color: gSecondaryColor,
//                   fontSize: 11.sp,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   buildTracker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "Tracker",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 1.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.01),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Image(
//                     image: const AssetImage("assets/images/5358621.png"),
//                     height: 4.h,
//                   ),
//                   SizedBox(width: 3.w),
//                   Expanded(
//                     child: Text(
//                       "Shopping List Evaluation",
//                       style: TextStyle(
//                           fontFamily: "GothamBook",
//                           color: gBlackColor,
//                           fontSize: 9.sp),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: gMainColor,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 2.h),
//                 width: double.maxFinite,
//                 height: 1,
//                 color: gGreyColor.withOpacity(0.5),
//               ),
//               Row(
//                 children: [
//                   Image(
//                     image: const AssetImage("assets/images/5358621.png"),
//                     height: 4.h,
//                   ),
//                   SizedBox(width: 3.w),
//                   Expanded(
//                     child: Text(
//                       "Shipping Tracker",
//                       style: TextStyle(
//                           fontFamily: "GothamBook",
//                           color: gBlackColor,
//                           fontSize: 9.sp),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {},
//                     child: const Icon(
//                       Icons.arrow_forward_ios_outlined,
//                       color: gMainColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   buildMealPlan() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "Meal Plan",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         Container(
//           height: 15.h,
//           width: double.maxFinite,
//           //  margin: EdgeInsets.symmetric(horizontal: 3.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.01),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: data.length,
//             itemBuilder: ((context, index) {
//               double y = data[index] / 100.toDouble();
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 3.w),
//                 child: VerticalBarIndicator(
//                   width: 5.w,
//                   height: 10.h,
//                   footerStyle: TextStyle(
//                       fontSize: 8.sp,
//                       fontFamily: "GothamMedium",
//                       color: gPrimaryColor),
//                   footer: "Day${dailyProgress[index]}",
//                   animationDuration: const Duration(seconds: 1),
//                   circularRadius: 0,
//                   percent: buildBar(y),
//                   color: buildTextColor(y),
//                 ),
//               );
//             }),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 1.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.01),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Image(
//                 image: const AssetImage("assets/images/5358621.png"),
//                 height: 4.h,
//               ),
//               SizedBox(width: 3.w),
//               Expanded(
//                 child: Text(
//                   "View Present Day MealPlan",
//                   style: TextStyle(
//                       fontFamily: "GothamBook",
//                       color: gBlackColor,
//                       fontSize: 9.sp),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: const Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   color: gMainColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   buildPPBooked() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "PP Consultation Booked",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 1.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               children: <TextSpan>[
//                 TextSpan(
//                   text: "Your Slot Has Been Booked @ ",
//                   style: TextStyle(
//                     height: 1.5,
//                     fontSize: 11.sp,
//                     fontFamily: "GothamBook",
//                     color: gPrimaryColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "11:00 AM",
//                   style: TextStyle(
//                     height: 1.5,
//                     fontSize: 11.sp,
//                     fontFamily: "GothamMedium",
//                     color: gPrimaryColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: " on the ",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     height: 1.5,
//                     fontFamily: "GothamBook",
//                     color: gPrimaryColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "28th March 2022",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     height: 1.5,
//                     fontFamily: "GothamMedium",
//                     color: gPrimaryColor,
//                   ),
//                 ),
//                 TextSpan(
//                   text: ", Has Been Confirmed",
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     height: 1.5,
//                     fontFamily: "GothamBook",
//                     color: gPrimaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // GestureDetector(
//         //   onTap: () {},
//         //   child: Container(
//         //     width: double.maxFinite,
//         //     padding: EdgeInsets.symmetric(vertical: 1.h),
//         //     margin: EdgeInsets.symmetric(vertical: 2.h),
//         //     decoration: BoxDecoration(
//         //       color: gWhiteColor,
//         //       borderRadius: BorderRadius.circular(8),
//         //       border: Border.all(color: gMainColor, width: 1),
//         //     ),
//         //     child: Center(
//         //       child: Text(
//         //         'Join',
//         //         style: TextStyle(
//         //           fontFamily: "GothamBold",
//         //           color: gSecondaryColor,
//         //           fontSize: 13.sp,
//         //         ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   buildPPConsultation() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const CommonWidgets(
//           points: '01Pts',
//           value1: '50',
//           value2: '40',
//           value3: '30',
//           value4: '20',
//           comments:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem lpsum has been the industry\'s standard dummy text ever since the 1500s,when an unknown printer took a gallery of type and scrambled it to make a type specimen book.",
//         ),
//         Text(
//           "PP Consultation",
//           style: TextStyle(
//               fontFamily: "GothamMedium",
//               color: gPrimaryColor,
//               fontSize: 11.sp),
//         ),
//         SizedBox(height: 1.h),
//         Container(
//           height: 13.h,
//           width: double.maxFinite,
//           //  margin: EdgeInsets.symmetric(horizontal: 3.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.04),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: data.length,
//             itemBuilder: ((context, index) {
//               double y = data[index] / 100.toDouble();
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 3.w),
//                 child: VerticalBarIndicator(
//                   width: 5.w,
//                   height: 8.h,
//                   footerStyle: TextStyle(
//                       fontSize: 8.sp,
//                       fontFamily: "GothamMedium",
//                       color: gPrimaryColor),
//                   footer: "Day${dailyProgress[index]}",
//                   animationDuration: const Duration(seconds: 2),
//                   circularRadius: 0,
//                   percent: buildBar(y),
//                   color: buildTextColor(y),
//                 ),
//               );
//             }),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 1.h),
//           padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
//           decoration: BoxDecoration(
//             color: gBlackColor.withOpacity(0.04),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Image(
//                 image: const AssetImage("assets/images/5358621.png"),
//                 height: 4.h,
//               ),
//               SizedBox(width: 3.w),
//               Expanded(
//                 child: Text(
//                   "View Present Day MealPlan",
//                   style: TextStyle(
//                       fontFamily: "GothamBook",
//                       color: gBlackColor,
//                       fontSize: 9.sp),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: const Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   color: gMainColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   buildTextColor(double value) {
//     if (0.3 > value) {
//       return [gSecondaryColor, gSecondaryColor];
//     } else if (0.6 > value) {
//       return [gMainColor, gMainColor];
//     } else if (1.0 >= value) {
//       return [gPrimaryColor, gPrimaryColor];
//     }
//   }
//
//   buildCenterText(double data) {
//     if (100 < data) {
//       return Text(
//         "100 %",
//         style: TextStyle(
//             fontSize: 8.sp, fontFamily: "GothamBook", color: gMainColor),
//       );
//     } else {
//       return Text(
//         "${data.toStringAsFixed(2)} %",
//         style: TextStyle(
//             fontSize: 8.sp, fontFamily: "GothamBook", color: gMainColor),
//       );
//     }
//   }
//
//   buildBar(double y) {
//     if (1.0 < y) {
//       return 1.0;
//     } else {
//       return y;
//     }
//   }
// }
