import 'package:doctor_app_new/screens/login_screens/resend_otp_screen.dart';
import 'package:doctor_app_new/screens/dashboard_screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controller/repository/api_service.dart';
import '../../controller/repository/login_otp_repository.dart';
import '../../controller/services/login_otp_service.dart';
import '../../model/error_model.dart';
import '../../model/login_model/login_otp_model.dart';
import '../../model/login_model/resend_otp_model.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({Key? key}) : super(key: key);

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  final formKey = GlobalKey<FormState>();
  final mobileFormKey = GlobalKey<FormState>();
  late FocusNode _phoneFocus;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  late bool otpVisibility;
  String? deviceToken = "";

  String countryCode = '+91';

  bool otpSent = false;
  bool showLoginProgress = false;

  String otpMessage = "Sending OTP";

  late Future getOtpFuture, loginFuture;

  late LoginWithOtpService _loginWithOtpService;

  final SharedPreferences _pref = AppConfig().preferences!;

  @override
  void initState() {
    super.initState();
    _loginWithOtpService = LoginWithOtpService(repository: repository);
    otpVisibility = false;
    _phoneFocus = FocusNode();
    doctorDeviceToken();
    phoneController.addListener(() {
      setState(() {});
    });
    otpController.addListener(() {
      setState(() {});
    });
    _phoneFocus.addListener(() {
      // print("!_phoneFocus.hasFocus: ${_phoneFocus.hasFocus}");
      //
      // if(isPhone(phoneController.text) && !_phoneFocus.hasFocus){
      //   getOtp(phoneController.text);
      // }
      // print(_phoneFocus.hasFocus);
    });
  }

  void doctorDeviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    deviceToken = preferences.getString("device_token");
    setState(() {});
    print("deviceToken: $deviceToken");
  }

  @override
  void dispose() {
    super.dispose();
    _phoneFocus.removeListener(() {});
    phoneController.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage(
                  "assets/images/environment-green-watercolor-background-with-leaf-border-illustration (1).png"),
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 9.h,
                          child: const Image(
                            image: AssetImage(
                                "assets/images/Gut wellness logo green.png"),
                          ),
                        ),
                        buildForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Text(
            "Welcome To,",
            style: TextStyle(
                fontFamily: "GothamBold",
                color: gPrimaryColor,
                fontSize: 15.sp),
          ),
          SizedBox(height: 1.h),
          Text(
            "Doctor App",
            style: TextStyle(
                fontFamily: "GothamBook",
                color: gSecondaryColor,
                fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            "Mobile Number",
            style: TextStyle(
                fontFamily: "GothamMedium",
                color: gPrimaryColor,
                fontSize: 10.sp),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: false,
                child: CountryCodePicker(
                  // flagDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(7),
                  // ),
                  showDropDownButton: false,
                  showFlagDialog: true,
                  hideMainText: false,
                  showFlagMain: false,
                  showCountryOnly: true,
                  textStyle: TextStyle(
                      fontFamily: "GothamBook",
                      color: gMainColor,
                      fontSize: 11.sp),
                  padding: EdgeInsets.zero,
                  favorite: const ['+91', 'IN'],
                  initialSelection: countryCode,
                  onChanged: (val) {
                    print(val.code);
                    setState(() {
                      countryCode = val.dialCode.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: mobileFormKey,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    margin: EdgeInsets.only(top: 2.h),
                    decoration: BoxDecoration(
                        color: gWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      cursorColor: gPrimaryColor,
                      textAlignVertical: TextAlignVertical.center,
                      controller: phoneController,
                      style: TextStyle(
                          fontFamily: "GothamBook",
                          color: gMainColor,
                          fontSize: 11.sp),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Mobile Number';
                        } else if (!isPhone(value)) {
                          return 'Please enter valid Mobile Number';
                        } else {
                          return null;
                        }
                      },
                      onFieldSubmitted: (value) {
                        print("isPhone(value): ${isPhone(value)}");
                        print("!_phoneFocus.hasFocus: ${_phoneFocus.hasFocus}");
                        if (isPhone(value) && _phoneFocus.hasFocus) {
                          getOtp(value);
                        }
                      },
                      focusNode: _phoneFocus,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone_iphone_outlined,
                          color: gPrimaryColor,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 2),
                        suffixIcon: !isPhone(phoneController.value.text)
                            ? phoneController.text.isEmpty
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      phoneController.clear();
                                    },
                                    child: const Icon(
                                      Icons.cancel_outlined,
                                      color: gMainColor,
                                    ),
                                  )
                            : GestureDetector(
                                onTap: (otpMessage
                                        .toLowerCase()
                                        .contains('otp sent'))
                                    ? null
                                    : () {
                                        if (isPhone(phoneController.text) &&
                                            _phoneFocus.hasFocus) {
                                          getOtp(phoneController.text);
                                        }
                                      },
                                child: Icon(
                                  (otpMessage
                                          .toLowerCase()
                                          .contains('otp sent'))
                                      ? Icons.check_circle_outline
                                      : Icons.keyboard_arrow_right,
                                  color: gMainColor,
                                  size: 22,
                                ),
                              ),
                        hintText: "MobileNumber",
                        hintStyle: TextStyle(
                          fontFamily: "GothamBook",
                          color: gPrimaryColor,
                          fontSize: 9.sp,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Visibility(visible: otpSent, child: SizedBox(height: 1.h)),
          Visibility(
            visible: otpSent,
            child: Text(
              otpMessage,
              style: TextStyle(
                  fontFamily: "GothamMedium",
                  color: gPrimaryColor,
                  fontSize: 8.5.sp),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            "Enter your OTP",
            style: TextStyle(
                fontFamily: "GothamMedium",
                color: gPrimaryColor,
                fontSize: 10.sp),
          ),
          Form(
            autovalidateMode: AutovalidateMode.disabled,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                  color: gWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                cursorColor: gPrimaryColor,
                controller: otpController,
                obscureText: !otpVisibility,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(
                    fontFamily: "GothamBook",
                    color: gPrimaryColor,
                    fontSize: 11.sp),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.lock_outline_sharp,
                    color: gPrimaryColor,
                  ),
                  isDense: true,
                  // fillColor: MainTheme.fillColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                  hintText: "OTP",
                  hintStyle: TextStyle(
                    fontFamily: "GothamBook",
                    color: gPrimaryColor,
                    fontSize: 9.sp,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        otpVisibility = !otpVisibility;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        otpVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: gPrimaryColor,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ResendOtpScreen()));
            },
            child: Text(
              "Resend OTP",
              style: TextStyle(
                  fontFamily: "GothamBook",
                  color: gSecondaryColor,
                  fontSize: 10.sp),
            ),
          ),
          SizedBox(height: 6.h),
          Center(
            child: GestureDetector(
              onTap: (showLoginProgress)
                  ? null
                  : () {
                      if (mobileFormKey.currentState!.validate() &&
                          phoneController.text.isNotEmpty &&
                          otpController.text.isNotEmpty) {
                        login(phoneController.text, otpController.text,"$deviceToken");
                      }
                    },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 7.w),
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: (phoneController.text.isEmpty ||
                          otpController.text.isEmpty)
                      ? gMainColor
                      : gPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: gMainColor, width: 1),
                ),
                child: (showLoginProgress)
                    ? buildThreeBounceIndicator(color: gMainColor)
                    : Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: "GothamMedium",
                            color: (phoneController.text.isEmpty ||
                                    otpController.text.isEmpty)
                                ? gPrimaryColor
                                : gMainColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final LoginOtpRepository repository = LoginOtpRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  bool isPhone(String input) =>
      RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(input);

  void getOtp(String phoneNumber) async {
    setState(() {
      otpSent = true;
    });
    print("get otp");
    final result = await _loginWithOtpService.getOtpService(phoneNumber);

    if (result.runtimeType == GetOtpResponse) {
      GetOtpResponse model = result as GetOtpResponse;
      setState(() {
        otpMessage = "OTP Sent";
        otpController.text = result.otp!;
      });
      Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        setState(() {
          otpSent = false;
        });
      });
    } else {
      setState(() {
        otpSent = false;
      });
      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: true);
    }
  }

  login(String phone, String otp,String deviceToken) async {
    setState(() {
      showLoginProgress = true;
    });
    print("---------Login---------");
    final result = await _loginWithOtpService.loginWithOtpService(phone, otp,deviceToken);

    if (result.runtimeType == LoginOtpModel) {
      LoginOtpModel model = result as LoginOtpModel;
      setState(() {
        showLoginProgress = false;
      });

      print("model.userEvaluationStatus: ${model.userEvaluationStatus}");

      // _pref.setString(AppConfig.EVAL_STATUS, model.userEvaluationStatus!);
      storeBearerToken(
        model.accessToken ?? '',
        model.loginUsername.toString(),
        model.chatId.toString(),
        model.isDoctorAdmin.toString(),
      );
      print("Login_Username : ${model.loginUsername}");
      print("chat_id : ${model.chatId}");

      if (model.userEvaluationStatus!.contains("pending")) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
    } else {
      setState(() {
        showLoginProgress = false;
      });
      _pref.setBool(AppConfig.isLogin, true);

      ErrorModel response = result as ErrorModel;
      AppConfig().showSnackBar(context, response.message!, isError: true);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const DashboardScreen(),
      //   ),
      // );
    }
  }

  void storeBearerToken(String token, String chatUserName, String chatUserId,
      String isDoctorAdmin) async {
    _pref.setBool(AppConfig.isLogin, true);
    await _pref.setString(AppConfig().bearerToken, token);
    _pref.setString("chatUserName", chatUserName);
    _pref.setString("chatUserId", chatUserId);
    _pref.setString("isDoctorAdmin", isDoctorAdmin);
  }
}
