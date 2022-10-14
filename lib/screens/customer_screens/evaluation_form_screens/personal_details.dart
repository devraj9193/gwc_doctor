import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../controller/mr_reports_controller.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  MRReportsController mrReportsController = Get.put(MRReportsController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
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
                    buildTextStyle("Full Name :"),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.patient.user.name ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle("Marital Status :"),
                    Row(
                      children: [
                        Radio(
                          value: "single",
                          activeColor: gPrimaryColor,
                          groupValue:
                              data.data.patient.maritalStatus.toString(),
                          onChanged: (value) {},
                        ),
                        Text(
                          'Single',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Radio(
                          value: "married",
                          activeColor: gPrimaryColor,
                          groupValue:
                              data.data.patient.maritalStatus.toString(),
                          onChanged: (value) {},
                        ),
                        Text(
                          'Married',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Radio(
                            value: "separated",
                            groupValue:
                                data.data.patient.maritalStatus.toString(),
                            activeColor: gPrimaryColor,
                            onChanged: (value) {}),
                        Text(
                          "Separated",
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    buildTextStyle("Phone Number :"),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.patient.user.phone ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle("Email ID :"),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.patient.user.email ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle("Age :"),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.patient.user.age ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle("Gender :"),
                    Row(
                      children: [
                        Radio(
                          value: "male",
                          activeColor: gPrimaryColor,
                          groupValue: data.data.patient.user.gender.toString(),
                          onChanged: (value) {},
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Radio(
                          value: "female",
                          activeColor: gPrimaryColor,
                          groupValue: data.data.patient.user.gender.toString(),
                          onChanged: (value) {},
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Radio(
                            value: "other",
                            groupValue:
                                data.data.patient.user.gender.toString(),
                            activeColor: gPrimaryColor,
                            onChanged: (value) {}),
                        Text(
                          "Other",
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: gTextColor,
                            fontFamily: "GothamBook",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    buildTextStyle(
                        "Full Postal Address To Deliver Your Ready To Cook Kit :"),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.patient.user.address ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                    SizedBox(height: 2.h),
                    buildTextStyle("Pin Code :"),
                    SizedBox(height: 1.5.h),
                    Text(
                      data.data.patient.user.pincode ?? "",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: gTextColor,
                        fontFamily: "GothamBook",
                      ),
                    ),
                  ],
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: buildCircularIndicator(),
              );
            }),
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
              height: 1.5,
              fontSize: 11.sp,
              color: gPrimaryColor,
              fontFamily: "GothamMedium",
            ),
          ),
          TextSpan(
            text: ' *',
            style: TextStyle(
              fontSize: 11.sp,
              height: 1.5,
              color: gSecondaryColor,
              fontFamily: "GothamMedium",
            ),
          ),
        ],
      ),
    );
  }
}
