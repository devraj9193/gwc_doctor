import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../controller/mr_reports_controller.dart';
import '../../../utils/app_config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

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
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    child: Image(
                      image: const AssetImage("assets/images/Group 5294.png"),
                      height: 35.h,
                    ),
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
                          print(data[index].report.toString());
                          final a = data[index].report;
                          final file = a.split(".").last;
                          String format = file.toString();
                          print(format); //prints dart
                          if (format == "jpg" ||
                              format == "png" ||
                              format == "gif") {
                            openJPGFile(a, context);
                          } else if (format == "pdf") {
                            openPDFFile(a, context);
                          } else {
                            AppConfig().showSnackBar(
                                context, "Invalid File Format",
                                isError: true);
                          }
                          // final url = data[index].report.toString();
                          // if (await canLaunch(url)) {
                          //   await launch(
                          //     url,
                          //     //forceSafariVC: true,
                          //     // forceWebView: true,
                          //     // enableJavaScript: true,
                          //   );
                          // }
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

  void openJPGFile(String file, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          decoration: const BoxDecoration(
            color: gWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'User Reports',
                          style: TextStyle(
                              fontFamily: "GothamBold",
                              color: gSecondaryColor,
                              fontSize: 11.sp),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: gMainColor, width: 1),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: gMainColor,
                          size: 1.6.h,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                height: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
              Expanded(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/progress_logo.png',
                  placeholderCacheHeight: 80,
                  placeholderCacheWidth: 50,
                  image: file,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openPDFFile(String file, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          decoration: const BoxDecoration(
            color: gWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'User Reports',
                          style: TextStyle(
                              fontFamily: "GothamBold",
                              color: gSecondaryColor,
                              fontSize: 11.sp),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: gMainColor, width: 1),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: gMainColor,
                          size: 1.6.h,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                height: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
              Expanded(
                child: SfPdfViewer.network(
                  file,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
