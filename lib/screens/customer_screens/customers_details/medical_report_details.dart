import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../model/customer_profile_model.dart';
import '../../../model/error_model.dart';
import '../../../repository/api_service.dart';
import '../../../repository/customer_details_repo/customer_profile_repo.dart';
import '../../../services/customer_details_service/customer_profile_service.dart';
import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/widgets.dart';

class MedicalReportDetails extends StatefulWidget {
  final int userId;
  const MedicalReportDetails({Key? key, required this.userId})
      : super(key: key);

  @override
  State<MedicalReportDetails> createState() => _MedicalReportDetailsState();
}

class _MedicalReportDetailsState extends State<MedicalReportDetails> {
  GetCustomerModel? getCustomerModel;
  String mrUrl = "";
  bool showProgress = false;

  late final CustomerProfileService customerProfileService =
      CustomerProfileService(customerProfileRepo: repository);

  @override
  void initState() {
    super.initState();
    getCustomerDetails();
  }

  getCustomerDetails() async {
    setState(() {
      showProgress = true;
    });
    final result = await customerProfileService
        .getCustomerProfileService(widget.userId.toString());
    print("result: $result");

    if (result.runtimeType == GetCustomerModel) {
      print("Customer Profile");
      GetCustomerModel model = result as GetCustomerModel;

      getCustomerModel = model;
      setState(() {
        mrUrl = "${getCustomerModel?.mrReport?.report}";
        print("mrUrl : $mrUrl");

      });
    } else {
      ErrorModel model = result as ErrorModel;
      print("error: ${model.message}");
    }
    setState(() {
      showProgress = false;
    });
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return showProgress
        ? buildCircularIndicator()
        : Column(
            children: [
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              SizedBox(height: 3.h),
              (mrUrl == "null")
                  ? Column(
                      children: [
                        SizedBox(height: 5.h),
                        const Image(
                          image: AssetImage("assets/images/5358621.png"),
                        ),
                        SizedBox(height: 3.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Text(
                            "Case Study & Medical Report are not yet Completed.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 12.sp,
                              color: newBlackColor,
                              fontFamily: "GothamMedium",
                            ),
                          ),
                        )
                      ],
                    )
                  : Expanded(
                      child: SfPdfViewer.network(
                        mrUrl,
                      ),
                    ),
            ],
          );
  }

  final CustomerProfileRepo repository = CustomerProfileRepo(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );
}
