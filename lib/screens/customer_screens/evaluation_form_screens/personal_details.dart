import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/mr_reports_controller.dart';
import '../../../utils/constants.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  MRReportsController mrReportsController = Get.put(MRReportsController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mrReportsController.fetchPersonalDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Personal Details",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "PoppinsBold",
                              color: kPrimaryColor,
                              fontSize: 15.sp),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Let Us Know You Better",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: gMainColor,
                          fontSize: 9.sp),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Full Name :"),
                SizedBox(height: 1.5.h),
                Text(
                  data.data.patient.user.name ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "GothamBook",
                      color: gBlackColor,
                      fontSize: 9.sp),
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Marital Status :"),
                Row(
                  children: [
                    Radio(
                      value: "single",
                      activeColor: gSecondaryColor,
                      groupValue: data.data.patient.maritalStatus.toString(),
                      onChanged: (value) {},
                    ),
                    Text(
                      'Single',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 9.sp),
                    ),
                    SizedBox(width: 3.w),
                    Radio(
                      value: "married",
                      activeColor: gSecondaryColor,
                      groupValue: data.data.patient.maritalStatus.toString(),
                      onChanged: (value) {},
                    ),
                    Text(
                      'Married',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 9.sp),
                    ),
                    SizedBox(width: 3.w),
                    Radio(
                        value: "separated",
                        groupValue: data.data.patient.maritalStatus.toString(),
                        activeColor: gSecondaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Separated",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 9.sp),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                buildTextStyle("Phone Number :"),
                SizedBox(height: 1.5.h),
                Text(
                  data.data.patient.user.phone ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "GothamBook",
                      color: gBlackColor,
                      fontSize: 9.sp),
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Email ID :"),
                SizedBox(height: 1.5.h),
                Text(
                  data.data.patient.user.email ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "GothamBook",
                      color: gBlackColor,
                      fontSize: 9.sp),
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Age :"),
                SizedBox(height: 1.5.h),
                Text(
                  data.data.patient.user.age ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "GothamBook",
                      color: gBlackColor,
                      fontSize: 9.sp),
                ),
                SizedBox(height: 2.h),
                buildTextStyle("Gender :"),
                Row(
                  children: [
                    Radio(
                      value: "male",
                      activeColor: gSecondaryColor,
                      groupValue: data.data.patient.user.gender.toString(),
                      onChanged: (value) {},
                    ),
                    Text(
                      'Male',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 9.sp),
                    ),
                    SizedBox(width: 3.w),
                    Radio(
                      value: "female",
                      activeColor: gSecondaryColor,
                      groupValue: data.data.patient.user.gender.toString(),
                      onChanged: (value) {},
                    ),
                    Text(
                      'Female',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 9.sp),
                    ),
                    SizedBox(width: 3.w),
                    Radio(
                        value: "other",
                        groupValue: data.data.patient.user.gender.toString(),
                        activeColor: gSecondaryColor,
                        onChanged: (value) {}),
                    Text(
                      "Other",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gBlackColor,
                          fontSize: 9.sp),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                buildTextStyle('Address'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildContainer("${data.data.patient.user.address ?? ""},"),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: buildContainer(data.data.patient.address2 ?? ''),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                buildTextStyle('Pin Code'),
                buildContainer(
                  data.data.patient.user.pincode ?? "",
                ),
                SizedBox(height: 1.h),
                buildTextStyle('City'),
                buildContainer(data.data.patient.city ?? ""),
                SizedBox(height: 1.h),
                buildTextStyle('State'),
                buildContainer(data.data.patient.state ?? ''),
                SizedBox(height: 1.h),
                buildTextStyle('Country'),
                buildContainer(data.data.patient.country ?? ''),
              ],
            );
          }
          return Container();
        });
  }

  buildContainer(String title) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      // width: double.maxFinite,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: gGreyColor.withOpacity(0.5),
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(8),
      //   color: gWhiteColor,
      // ),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
            height: 1.3,
            fontFamily: "GothamBook",
            color: gBlackColor,
            fontSize: 9.sp),
      ),
    );
  }

  buildTextStyle(String title) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 11.sp,
              color: gBlackColor,
              fontFamily: "GothamMedium",
            ),
          ),
          TextSpan(
            text: ' *',
            style: TextStyle(
              fontSize: 9.sp,
              color: gGreyColor,
              fontFamily: "PoppinsSemiBold",
            ),
          ),
        ],
      ),
    );
  }
}
