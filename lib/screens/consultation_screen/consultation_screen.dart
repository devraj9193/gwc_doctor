import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
import '../customer_screens/customers_lists/consultation_list.dart';
import '../chart_screen/doctor_status_screen.dart';
import '../customer_screens/customers_lists/document_upload_list.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({Key? key}) : super(key: key);

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gWhiteColor,
          appBar: buildAppBar(() {
            Navigator.pop(context);
          }),
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 1.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DoctorStatusScreen(),
                SizedBox(height: 2.h),
                TabBar(
                    labelColor: tapSelectedColor,
                    unselectedLabelColor: tapUnSelectedColor,
                    isScrollable: true,
                    indicatorColor: tapIndicatorColor,
                    labelPadding:
                        EdgeInsets.only(right: 12.w,left: 2.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 7.w),
                    labelStyle:TabBarText().selectedText(),
                    unselectedLabelStyle: TabBarText().unSelectedText(),
                    tabs: const [
                      Text('Consultation'),
                      Text('Documents'),
                    ]),
                const Expanded(
                  child: TabBarView(children: [
                    ConsultationList(),
                    DocumentUploadList(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
