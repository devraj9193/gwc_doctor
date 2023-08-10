import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/consultation_controller.dart';
import '../../utils/constants.dart';

class DoctorStatusScreen extends StatefulWidget {
  const DoctorStatusScreen({Key? key}) : super(key: key);

  @override
  State<DoctorStatusScreen> createState() => _DoctorStatusScreenState();
}

class _DoctorStatusScreenState extends State<DoctorStatusScreen> {
  ConsultationController consultationController =
      Get.put(ConsultationController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: consultationController.fetchConsultation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTile("assets/images/Group 2810.png",
                    data.pendingConsultation.toString(), "Pending", () {}),
                buildTile("assets/images/Group 2803.png",
                    data.completedConsultation.toString(), "Completed", () {}),
                buildTile("assets/images/Group 2804.png",
                    data.mrPendingConsultation.toString(), "MR Pending", () {}),
              ],
            );
          }
          return Container();
        });
  }

  buildTile(String image, String title, String subTitle, func) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: 29.w,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: gSecondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 5.h,
              color: whiteTextColor,
              image: AssetImage(
                image,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              title,
              style: TextStyle(
                  fontFamily: fontBold,
                  color: whiteTextColor,
                  fontSize: fontSize13),
            ),
            SizedBox(height: 1.h),
            Text(
              subTitle,
              style: TextStyle(
                  fontFamily: fontBook,
                  color: whiteTextColor,
                  fontSize: fontSize08),
            ),
          ],
        ),
      ),
    );
  }
}
