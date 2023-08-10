import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../utils/constants.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("Hold On!",
            style: TextStyle(
                fontSize: fontSize13,
                fontFamily: kFontBold,
                height: 1.4
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            color: gHintTextColor,
            thickness: 1.2,
          ),
        ),
        Center(
          child: Text(
            'Do you want to exit an App?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: gTextColor,
              fontSize: fontSize11,
              fontFamily: kFontMedium,
            ),
          ),
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => SystemNavigator.pop(),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 1.h, horizontal: 12.w),
                decoration: BoxDecoration(
                    color: gSecondaryColor,
                    border: Border.all(color: gHintTextColor, width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "YES",
                  style: TextStyle(
                    fontFamily: kFontMedium,
                    color: gWhiteColor,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 1.h, horizontal: 12.w),
                decoration: BoxDecoration(
                    color: gWhiteColor,
                    border: Border.all(color: gHintTextColor, width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "NO",
                  style: TextStyle(
                    fontFamily: kFontMedium,
                    color: gSecondaryColor,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h)
      ],
    );
  }
}
