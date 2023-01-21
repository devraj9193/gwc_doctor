import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../utils/constants.dart';

class PopUpMenuWidget extends StatefulWidget {
  final VoidCallback onView;
  final VoidCallback onCall;
  final VoidCallback onMessage;


  const PopUpMenuWidget({Key? key, required this.onView, required this.onCall, required this.onMessage}) : super(key: key);

  @override
  State<PopUpMenuWidget> createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              GestureDetector(
                onTap: widget.onView,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gTextColor,
                          fontSize: 8.sp),
                    ),
                    SvgPicture.asset(
                        "assets/images/noun-view-1041859.svg")
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                height: 1,
                color: gGreyColor.withOpacity(0.3),
              ),
              GestureDetector(
                onTap: widget.onCall,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Call",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gSecondaryColor,
                          fontSize: 8.sp),
                    ),
                    Image(
                      image: const AssetImage(
                          "assets/images/Group 4890.png"),
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.5.h),
                height: 1,
                color: gGreyColor.withOpacity(0.3),
              ),
              GestureDetector(
                onTap: widget.onMessage,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gTextColor,
                          fontSize: 8.sp),
                    ),
                    Image(
                      image: const AssetImage(
                          "assets/images/Group 4891.png"),
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.5.h),
            ],
          ),
        ),
      ],
      child: Icon(
        Icons.more_vert,
        color: gGreyColor.withOpacity(0.5),
      ),
    );
  }
}
