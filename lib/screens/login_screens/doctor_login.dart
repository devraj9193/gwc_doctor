import 'dart:async';

import 'package:country_code_picker_mp/country_code_picker.dart';
import 'package:doctor_app_new/screens/login_screens/resend_otp_screen.dart';
import 'package:doctor_app_new/screens/dashboard_screens/dashboard_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../controller/repository/api_service.dart';
import '../../controller/repository/login_otp_repository.dart';
import '../../controller/services/login_otp_service.dart';
import '../../controller/services/quick_blox_service.dart';
import '../../model/doctor_profile_service/doctor_profile_repo.dart';
import '../../model/doctor_profile_service/doctor_profile_service.dart';
import '../../model/doctor_profile_service/user_profile_model.dart';
import '../../model/error_model.dart';
import '../../model/login_model/login_otp_model.dart';
import '../../model/login_model/resend_otp_model.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';
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

  Timer? _timer;
  int _resendTimer = 0;

  bool enableResendOtp = false;

  void startTimer() {
    _resendTimer = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_resendTimer == 0) {
          setState(() {
            timer.cancel();
            enableResendOtp = true;
          });
        } else {
          setState(() {
            _resendTimer--;
          });
        }
      },
    );
  }

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
    if (_timer != null) {
      _timer!.cancel();
    }
    _phoneFocus.removeListener(() {});
    phoneController.dispose();
    otpController.removeListener(() {});
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
                    padding:
                        EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 9.h,
                          child: const Image(
                            image: AssetImage(
                                "assets/images/Gut wellness logo.png"),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        Text(
          "Welcome To,",
          style: LoginScreen().welcomeText(),
        ),
        SizedBox(height: 1.h),
        Text(
          "Doctor App",
          style: LoginScreen().doctorAppText(),
        ),
        SizedBox(height: 5.h),
        Text(
          "Mobile Number",
          style: LoginScreen().textFieldHeadings(),
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
                    cursorColor: newBlackColor,
                    textAlignVertical: TextAlignVertical.center,
                    controller: phoneController,
                    style: LoginScreen().mainTextField(),
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
                        color: newBlackColor,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                      suffixIcon: !isPhone(phoneController.value.text)
                          ? phoneController.text.isEmpty
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    phoneController.clear();
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: newBlackColor,
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
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: !(otpMessage
                                        .toLowerCase()
                                        .contains('otp sent')),
                                    child: Text(
                                      'Get OTP',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: eUser().fieldSuffixTextFont,
                                        color: eUser().fieldSuffixTextColor,
                                        fontSize:
                                            eUser().fieldSuffixTextFontSize,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    (otpMessage
                                            .toLowerCase()
                                            .contains('otp sent'))
                                        ? Icons.check_circle_outline
                                        : Icons.keyboard_arrow_right,
                                    color: gPrimaryColor,
                                    size: 22,
                                  ),
                                ],
                              ),
                              // child: Icon(
                              //   (otpMessage.toLowerCase().contains('otp sent')) ? Icons.check_circle_outline : Icons.keyboard_arrow_right,
                              //   color: gPrimaryColor,
                              //   size: 22,
                              // ),
                            ),
                      hintText: "MobileNumber",
                      hintStyle: LoginScreen().hintTextField(),
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
        SizedBox(height: 2.h),
        Visibility(visible: otpSent, child: SizedBox(height: 2.h)),
        Visibility(
          visible: otpSent,
          child: Text(
            otpMessage,
            style: TextStyle(
                fontFamily: "GothamMedium",
                color: newBlackColor,
                fontSize: 8.5.sp),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Enter your OTP",
          style: LoginScreen().textFieldHeadings(),
        ),
        Form(
          autovalidateMode: AutovalidateMode.disabled,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 3.h),
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
              style: LoginScreen().mainTextField(),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock_outline_sharp,
                  color: newBlackColor,
                ),
                isDense: true,
                // fillColor: MainTheme.fillColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                hintText: "OTP",
                hintStyle: LoginScreen().hintTextField(),
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
                      color: otpVisibility ? gPrimaryColor : mediumTextColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (_resendTimer != 0 || !enableResendOtp)
                  ? null
                  : () {
                      getOtp(phoneController.text);
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => ResendOtpScreen()));
                    },
              child: Text(
                "Resend OTP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decorationThickness: 3,
                  // decoration: TextDecoration.underline,
                  fontFamily: eUser().resendOtpFont,
                  color: (_resendTimer != 0 || !enableResendOtp)
                      ? eUser().userTextFieldHintColor
                      : eUser().resendOtpFontColor,
                  fontSize: eUser().resendOtpFontSize,
                ),
              ),
            ),
            Visibility(
              visible: _resendTimer != 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timelapse_rounded,
                    size: 12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(_resendTimer.toString(),
                      style: TextStyle(
                        fontFamily: eUser().resendOtpFont,
                        color: eUser().resendOtpFontColor,
                        fontSize: eUser().resendOtpFontSize,
                      )),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        Center(
          child: GestureDetector(
            onTap: (showLoginProgress)
                ? null
                : () {
                    if (mobileFormKey.currentState!.validate() &&
                        phoneController.text.isNotEmpty &&
                        otpController.text.isNotEmpty) {
                      login(phoneController.text, otpController.text,
                          );
                    }
                  },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 7.w),
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
              decoration: BoxDecoration(
                color:gSecondaryColor,
                    // (phoneController.text.isEmpty || otpController.text.isEmpty)
                    //     ? whiteTextColor
                    //     : gSecondaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: gSecondaryColor,
                    // (phoneController.text.isEmpty ||
                    //         otpController.text.isEmpty)
                    //     ? lightTextColor
                    //     : gSecondaryColor,
                    width: 1),
              ),
              child: (showLoginProgress)
                  ? buildThreeBounceIndicator(color: whiteTextColor)
                  : Center(
                      child: Text(
                        'Login',
                        style: LoginScreen().buttonText(whiteTextColor,
                          // (phoneController.text.isEmpty ||
                          //         otpController.text.isEmpty)
                          //     ? whiteTextColor
                          //     : whiteTextColor,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
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
    startTimer();
    print("get otp");
    final result = await _loginWithOtpService.getOtpService(phoneNumber);

    if (result.runtimeType == GetOtpResponse) {
      GetOtpResponse model = result as GetOtpResponse;
      setState(() {
        otpMessage = "OTP Sent";
        otpController.text = result.otp!;
      });
      Future.delayed(Duration(seconds: 2)).whenComplete(() {
        setState(() {
          otpSent = false;
          _resendTimer = 0;
        });
      });
      _timer!.cancel();
    } else {
      setState(() {
        otpSent = false;
      });
      ErrorModel response = result as ErrorModel;
      _timer!.cancel();
      _resendTimer = 0;
      AppConfig().showSnackBar(context, response.message!, isError: true);
    }
  }

  login(String phone, String otp) async {
    setState(() {
      showLoginProgress = true;
    });
    print("---------Login---------");

    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value!;
        print("Device Token is Login: $deviceToken");
      });
    });

    final result =
        await _loginWithOtpService.loginWithOtpService(phone, otp, deviceToken!);

    if (result.runtimeType == LoginOtpModel) {
      LoginOtpModel model = result as LoginOtpModel;
      setState(() {
        showLoginProgress = false;
      });
      final qbService = Provider.of<QuickBloxService>(context, listen:  false);
      qbService.kaleyraLogin(
          model.userKaleyraId.toString());
      // _qbService.login("${model.loginUsername}");

      print("model.userEvaluationStatus: ${model.userEvaluationStatus}");

      // _pref.setString(AppConfig.EVAL_STATUS, model.userEvaluationStatus!);
      storeBearerToken(
        model.accessToken ?? '',
        model.loginUsername.toString(),
        model.chatId.toString(),
        model.isDoctorAdmin.toString(),
        model.userKaleyraId.toString(),
      );
      print("Login_Username : ${model.loginUsername}");
      print("chat_id : ${model.chatId}");
      storeUserProfile("${model.accessToken}");
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

  final DoctorMemberProfileRepository userRepository =
  DoctorMemberProfileRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  void storeUserProfile(String accessToken) async {
    final profile =
    await DoctorMemberProfileService(repository: userRepository)
        .getDoctorMemberProfileService(accessToken);
    if (profile.runtimeType == GetUserModel) {
      GetUserModel model1 = profile as GetUserModel;
      print("model1.datqbUserIda!.: ${model1.data!.address}");

      _pref.setString(GwcApi.successMemberName, model1.data?.name ?? "");
      _pref.setString(GwcApi.successMemberProfile, model1.data?.profile ?? "");
      _pref.setString(GwcApi.successMemberAddress, model1.data?.phone ?? "");

      print("Success Name : ${_pref.getString(GwcApi.successMemberName)}");
      print(
          "Success Profile : ${_pref.getString(GwcApi.successMemberProfile)}");
      print(
          "Success Address : ${_pref.getString(GwcApi.successMemberAddress)}");
    }
  }

  void storeBearerToken(String token, String chatUserName, String chatUserId,
      String isDoctorAdmin,String kaleyraUserId,) async {
    _pref.setBool(AppConfig.isLogin, true);
    await _pref.setString(AppConfig().bearerToken, token);
    _pref.setString(AppConfig.QB_USERNAME, chatUserName);
    _pref.setString(AppConfig.QB_CURRENT_USERID, chatUserId);
    // _pref.setString("chatUserName", chatUserName);
    // _pref.setString("chatUserId", chatUserId);
    _pref.setString("isDoctorAdmin", isDoctorAdmin);
    _pref.setString("kaleyraUserId", kaleyraUserId);

    print("model1. after: ${_pref.getString(AppConfig.QB_CURRENT_USERID)}");
    print("model1. after: ${_pref.getString(AppConfig.QB_USERNAME)}");
    print("Kaleyra Chat Id : ${_pref.getString("kaleyraUserId")}");

  }
}
