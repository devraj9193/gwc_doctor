import 'package:flutter/material.dart';
import 'dart:math';

import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class LevelMapPage extends StatefulWidget {
  @override
  _LevelMapPageState createState() => _LevelMapPageState();
}

class _LevelMapPageState extends State<LevelMapPage> {
  List levels = [
    {
      "images": "assets/images/noun-appointment-3615898.png",
      "title": "Evaluation Done"
    },
    {
      "images": "assets/images/noun-appointment-4042317.png",
      "title": "Consultation Booked"
    },
    {
      "images": "assets/images/noun-information-book-1677218.png",
      "title": "Consultation Done"
    },
    {
      "images": "assets/images/noun-shipping-5332930.png",
      "title": "Tracker",
    },
    {
      "images": "assets/images/noun-appointment-4042317.png",
      "title": "Programs"
    },
    {
      "images": "assets/images/noun-information-book-1677218.png",
      "title": "Post Program\nConsultation Booked"
    },
    {
      "images": "assets/images/noun-shipping-5332930.png",
      "title": "Maintenance Guide\nUpdated",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: showImage(),
      // body: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: SizedBox(
      //     // height: double.maxFinite,
      //     // width: double.maxFinite,
      //     child: Column(
      //       children: [
      //         Image(
      //           image: AssetImage("assets/images/lock.png"),
      //           height: 6.h,
      //         ),
      //         Image(
      //           image: AssetImage("assets/images/Mask Group 4.png"),
      //           height: 20.h,
      //         ),
      //         // Expanded(
      //         //   child: CustomPaint(
      //         //     painter: TestPathPainter(),
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  showLevels() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        shrinkWrap: true,
        reverse: true,
        itemCount: 4,
        itemBuilder: (_, index) {
          if (index.isEven) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image(
                          image: AssetImage("assets/images/current_stage.png"),
                          height: 60),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Image(
                        image: AssetImage("assets/images/Mask Group 20.png"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 00,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image(
                          image: AssetImage("assets/images/lock.png"),
                          height: 60),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 30),
                      child: Image(
                        image: AssetImage("assets/images/Group 10334.png"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  showImage() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        shrinkWrap: true,
        reverse: true,
        itemCount: levels.length,
        itemBuilder: (_, index) {
          if (index.isEven) {
            return Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                  image: AssetImage(levels[index]["images"]),
                                  height: 60),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              levels[index]["title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "GothamBook",
                                  height: 1.3,
                                  color: gSecondaryColor,
                                  fontSize: 10.sp),
                            )
                          ],
                        ),
                        SizedBox(width: 80),
                        GestureDetector(
                          onTap: () {},
                          child: Image(
                              image:
                                  AssetImage("assets/images/current_stage.png"),
                              height: 60),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Image(
                        image: AssetImage("assets/images/Mask Group 8.png"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 00,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image(
                              image: AssetImage("assets/images/lock.png"),
                              height: 60),
                        ),
                        SizedBox(width: 80),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                  image: AssetImage(levels[index]["images"]),
                                  height: 60),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              levels[index]["title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "GothamBook",
                                  height: 1.3,
                                  color: gSecondaryColor,
                                  fontSize: 10.sp),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 30),
                      child: Image(
                        image: AssetImage("assets/images/Mask Group 9.png"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class TestPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.black;

    final path = Path()
      ..moveTo(
        points[0].dx * size.width,
        points[0].dy * size.height,
      );
    points.sublist(1).forEach((point) {
      print(point.dx);
      path.lineTo(
        point.dx * size.width,
        point.dy * size.height,
      );
      canvas.drawLine(
          Offset(0, point.dy), Offset(0, startY + dashHeight), paint);
    });
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TestPathPainter oldDelegate) => false;
}

final random = Random();
final List<Offset> points = List.generate(
  6,
  (index) => Offset(.1 + random.nextDouble() * .8, .1 + index * .8 / 9),
);

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = Colors.black;
    path.moveTo(size.width * 0.5, 0);

    path.quadraticBezierTo(size.width * 0.90, size.height * 0.50,
        size.width * 0.35, size.height * 0.14);
    path.quadraticBezierTo(size.width * 0.02, size.height * 0.20,
        size.width * 0.46, size.height * 0.28);
    path.quadraticBezierTo(size.width * 0.80, size.height * 0.35,
        size.width * 0.66, size.height * 0.40);
    path.quadraticBezierTo(size.width * 0.32, size.height * 0.49,
        size.width * 0.60, size.height * 0.53);
    path.quadraticBezierTo(size.width * 0.98, size.height * 0.61,
        size.width * 0.30, size.height * 0.67);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.71,
        size.width * 0.30, size.height * 0.76);
    path.quadraticBezierTo(
        size.width * 0.90, size.height * 0.91, size.width * 0.30, size.height);

    // path.quadraticBezierTo(size.width*0.08, size.height*0.45, size.width*0.65,size.height*0.60 );
    //
    // path.moveTo(size.width*0.09, size.height*0.67);
    // path.quadraticBezierTo(size.width*0.14, size.height*0.68, size.width*0.17, size.height*0.75);
    // path.quadraticBezierTo(size.width*0.22,size.height*0.68, size.width*0.28, size.height*0.67);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

// import 'dart:math' as math;
// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// class SplinePainter extends CustomPainter {  @override  void paint(Canvas canvas, Size size) {    canvas.drawPaint(Paint()..color = Colors.white);    const controlWidthSingle = 50;    final random = math.Random();    /// This method generates control points, the x = 50*index(+1)    /// the y is set to random values between half of the screen and bottom of the screen    final controlPoints = List.generate(      size.width ~/ controlWidthSingle,      (index) => Offset(        controlWidthSingle * (index + 1),        random.nextDouble() * (size.height - size.height / 2) + size.height / 2,      ),    ).toList();    final spline = CatmullRomSpline(controlPoints);    final bezierPaint = Paint()      // set the edges of stroke to be rounded      ..strokeCap = StrokeCap.round      ..strokeWidth = 12      // apply a gradient      ..shader = const LinearGradient(colors: [        Colors.purple,        Colors.teal,      ]).createShader(Offset(0, size.height) & size);    // This method accepts a list of offsets and draws points for all offset    canvas.drawPoints(      PointMode.points,      spline.generateSamples().map((e) => e.value).toList(),      bezierPaint,    );  }  @override  bool shouldRepaint(SplinePainter oldDelegate) => false;}
//
