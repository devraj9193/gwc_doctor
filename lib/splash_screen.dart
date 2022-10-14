import 'dart:async';
import 'package:doctor_app_new/login_screens/doctor_login.dart';
import 'package:doctor_app_new/screens/dashboard_screens/dashboard_screen.dart';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:doctor_app_new/widgets/background_widget.dart';
import 'package:doctor_app_new/utils/constants.dart';
import 'package:doctor_app_new/widgets/will_pop_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  String loginStatus = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      loginStatus = preferences.getString(AppConfig().bearerToken)!;
      print("Token: $loginStatus");
    });
  }

  @override
  void initState() {
    getPref();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 1;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              physics:const NeverScrollableScrollPhysics(),
              reverse: false,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                splashImage(),
                (loginStatus.isNotEmpty)
                    ? const DashboardScreen()
                    : const DoctorLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  splashImage1() {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: gSecondaryColor,
            child: const Image(
              image: AssetImage("assets/images/Group 2657.png"),
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Image(
              image: AssetImage("assets/images/Gut wellness logo green.png"),
            ),
          ),
        ],
      );
    });
  }

  splashImage() {
    return const BackgroundWidget(
      assetName: 'assets/images/Group 2657.png',
      child: Center(
        child: Image(
          image: AssetImage("assets/images/Gut wellness logo green.png"),
        ),
        // SvgPicture.asset(
        //     "assets/images/splash_screen/Splash screen Logo.svg"),
      ),
    );
  }
}
