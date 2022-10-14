import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/mr_reports_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';

class UserReportsDetails extends StatefulWidget {
  const UserReportsDetails({Key? key}) : super(key: key);

  @override
  State<UserReportsDetails> createState() => _UserReportsDetailsState();
}

class _UserReportsDetailsState extends State<UserReportsDetails> {
  MRReportsController mrReportsController = Get.put(MRReportsController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(height: 2.h),
          FutureBuilder(
              future: mrReportsController.fetchMRReportsList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final url = data[index].report.toString();
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              //forceSafariVC: true,
                              // forceWebView: true,
                              // enableJavaScript: true,
                            );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 2.w),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 3.w),
                          decoration: BoxDecoration(
                            color: gWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image(
                                height: 4.h,
                                image:
                                    const AssetImage("assets/images/pdf.png"),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index]
                                          .report
                                          .toString()
                                          .split("/")
                                          .last,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      style: TextStyle(
                                          height: 1.2,
                                          fontFamily: "GothamMedium",
                                          color: gPrimaryColor,
                                          fontSize: 9.sp),
                                    ),
                                    // SizedBox(height: 1.h),
                                    // Text(
                                    //   "2 MB",
                                    //   style: TextStyle(
                                    //       fontFamily: "GothamBook",
                                    //       color: gMainColor,
                                    //       fontSize: 9.sp),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: gMainColor,
                                size: 2.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: buildCircularIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
